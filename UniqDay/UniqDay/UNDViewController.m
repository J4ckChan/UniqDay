//
//  UNDViewController.m
//  UniqDay
//
//  Created by ChanLiang on 28/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//

#import "UNDViewController.h"


//views
#import "UNDCardView.h"
#import "UNDAddCardView.h"
#import "UNDScrollView.h"

//ViewModel
#import "UNDAddCardViewModel.h"

//Vendors
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>

@interface UNDViewController ()

@property (nonatomic,strong) UNDAddCardView *addCardView;
@property (nonatomic,strong) UIDatePicker *datePicker;

//ViewModel
@property (nonatomic,strong) UNDAddCardViewModel *addCardViewModel;

@end

@implementation UNDViewController{
    CGFloat _viewWidth;
    CGFloat _viewHeight;
}

@synthesize addCardView,datePicker,addCardViewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewWidth  = [UIScreen mainScreen].bounds.size.width;
    _viewHeight = [UIScreen mainScreen].bounds.size.height;

    self.view.backgroundColor = [UIColor colorWithRed:20 green:22 blue:27 alpha:0];
    
    UNDScrollView *scrollView = [[UNDScrollView alloc]init];
    [self.view addSubview:scrollView];
    CGFloat scrollViewHeight = _viewHeight - 120;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(@(scrollViewHeight));
    }];

    //add +
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [self.view addSubview:addBtn];
    
    CGSize size = CGSizeMake(32, 32);
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.bottom.equalTo(self.view).offset(-24);
        make.size.mas_equalTo(size);
    }];
    
    [[addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self showAddCardView];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AddCardView 

- (void)showAddCardView{
    
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
    
    //dismiss AddCardView
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center0 = self.addCardView.center;
        CGFloat centerY = [UIScreen mainScreen].bounds.size.height + self.addCardView.frame.size.height/2;
        self.addCardView.center = CGPointMake(center0.x, centerY);
    } completion:^(BOOL finished) {
        [self.addCardView clearData];
    }];
}

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
        [[self.datePicker rac_newDateChannelWithNilValue:nil]
         subscribeNext:^(NSDate *date) {
             NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
             dateFormatter.dateStyle = kCFDateFormatterMediumStyle;
             NSString *dateStr = [dateFormatter stringFromDate:date];
             
             NSIndexPath *indePath = [NSIndexPath indexPathForRow:1 inSection:0];
             UNDDateTableViewCell *cell = [self.addCardView.tableView cellForRowAtIndexPath:indePath];
             [cell.dateBtn setTitle:dateStr forState:UIControlStateNormal];
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
        }];
        [self.datePicker removeFromSuperview];
        self.datePicker = nil;
    }
}


@end
