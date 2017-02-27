//
//  UNDViewController.m
//  UniqDay
//
//  Created by ChanLiang on 28/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//

#import "UNDViewController.h"

//models
#import "UNDCard.h"

//views
#import "UNDCardView.h"
#import "UNDAddCardView.h"
#import "UNDTopBarView.h"
#import "UNDToolsBar.h"
#import "UNDScrollView.h"
#import "UNDBottomBarView.h"

//ViewModel
#import "UNDAddCardViewModel.h"

//Vendors
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>

@interface UNDViewController ()

@property (nonatomic,strong) UNDTopBarView *topBar;
@property (nonatomic,strong) UNDScrollView *scrollView;
@property (nonatomic,strong) UNDBottomBarView *bottomBar;
@property (nonatomic,strong) UNDAddCardView *addCardView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIVisualEffectView *addCardBgView;

//ViewModel
@property (nonatomic,strong) UNDAddCardViewModel *addCardViewModel;

//realm
@property (nonatomic,strong) RLMNotificationToken *token;

//constraints
@property (nonatomic,strong) NSMutableArray *antimationConstraints;

@end

@implementation UNDViewController{
    CGFloat _viewWidth;
    CGFloat _viewHeight;
    int refreshScrollViewTag;
}

@synthesize addCardView,datePicker,addCardViewModel;

#pragma mark - life cycle 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewWidth  = [UIScreen mainScreen].bounds.size.width;
    _viewHeight = [UIScreen mainScreen].bounds.size.height;

    self.view.backgroundColor = [UIColor colorWithRed:20 green:22 blue:27 alpha:0];
    
    [self addTopBar];
    [self initOrRefreshScrollView];
    [self addBottomBar];
    
    [self addRealmNotifcationObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.token stop];
}

#pragma mark - TopBarView & ScrollView & BottomBarView

- (void)addTopBar{
    self.topBar = [[UNDTopBarView alloc]init];
    [self.view addSubview:self.topBar];
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(16);
        make.width.mas_equalTo(_viewWidth);
        make.height.mas_equalTo(36);
    }];
    
    [self.topBar.rac_moreSignal subscribeNext:^(id x) {
        [self showToolBar];
    }];
}

- (void)initOrRefreshScrollView{
    if (self.scrollView != nil) {
        [self.scrollView removeFromSuperview];
        self.scrollView = nil;
    }
    self.antimationConstraints = [NSMutableArray new];
    self.scrollView = [[UNDScrollView alloc]init];
    [self.view addSubview:self.scrollView];
    CGFloat scrollViewHeight = _viewHeight - 120;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.antimationConstraints = [NSMutableArray arrayWithArray:@[
        make.top.equalTo(self.topBar.mas_bottom).offset(8)
        ]];
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(@(scrollViewHeight));
    }];
}

- (void)addBottomBar{
    self.bottomBar = [[UNDBottomBarView alloc]init];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.antimationConstraints addObject:
         make.top.equalTo(self.scrollView.mas_bottom).offset(8)
         ];
        make.width.mas_equalTo(_viewWidth);
        make.height.mas_equalTo(44);
    }];
    
    [self.bottomBar.rac_addCardSignal subscribeNext:^(id x) {
        [self showAddCardView];
    }];
}

#pragma mark - ToolBar

- (void)showToolBar{
    
    self.topBar.alpha = 0.2;
    self.scrollView.alpha = 0.2;
    self.bottomBar.alpha = 0.2;
    
    for (MASConstraint *constraint in self.antimationConstraints) {
        constraint.offset = 60;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    UNDToolsBar *toolsBar = [[UNDToolsBar alloc]init];
//    toolsBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolsBar];
    
    [toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBar.mas_bottom);
        make.width.equalTo(self.view);
        make.height.equalTo(@60);
    }];
}

#pragma mark - AddCardView 

- (void)showAddCardView{
    
    [self showAddCardViewBackgroundView];
    
    CGRect addCardViewFrame0 = CGRectMake(8, _viewHeight - 264, _viewWidth - 16, 256);
    CGRect addCardViewFrame1 = CGRectMake(8, _viewHeight, _viewWidth - 16, 256);

    //init addCardViewModel
    self.addCardViewModel = [[UNDAddCardViewModel alloc]init];
    
    if (self.addCardView == nil) {
        self.addCardView = [[UNDAddCardView alloc]initWithFrame:addCardViewFrame1];
        [self.view addSubview:self.addCardView];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.addCardView.frame = addCardViewFrame0;
    } completion:^(BOOL finished) {
        //rac -- notification
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRaiseAddCardViewNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [self raiseAddCardView];
         }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRaiseDatePickerNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [self raiseDatePicker];
         }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kAddImageNotification object:nil]
         subscribeNext:^(id x) {
             //add image action
         }];
        
        //rac
        [[self.addCardView cancelSignal] subscribeNext:^(id x) {
            [self dismissAddCardView];
        }];
        
        [self.addCardView.doneSignal subscribeNext:^(id x) {
            [self addCardModelResult];
        }];
        
        RAC(self.addCardViewModel,title) = self.addCardView.rac_titleSignal;
        RAC(self.addCardViewModel,image) = self.addCardView.rac_imageSignal;
    }];
}


