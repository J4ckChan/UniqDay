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

//rac
#import <ReactiveCocoa/ReactiveCocoa.h>

#import <Masonry/Masonry.h>

@interface UNDViewController ()

@property (nonatomic,strong) UNDAddCardView *addCardView;
@property (nonatomic,strong) UIDatePicker *datePicker;

@end

@implementation UNDViewController

@synthesize addCardView,datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:20 green:22 blue:27 alpha:0];
    
    
    //add +
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"addIcon"] forState:UIControlStateNormal];
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
    
    //test CardView
    CGFloat viewWidth        = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight       = [UIScreen mainScreen].bounds.size.height;
    
    CGRect addCardViewFrame0 = CGRectMake(8, viewHeight - 248, viewWidth - 16, 240);
    
    if (self.addCardView != nil) {
        [UIView animateWithDuration:0.2 animations:^{
            self.addCardView.frame = addCardViewFrame0;
        }];
    }else{
        //addCardView
        self.addCardView = [[UNDAddCardView alloc]initWithFrame:addCardViewFrame0];
        [self.view addSubview:self.addCardView];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRaiseAddCardViewNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [self raiseAddCardView];
         }];
        
        [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRaiseDatePickerNotification object:nil]
         subscribeNext:^(NSNotification *notification) {
             [self raiseDatePicker];
         }];
        
        [[self.addCardView cancelSignal] subscribeNext:^(id x) {
            [self dismissAddCardView];
        }];
    }
}


- (void)raiseAddCardView{
    
    CGPoint orignialCenter = self.addCardView.center;
    
    CGFloat height = 216;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - height;
    
    [self dismissDatePicker];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addCardView.center = CGPointMake(orignialCenter.x, top - 170);
    }];
}

- (void)dismissAddCardView{
    
    [self dismissKeyboard];
    [self dismissDatePicker];
    
    //dismiss AddCardView
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center0 = self.addCardView.center;
        CGFloat centerY = [UIScreen mainScreen].bounds.size.height + self.addCardView.frame.size.height/2;
        self.addCardView.center = CGPointMake(center0.x, centerY);
    }];
}

- (void)raiseDatePicker{
    
    [self dismissKeyboard];
    
    CGRect addCardViewFrame0 = self.addCardView.frame;
    
    CGFloat height = 216;
    CGFloat top = [UIScreen mainScreen].bounds.size.height - height;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.addCardView.frame = CGRectMake(addCardViewFrame0.origin.x,top - 248, addCardViewFrame0.size.width, addCardViewFrame0.size.height);
    }];
    
    if (self.datePicker == nil) {
        self.datePicker = [[UIDatePicker alloc]init];
        self.datePicker.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.datePicker];
        
        [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            UIEdgeInsets insets = UIEdgeInsetsMake(top, 0, 0, 0);
            make.edges.equalTo(self.view).insets(insets);
        }];
    }
}

- (void)dismissKeyboard{
    //dismiss keyboard
    NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
    UNDTitleTableViewCell *cell = [self.addCardView.tableView cellForRowAtIndexPath:indePath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)view;
            [textField resignFirstResponder];
        }
    }
}

- (void)dismissDatePicker{
    //dismiss datePicker
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
