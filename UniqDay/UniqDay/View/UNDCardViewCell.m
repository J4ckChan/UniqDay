//
//  UNDCardViewCell.m
//  UniqDay
//
//  Created by ChanLiang on 17/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewCell.h"
#import <Masonry/Masonry.h>

#import "UNDCardViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UNDCardViewCell

@synthesize imageView,titleLabel,timeLabel,dayCountlabel;


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.cornerRadius                = 5;
        self.contentView.clipsToBounds                     = YES;
        
        self.imageView                         = [[UIImageView alloc]init];
        
        self.contentView.backgroundColor                   = [UIColor whiteColor];
        
        self.titleLabel                        = [[UILabel alloc]init];
        self.titleLabel.font                   = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        
        self.timeLabel                         = [[UILabel alloc]init];
        self.timeLabel.font                    = [UIFont systemFontOfSize:14];
        
        self.dayCountlabel                     = [[UILabel alloc]init];
        self.dayCountlabel.font                = [UIFont systemFontOfSize:30 weight:UIFontWeightLight];
        self.dayCountlabel.textColor           = [UIColor lightGrayColor];
        
        self.daysSinceLabel                    = [[UILabel alloc]init];
        self.daysSinceLabel.text               = @"DAYS SINCE";
        self.daysSinceLabel.textAlignment      = NSTextAlignmentCenter;
        self.daysSinceLabel.textColor          = [UIColor whiteColor];
        self.daysSinceLabel.font               = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
        self.daysSinceLabel.backgroundColor    = [UIColor lightGrayColor];
        self.daysSinceLabel.layer.cornerRadius = 2;
        self.daysSinceLabel.clipsToBounds      = YES;
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.dayCountlabel];
        [self.contentView addSubview:self.daysSinceLabel];
        
        CGFloat imageViewHeight = ([UIScreen mainScreen].bounds.size.height - 120 - 32)/7.0 * 5.0;
        NSNumber *imageViewHeightNum = [NSNumber numberWithFloat:imageViewHeight];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(imageViewHeightNum);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(8);
            make.left.equalTo (self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
            make.left.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel);
        }];
        
        [self.dayCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.width.equalTo(@200);
        }];
        
        self.daysSinceLabel.text = NSLocalizedString(@"DAYS SINCE", nil);
        
        [self.daysSinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.dayCountlabel);
            make.width.equalTo(@76);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

- (void)setViewModel:(UNDCardViewModel *)viewModel{

    _viewModel = viewModel;
    
    self.imageView.image         = self.viewModel.image;
    self.titleLabel.text         = self.viewModel.title;
    self.timeLabel.text          = self.viewModel.dateStr;
    self.dayCountlabel.text      = self.viewModel.dayCountStr;

}


- (void)configureCardViewCellWithViewModel{
    
    if (!self.viewModel) {
        return;
    }
    //Init
    self.imageView.image         = self.viewModel.image;
    self.titleLabel.text         = self.viewModel.title;
    self.timeLabel.text          = self.viewModel.dateStr;
    self.dayCountlabel.text      = self.viewModel.dayCountStr;
    
    //RAC Bindinhg
    RAC(self.imageView,image)    = RACObserve(self.viewModel, image);
    RAC(self.titleLabel,text)    = RACObserve(self.viewModel, title);
    RAC(self.timeLabel,text)     = RACObserve(self.viewModel, dateStr);
    RAC(self.dayCountlabel,text) = RACObserve(self.viewModel, dayCountStr);
}

@end
