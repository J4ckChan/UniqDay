//
//  UNDShareCardViewController.m
//  UniqDay
//
//  Created by ChanLiang on 11/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDShareCardViewController.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UNDShareCardViewController ()

@property (nonatomic,strong) UNDCard *model;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *dismissBtn;

@end

@implementation UNDShareCardViewController

#pragma mark - View Life Cycle

- (instancetype)initWithModel:(UNDCard *)model
{
    self = [super init];
    if (self) {
        _model = model;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self layoutSubview];
}

- (void)layoutSubview{

    [self layoutTopSubview];
    [self layoutShareCard];
    [self layoutBottonSubviews];
    
}

-(void)layoutTopSubview{
    self.view.backgroundColor = [UIColor blackColor];
    
    _titleLabel             = [[UILabel alloc]init];
    _titleLabel.text        = NSLocalizedString(@"Share", nil);
    _titleLabel.textColor   = [UIColor whiteColor];
    [self.view addSubview:_titleLabel];
    
    _dismissBtn             = [UIButton buttonWithType:UIButtonTypeCustom];
    [_dismissBtn setImage:[UIImage imageNamed:@"closedBtn"] forState:UIControlStateNormal];
    _dismissBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal empty];
    }];
    
    [self.view addSubview:_dismissBtn];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
    [_dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
    }];
}

-(void)layoutShareCard{
    
}

-(void)layoutBottonSubviews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
