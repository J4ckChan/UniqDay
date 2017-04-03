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

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.layer.cornerRadius                = 5;
        self.clipsToBounds                     = YES;

        _imageView                         = [[UIImageView alloc]init];

        self.backgroundColor                   = [UIColor whiteColor];

        _titleLabel                        = [[UILabel alloc]init];
        _titleLabel.font                   = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];

        _timeLabel                         = [[UILabel alloc]init];
        _timeLabel.font                    = [UIFont systemFontOfSize:14];

        _dayCountlabel                     = [[UILabel alloc]init];
        _dayCountlabel.font                = [UIFont systemFontOfSize:30 weight:UIFontWeightLight];
        _dayCountlabel.textColor           = [UIColor lightGrayColor];

        _daysSinceLabel                    = [[UILabel alloc]init];
        _daysSinceLabel.text               = @"DAYS SINCE";
        _daysSinceLabel.textAlignment      = NSTextAlignmentCenter;
        _daysSinceLabel.textColor          = [UIColor whiteColor];
        _daysSinceLabel.font               = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
        _daysSinceLabel.backgroundColor    = [UIColor lightGrayColor];
        _daysSinceLabel.layer.cornerRadius = 2;
        _daysSinceLabel.clipsToBounds      = YES;

        [self addSubview:_imageView];
        [self addSubview:_titleLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_dayCountlabel];
        [self addSubview:_daysSinceLabel];
        
        CGFloat imageViewHeight = ([UIScreen mainScreen].bounds.size.height - 120 - 32)/7.0 * 5.0;
        NSNumber *imageViewHeightNum = [NSNumber numberWithFloat:imageViewHeight];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(imageViewHeightNum);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).offset(8);
            make.left.equalTo (self).offset(16);
            make.right.equalTo(self).offset(-16);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_titleLabel);
        }];
        
        [_dayCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.bottom.equalTo(self).offset(-8);
            make.width.equalTo(@200);
        }];
        
        _daysSinceLabel.text = NSLocalizedString(@"DAYS SINCE", nil);

        [_daysSinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(_dayCountlabel);
            make.width.equalTo(@76);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

@end
