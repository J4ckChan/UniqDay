//
//  UNDShareCardViewController.m
//  UniqDay
//
//  Created by ChanLiang on 11/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDShareCardViewController.h"

#import "UNDCard.h"

#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UNDShareCardViewController ()

@property (nonatomic,strong) UNDCard *model;
@property (nonatomic,strong) UIImageView *shareCardView;

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
    [self layoutShareCardWithModel:_model];
    [self layoutBottonSubviews];
    
}

-(void)layoutTopSubview{
    self.view.backgroundColor = [UIColor blackColor];
    
    UILabel *titleLabel    = [[UILabel alloc]init];
    titleLabel.text        = NSLocalizedString(@"Share", nil);
    titleLabel.textColor   = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    UIButton *dismissBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
    [dismissBtn setImage:[UIImage imageNamed:@"closedBtn"] forState:UIControlStateNormal];
    dismissBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return [RACSignal empty];
    }];
    
    [self.view addSubview:dismissBtn];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(20);
    }];
    
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
    }];
}

-(void)layoutShareCardWithModel:(UNDCard *)model{
    
    CGFloat edge = self.view.frame.size.width - 40;
    UIImage *image = [[UIImage alloc]initWithData:model.imageData];
    _shareCardView = [[UIImageView alloc]initWithImage:image];
//    _shareCardView.layer.cornerRadius = 6;
//    _shareCardView.clipsToBounds = YES;
    [self.view addSubview:_shareCardView];
    
    [_shareCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(edge, edge));
    }];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = model.title;
    title.textColor = [UIColor whiteColor];
    title.font = [UIFont systemFontOfSize:26 weight:UIFontWeightBold];
    [_shareCardView addSubview:title];
    
    CGFloat padding = 15;
    UIEdgeInsets titleLabelInsets = UIEdgeInsetsMake(padding, padding, edge - padding - 40, padding);
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_shareCardView).insets(titleLabelInsets);
    }];
    
    UILabel *dayCount = [[UILabel alloc]init];
    dayCount.text = [self dayCountFromNow:model.date];
    dayCount.textColor = [UIColor whiteColor];
    dayCount.font = [UIFont systemFontOfSize:34 weight:UIFontWeightHeavy];
    [_shareCardView addSubview:dayCount];
    
    [dayCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_shareCardView).offset(padding);
        make.bottom.equalTo(_shareCardView).offset(-padding);
    }];
    
    UILabel *date = [[UILabel alloc]init];
    date.text = [NSString stringWithFormat:@"DAYS SINCE\n%@",[self dateString:model.date]];
    date.numberOfLines = 0;
    date.textColor = [UIColor whiteColor];
    date.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    [_shareCardView addSubview:date];
    
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dayCount.mas_right).offset(padding);
        make.top.equalTo(dayCount.mas_top);
    }];
    
}

-(void)layoutBottonSubviews{
    
    UIButton *wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatBtn setImage:[UIImage imageNamed:@"wechatBtn"] forState:UIControlStateNormal];
    [self.view addSubview:wechatBtn];

    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_bottom).offset(-50);
    }];

    UIButton *weiboBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboBtn setImage:[UIImage imageNamed:@"weiboBtn"] forState:UIControlStateNormal];
    [self.view addSubview:weiboBtn];

    CGFloat midCenterX  = self.view.center.x/2;

    [weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(-midCenterX);
        make.centerY.equalTo(self.view.mas_bottom).offset(-50);
    }];

    UIButton *photoBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"photoBtn"] forState:UIControlStateNormal];
    [self.view addSubview:photoBtn];

    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view).offset(midCenterX);
        make.centerY.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    //RAC Binding
    photoBtn.rac_command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        [self saveToLocalPhoto];
        return [RACSignal empty];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -IBActions

- (void)saveToLocalPhoto{
    UIImage *image = [self clipView:_shareCardView];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (UIImage *)clipView:(UIView *)view{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)dayCountFromNow:(NSDate *)date{
    NSTimeInterval timeInter = date.timeIntervalSinceNow;
    double dayDouble = timeInter/(24*3600);
    int dayInt = (int)dayDouble;
    NSString *dayStr;
    if (dayInt >= 0) {
        dayStr = [NSString stringWithFormat:@"D+%d",dayInt];
    }else{
        dayStr = [NSString stringWithFormat:@"D%d",dayInt];
    }
    return dayStr;
}

- (NSString *)dateString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MMMM d, YYYY";
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



@end
