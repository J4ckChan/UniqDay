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

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.layer.cornerRadius = 5;
        self.contentView.clipsToBounds      = YES;
        self.contentView.backgroundColor    = [UIColor whiteColor];
        
        _imageView                          = [[UIImageView alloc]init];
        
        _titleLabel                         = [[UILabel alloc]init];
        _titleLabel.font                    = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];

        _timeLabel                          = [[UILabel alloc]init];
        _timeLabel.font                     = [UIFont systemFontOfSize:14];

        _dayCountlabel                      = [[UILabel alloc]init];
        _dayCountlabel.font                 = [UIFont systemFontOfSize:30 weight:UIFontWeightLight];
        _dayCountlabel.textColor            = [UIColor lightGrayColor];

        _daysSinceLabel                     = [[UILabel alloc]init];
        _daysSinceLabel.text                = @"DAYS SINCE";
        _daysSinceLabel.textAlignment       = NSTextAlignmentCenter;
        _daysSinceLabel.textColor           = [UIColor whiteColor];
        _daysSinceLabel.font                = [UIFont systemFontOfSize:11 weight:UIFontWeightBold];
        _daysSinceLabel.backgroundColor     = [UIColor lightGrayColor];
        _daysSinceLabel.layer.cornerRadius  = 2;
        _daysSinceLabel.clipsToBounds       = YES;

        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_timeLabel];
        [self.contentView addSubview:_dayCountlabel];
        [self.contentView addSubview:_daysSinceLabel];
        
        CGFloat imageViewHeight = ([UIScreen mainScreen].bounds.size.height - 120 - 32)/7.0 * 5.0;
        NSNumber *imageViewHeightNum = [NSNumber numberWithFloat:imageViewHeight];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(imageViewHeightNum);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_imageView.mas_bottom).offset(8);
            make.left.equalTo (self.contentView).offset(16);
            make.right.equalTo(self.contentView).offset(-16);
        }];
        
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_titleLabel.mas_bottom).offset(2);
            make.left.equalTo(_titleLabel);
            make.right.equalTo(_titleLabel);
        }];
        
        [_dayCountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.width.equalTo(@200);
        }];
        
        _daysSinceLabel.text = NSLocalizedString(@"DAYS SINCE", nil);
        
        [_daysSinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(_dayCountlabel);
            make.width.equalTo(@76);
            make.height.equalTo(@20);
        }];
    }
    
    return self;
}

#pragma mark - Custom Accessors

- (void)setViewModel:(UNDCardViewModel *)viewModel{
    _viewModel = viewModel;
    [self displayCardViewCell];
}

#pragma mark  - Private

- (void)displayCardViewCell{
    self.imageView.image = self.viewModel.image;
    self.titleLabel.text = self.viewModel.title;
    self.timeLabel.text  = self.viewModel.dateStr;
    self.dayCountlabel.text = self.viewModel.dayCountStr;
}

@end
