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

@interface UNDViewController ()

@property (nonatomic,strong) UNDAddCardView *addCardView;

@end

@implementation UNDViewController

@synthesize addCardView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    //test CardView
    CGFloat viewWidth        = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight       = [UIScreen mainScreen].bounds.size.height;
//    UNDCardView *cardView    = [[UNDCardView alloc]initWithFrame:CGRectMake(16, 70, viewWidth - 32, viewHeight - 140)];
//    
//    cardView.backgroundColor = [UIColor whiteColor];
//    cardView.clipsToBounds   = YES;
//    cardView.layer.cornerRadius = 5;
//    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:cardView];
    
    //addCardView
    self.addCardView = [[UNDAddCardView alloc]initWithFrame:CGRectMake(8, viewHeight - 248, viewWidth - 16, 240)];
    [self.view addSubview:self.addCardView];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:kRaiseAddCardViewNotification object:nil]
     subscribeNext:^(NSNotification *notification) {
        [self raiseAddCardView];
    }];

    [[self.addCardView cancelSignal] subscribeNext:^(id x) {
        [self dismissAddCardView];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - AddCardView 

- (void)raiseAddCardView{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint orignialCenter = self.addCardView.center;
        self.addCardView.center = CGPointMake(orignialCenter.x, orignialCenter.y - 260);
    }];
}

- (void)dismissAddCardView{
    
    //dismiss keyboard
    NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
    UNDTitleTableViewCell *cell = [self.addCardView.tableView cellForRowAtIndexPath:indePath];
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField*)view;
            [textField resignFirstResponder];
        }
    }
    
    //dismiss AddCardView
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center0 = self.addCardView.center;
        CGFloat centerY = [UIScreen mainScreen].bounds.size.height + self.addCardView.frame.size.height/2;
        self.addCardView.center = CGPointMake(center0.x, centerY);
    }];
}

@end
