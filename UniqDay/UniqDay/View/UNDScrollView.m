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


@interface UNDScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) NSMutableArray *cardsArray;

@end

@implementation UNDScrollView

@synthesize scrollView,models,currentModel;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.scrollView = [[UIScrollView alloc]init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)generateContent{
    
    if (_contentView != nil){
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    
    _contentView = UIView.new;
    [self.scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.height.equalTo(self.scrollView);
    }];
    
    int num = (int)models.count;

    if (num == 0) {
        return;
    }
    CGFloat space       = 16;
    CGFloat doubleSpace = 32;
    CGFloat cardWidth = [UIScreen mainScreen].bounds.size.width - doubleSpace;
    UNDCardView *lastCardView = nil;
    self.cardsArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < num; i++) {
        UNDCardView *cardView = [[UNDCardView alloc]init];
        [_contentView addSubview:cardView];
        [self.cardsArray addObject:cardView];
        
        //configure cardView
        UNDCard *card = [self.models objectAtIndex:i];
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
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lastCardView).offset(space);
    }];
    
    [self layoutSubviews];
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

- (void)configureScorllViewWithModels{
    int cardsNum = (int)self.models.count;
    for (int i = 0; i < cardsNum; i++) {
        UNDCardView *cardView = [self.cardsArray objectAtIndex:i];
        UNDCard *model = self.models[i];
        [self configureCardView:cardView withModel:model];
    }
}

#pragma mark - UIScorllViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat xPoint = scrollView.contentOffset.x;
    int index = xPoint/width;
    self.currentModel = [self.models objectAtIndex:index];
}

@end