- (void)raiseAddCardView{
    
    CGPoint orignialCenter = self.addCardView.center;
    
    CGFloat height = 216;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - height;
    
    [self dismissDatePicker];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addCardView.center = CGPointMake(orignialCenter.x, top - 178);
    }];
}

- (void)dismissAddCardView{
    
    [self.addCardView dismissKeyboard];
    [self dismissDatePicker];
    [self dimissAddCardViewBackgroundView];
    
    //dismiss AddCardView
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center0 = self.addCardView.center;
        CGFloat centerY = [UIScreen mainScreen].bounds.size.height + self.addCardView.frame.size.height/2;
        self.addCardView.center = CGPointMake(center0.x, centerY);
    } completion:^(BOOL finished) {
        [self.addCardView removeFromSuperview];
        self.addCardView = nil;
    }];
}

#pragma mark - Date Picker

- (void)raiseDatePicker{
    
    [self.addCardView dismissKeyboard];
    
    CGRect addCardViewFrame0 = self.addCardView.frame;
    
    CGFloat height = 216;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.addCardView.frame = CGRectMake(addCardViewFrame0.origin.x,top - 264, addCardViewFrame0.size.width, addCardViewFrame0.size.height);
    }];
    
    if (self.datePicker == nil) {
        self.datePicker = [[UIDatePicker alloc]init];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        self.datePicker.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        [self.view addSubview:self.datePicker];
        
        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets insets = UIEdgeInsetsMake(top, 0, 0, 0);
            make.edges.equalTo(self.view).insets(insets);
        }];
        
        //rac
        [[self.datePicker rac_newDateChannelWithNilValue:[NSDate date]]
         subscribeNext:^(NSDate *date) {
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
             dateFormatter.dateStyle = kCFDateFormatterMediumStyle;
             NSString *dateStr = [dateFormatter stringFromDate:date];
             
             NSIndexPath *indePath = [NSIndexPath indexPathForRow:1 inSection:0];
             UNDDateTableViewCell *cell = [self.addCardView.tableView cellForRowAtIndexPath:indePath];
             [cell.dateBtn setTitle:dateStr forState:UIControlStateNormal];
             [cell.dateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             self.addCardViewModel.date = date;
         }];
    }
}

- (void)dismissDatePicker{
    if (self.datePicker != nil) {
        [UIView animateWithDuration:0.2 animations:^{
            CGPoint center0 = self.datePicker.center;
            CGFloat centerY = [UIScreen mainScreen].bounds.size.height + self.datePicker.frame.size.height/2;
            self.datePicker.center = CGPointMake(center0.x, centerY);
        } completion:^(BOOL finished) {
            [self.datePicker removeFromSuperview];
            self.datePicker = nil;
        }];
    }
}

#pragma mark - AddCardViewBackgroundView

- (void)showAddCardViewBackgroundView{
    //Blur Effect
    if (self.addCardBgView == nil) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.addCardBgView       = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        self.addCardBgView.frame = self.view.frame;
        [self.view addSubview:self.addCardBgView];
    }
}

- (void)dimissAddCardViewBackgroundView{
    if (self.addCardBgView != nil) {
        [UIView animateWithDuration:0.1 animations:^{
            self.addCardBgView.center = CGPointMake(_viewWidth/2.0, _viewHeight * 1.5);
        }completion:^(BOOL finished) {
            [self.addCardBgView removeFromSuperview];
            self.addCardBgView = nil;
        }];
    }
}


#pragma mark - Realm

- (void)addRealmNotifcationObserver{
    __weak typeof(self) weakSelf = self;
    self.token = [[UNDCard allObjects] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Failed to open Realm on background worker: %@", error);
            return;
        }
        
        if (!change) {
            return;
        }
        
        [weakSelf initOrRefreshScrollView];
    }];
}

#pragma mark - else

- (void)addCardModelResult{
    UNDAddCardModelResult result = [self.addCardViewModel addCardModel];
    NSString *message;
    switch (result) {
        case UNDAddCardModelTitleFailure:
            message = NSLocalizedString(@"Please Enter Title!", nil);
            break;
        case UNDAddCardModelDateFailure:
            message = NSLocalizedString(@"Please Enter Date!", nil);
            break;
        case UNDAddCardModelImageFailure:
            message = NSLocalizedString(@"Please Add Image!", nil);
            break;
        case UNDAddCardModelSuccess:
            [self dismissAddCardView];
            break;
    }
    
    if (result != UNDAddCardModelSuccess) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Warning", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:NSLocalizedString(@"Done", nil) style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
