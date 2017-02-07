//
//  UNDImageTableViewCell.m
//  UniqDay
//
//  Created by ChanLiang on 07/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDImageTableViewCell.h"

#import <Masonry/Masonry.h>

@implementation UNDImageTableViewCell{
    UIScrollView *_scrollView;
}

@synthesize addImageBtn,imageArray;

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
        _scrollView.backgroundColor = [UIColor lightGrayColor];
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
    CGFloat imageWidth = 40;
    int imageCount = 18;
    for (int i = 0 ; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test"]];
        [contentView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView != nil) {
                make.left.mas_equalTo(lastView.mas_right).offset(12);
            }else{
                make.left.mas_equalTo(@16);
            }
            make.top.equalTo(@8);
            make.width.mas_equalTo(imageWidth);
            make.bottom.equalTo(@(-8));
        }];
        
        lastView = imageView;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastView.mas_right).offset(16);
    }];
}

- (void)singleTap:(UITapGestureRecognizer*)sender {
    NSLog(@"%@",sender);
};

@end
