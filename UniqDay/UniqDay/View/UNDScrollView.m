//
//  UNDScrollView.m
//  UniqDay
//
//  Created by ChanLiang on 18/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDScrollView.h"
#import "UNDCardView.h"

//ViewModel
#import "UNDScrollViewModel.h"
#import "UNDCardViewModel.h"

//Model
#import "UNDCard.h"

//Vendors
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface UNDScrollView ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation UNDScrollView

@synthesize scrollView,cards;

- (instancetype)init{
    self = [super init];
    if (self) {
        
        UNDScrollViewModel *scrollViewModel = [[UNDScrollViewModel alloc]init];
        self.cards = scrollViewModel.models;
        
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
    
    int num = (int)cards.count;

    if (num == 0) {
        return;
    }
    CGFloat space       = 16;
    CGFloat doubleSpace = 32;
    CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width - doubleSpace;
    UNDCardView *lastCardView;
    
    for (int i = 0; i < num; i++) {
        UNDCardView *cardView = [[UNDCardView alloc]init];
        [contentView addSubview:cardView];
        
        //configure cardView
        UNDCard *card = [self.cards objectAtIndex:i];
        [self configureCardView:cardView withModel:card];
        
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
            make.bottom.mas_equalTo(@(-space));
        }];
        
        lastCardView = cardView;
    }
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastCardView).offset(space);
    }];
}

- (void)configureCardView:(UNDCardView *)cardView withModel:(UNDCard *)card{
    UNDCardViewModel *viewModel      = [[UNDCardViewModel alloc]initWithModel:card];
    
    //Init
    cardView.imageView.image         = viewModel.image;
    cardView.titleLabel.text         = viewModel.title;
    cardView.timeLabel.text          = viewModel.dateStr;
    cardView.dayCountlabel.text      = viewModel.dayCountStr;

    //RAC Bindinhg
    RAC(cardView.imageView,image)    = RACObserve(viewModel, image);
    RAC(cardView.titleLabel,text)    = RACObserve(viewModel, title);
    RAC(cardView.timeLabel,text)     = RACObserve(viewModel, dateStr);
    RAC(cardView.dayCountlabel,text) = RACObserve(viewModel, dayCountStr);
}



@end
