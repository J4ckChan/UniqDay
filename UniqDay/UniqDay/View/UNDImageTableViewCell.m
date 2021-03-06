//
//  UNDImageTableViewCell.m
//  UniqDay
//
//  Created by ChanLiang on 07/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDImageTableViewCell.h"

#import <Masonry/Masonry.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UNDImageTableViewCell{
    UIScrollView *_scrollView;
}

NSString *const UNDAddImageNotification = @"UNDAddImageNotification";

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        [self generateContent];
    }
    return self;
}

- (void)generateContent{
    UIView *contentView = [[UIView alloc]init];
    [_scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.height.equalTo(_scrollView);
    }];
    
    UIImageView *lastView;
    CGFloat imageWidth = 60;
    int imageCount     = 8;
    self.imageArray    = NSMutableArray.new;
    for (int i = 0 ; i < imageCount + 1; i++) {
        
        if (i == 0) {
            self.addImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.addImageBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
            [self.addImageBtn setBackgroundImage:[UIImage imageNamed:@"addBgImage"] forState:UIControlStateNormal];
            self.addImageBtn.clipsToBounds = YES;
            self.addImageBtn.layer.cornerRadius = 28;
            [[self.addImageBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
                                            subscribeNext:^(id x) {
                                                [self sendAddImageNotification];
                                            }];
            [contentView addSubview:self.addImageBtn];
            
            [_addImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(@16);
                make.width.mas_equalTo(@56);
                make.top.equalTo(@10);
                make.bottom.equalTo(@(-10));
            }];
            
        }else{
            NSString *imageStr               = [NSString stringWithFormat:@"%@%d",@"sample",i];
            UIImage *sampleImage             = [UIImage imageNamed:imageStr];
            UIImageView *imageView           = [[UIImageView alloc]initWithImage:sampleImage];
            NSDictionary *imageDict0         = @{@"imageView":imageView,@"selected":@0,@"index":@(i)};
            NSMutableDictionary *imageDict   = [NSMutableDictionary dictionaryWithDictionary:imageDict0];
            [self.imageArray addObject:imageDict];
            imageView.clipsToBounds          = YES;
            imageView.layer.cornerRadius     = 10;
            imageView.tag                    = i;
            [contentView addSubview:imageView];

            UITapGestureRecognizer *tap      = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastView != nil) {
                    make.left.mas_equalTo(lastView.mas_right).offset(12);
                }else{
                    make.left.equalTo(_addImageBtn.mas_right).offset(12);
                }
                make.width.mas_equalTo(imageWidth);
                make.top.equalTo(@8);
                make.bottom.equalTo(@(-8));
            }];
            
            lastView = imageView;
        }
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(16);
    }];
}

- (void)singleTap:(UITapGestureRecognizer*)sender {
    UIImageView *imageViewTaped = (UIImageView*)sender.view;
    NSNumber *tag = @(imageViewTaped.tag);
    for (NSMutableDictionary *dict in self.imageArray) {
        NSNumber *index = dict[@"index"];
        if ([tag isEqual:index]) {
            NSNumber *selected = dict[@"selected"];
            if ([selected isEqual:@0]) {
                [UIView animateWithDuration:0.2 animations:^{
                    imageViewTaped.layer.borderWidth = 4;
                    imageViewTaped.layer.borderColor = [UIColor greenColor].CGColor;
                } completion:^(BOOL finished) {
                
                }];
                [self resetAllImageView:self.imageArray];
                [dict setValue:@1 forKey:@"selected"];
                self.image = imageViewTaped.image;
            }
        }
    }

};

- (void)resetAllImageView:(NSMutableArray *)images{
    for (NSMutableDictionary *dict in images) {
        NSNumber *selected = dict[@"selected"];
        if ([selected isEqual:@1]) {
            UIImageView *imageView = dict[@"imageView"];
            [UIView animateWithDuration:0.2 animations:^{
                imageView.layer.borderWidth = 0;
            } completion:^(BOOL finished) {
                [dict setValue:@0 forKey:@"selected"];
            }];
        }
    }
}

#pragma mark - notification

- (void)sendAddImageNotification{
    [[NSNotificationCenter defaultCenter] postNotificationName:UNDAddImageNotification object:nil];
}

@end
