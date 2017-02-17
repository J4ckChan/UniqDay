//
//  UNDScrollView.m
//  UniqDay
//
//  Created by ChanLiang on 18/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDScrollView.h"
#import "UNDCardView.h"

#import <Masonry/Masonry.h>

@interface UNDScrollView ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation UNDScrollView

@synthesize scrollView,cards;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollView = UIScrollView.new;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [self generateContent];
    }
    return self;
}

- (void)generateContent{
    UIView *contentView = UIView.new;
    [self.scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
//    int num = (int)cards.count;
    int num = 2;
    CGFloat space       = 16;
    CGFloat doubleSpace = 32;
    CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width - doubleSpace;
    UNDCardView *lastCardView;
    
    for (int i = 0; i < num; i++) {
        UNDCardView *cardView = [[UNDCardView alloc]init];
        [contentView addSubview:cardView];
        
        //configure cardView
        
        //add tap
        
        //masonry
        [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastCardView != nil) {
                make.left.mas_equalTo(lastCardView.mas_right).offset(doubleSpace);
            }else{
                make.left.mas_equalTo(@(space));
            }
            make.width.mas_equalTo(@(cardWidth));
            make.top.mas_equalTo(@(space));
            make.bottom.mas_equalTo(@(space));
        }];
        
        lastCardView = cardView;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastCardView).offset(space);
    }];
}



@end
