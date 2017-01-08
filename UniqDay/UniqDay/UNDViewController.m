//
//  UNDViewController.m
//  UniqDay
//
//  Created by ChanLiang on 28/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//

#import "UNDViewController.h"

#import "UNDCardView.h"

@interface UNDViewController ()

@end

@implementation UNDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //test CardView
    CGFloat viewWidth        = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight       = [UIScreen mainScreen].bounds.size.height;
    UNDCardView *cardView    = [[UNDCardView alloc]initWithFrame:CGRectMake(16, 70, viewWidth - 32, viewHeight - 140)];
    
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.clipsToBounds   = YES;
    cardView.layer.cornerRadius = 5;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:cardView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
