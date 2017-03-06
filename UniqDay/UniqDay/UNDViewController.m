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
#import "UNDScrollViewModel.h"

//Vendors
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>

@interface UNDViewController ()

@property (nonatomic,strong) UNDTopBarView *topBar;
@property (nonatomic,strong) UNDToolsBar *toolsBar;
@property (nonatomic,strong) UIView *toolsBarBgView;
@property (nonatomic,strong) UNDScrollView *scrollView;
@property (nonatomic,strong) UNDBottomBarView *bottomBar;
@property (nonatomic,strong) UNDAddCardView *addCardView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) UIVisualEffectView *addCardBgView;

//ViewModel
@property (nonatomic,strong) UNDAddCardViewModel *addCardViewModel;
@property (nonatomic,strong) UNDScrollViewModel *scrollViewModel;

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

@synthesize addCardView,datePicker,addCardViewModel,toolsBar;

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewWidth  = [UIScreen mainScreen].bounds.size.width;
    _viewHeight = [UIScreen mainScreen].bounds.size.height;
    self.antimationConstraints = [NSMutableArray new];

    self.view.backgroundColor = [UIColor colorWithRed:20 green:22 blue:27 alpha:0];
    
    [self addTopBar];
    [self initScrollView];
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

- (void)initScrollView{
    
    self.scrollView = [[UNDScrollView alloc]init];
    self.scrollViewModel = [[UNDScrollViewModel alloc]init];
    self.scrollView.models = self.scrollViewModel.models;
    RAC(self.scrollView,models) = RACObserve(self.scrollViewModel, models);
    [self.scrollView generateContent];
    [self.view addSubview:self.scrollView];
    
    //layout
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

- (void)updateScrollView{
    [self.scrollViewModel updateCardModels];
    [self.scrollView generateContent];
}

- (void)addBottomBar{
    self.bottomBar = [[UNDBottomBarView alloc]init];
    [self.view addSubview:self.bottomBar];
    [self.bottomBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_bottom).offset(8);
        make.width.mas_equalTo(_viewWidth);
        make.height.mas_equalTo(44);
    }];
    
    [self.bottomBar.rac_addCardSignal subscribeNext:^(id x) {
        [self showAddCardView];
    }];
    
    [self.bottomBar.rac_dayCountOrder subscribeNext:^(id x) {
        [self.scrollViewModel sortByCountDay];
        [self.scrollView configureScorllViewWithModels];
    }];
    
    [self.bottomBar.rac_CreatedDateOder subscribeNext:^(id x) {
        [self.scrollViewModel sortByCreatedDate];
        [self.scrollView configureScorllViewWithModels];
    }];
}

#pragma mark - ToolBar

- (void)showToolBar{
    
    self.toolsBarBgView                 = [[UIView alloc]init];
    self.toolsBarBgView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap         = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideToolsBar)];
    [self.toolsBarBgView addGestureRecognizer:tap];
    [self.view addSubview:self.toolsBarBgView];
    [self.toolsBarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    self.topBar.alpha     = 0.2;
    self.scrollView.alpha = 0.2;
    self.bottomBar.alpha  = 0.2;

    for (MASConstraint *constraint in self.antimationConstraints) {
        constraint.offset = 100;
    }

    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

    self.toolsBar = [[UNDToolsBar alloc]init];
    [self.toolsBarBgView addSubview:toolsBar];

    [toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBar.mas_bottom);
        make.width.equalTo(self.toolsBarBgView);
        make.height.equalTo(@100);
    }];
}

- (void)hideToolsBar{
    
    for (MASConstraint *constraint in self.antimationConstraints) {
        constraint.offset = 8;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.toolsBar.frame = CGRectMake(0, 60, _viewWidth, 0);
        [self.toolsBar hideButtons];
        [self.view layoutSubviews];
    } completion:^(BOOL finished) {
        [self.toolsBar removeButtons];
        [self.toolsBar removeFromSuperview];
        self.toolsBar = nil;
        [self.toolsBarBgView removeFromSuperview];
        self.toolsBarBgView = nil;
        self.topBar.alpha = 1;
        self.scrollView.alpha = 1;
        self.bottomBar.alpha = 1;
    }];
}

#pragma mark - BottomBarView

#pragma mark - AddCardView 

- (void)showAddCardView{
    
    [self showAddCardViewBackgroundView];
    
    CGRect addCardViewFrame0 = CGRectMake(8, _viewHeight - 264, _viewWidth - 16, 256);
    CGRect addCardViewFrame1 = CGRectMake(8, _viewHeight, _viewWidth - 16, 256);
    
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
        
        [[self.addCardView rac_doneSignal] subscribeNext:^(id x) {
            [self addCardModelResult];
        }];
        
        
        //init addCardViewModel
        self.addCardViewModel = [[UNDAddCardViewModel alloc]init];
        self.addCardViewModel.title = nil;
        self.addCardViewModel.date  = nil;
        self.addCardViewModel.image = nil;

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
        
        [weakSelf updateScrollView];
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
