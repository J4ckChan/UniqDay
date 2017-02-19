//
//  UNDCardView.m
//  UniqDay
//
//  Created by ChanLiang on 07/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardView.h"
#import <Masonry/Masonry.h>

@interface UNDCardView ()

@property (nonatomic,strong) UILabel *daysSinceLabel;

@end

@implementation UNDCardView

@synthesize imageView,titleLabel,timeLabel,dayCountlabel;

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius                = 5;
        self.clipsToBounds                     = YES;

        self.imageView                         = [[UIImageView alloc]init];

        self.backgroundColor                   = [UIColor whiteColor];

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

        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.dayCountlabel];
        [self addSubview:self.daysSinceLabel];
        
        CGFloat imageViewHeight = ([UIScreen mainScreen].bounds.size.height - 120 - 32)/7.0 * 5.0;
        NSNumber *imageViewHeightNum = [NSNumber numberWithFloat:imageViewHeight];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(imageViewHeightNum);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(8);
            make.left.equalTo (self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(2);
            make.left.equalTo(self.titleLabel);
            make.right.equalTo(self.titleLabel);
        }];
        
        [self.dayCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.bottom.equalTo(self).offset(-8);
            make.width.equalTo(@200);
        }];
        
        self.daysSinceLabel.text = NSLocalizedString(@"DAYS SINCE", nil);

        [self.daysSinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(self.dayCountlabel);
            make.width.equalTo(@76);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

@end
