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

#import "UNDCardViewSideA.h"
#import "UNDCardViewSideB.h"

@interface UNDCardViewCell ()

@property (nonatomic,assign) BOOL isFront;

@end

@implementation UNDCardViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius     = 5;
        self.contentView.clipsToBounds          = YES;
        self.contentView.backgroundColor        = [UIColor whiteColor];
        _isFront                                = YES;
        UITapGestureRecognizer *tap             = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flipAnimation:)];
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - Custom Accessors

- (void)setFrontView:(UIView *)frontView{
    if (!_frontView) {
        _frontView = frontView;
        [self.contentView addSubview:self.frontView];
        [self.contentView bringSubviewToFront:self.frontView];
    }
}

- (void)setBackView:(UIView *)backView{
    if (!_backView) {
        _backView = backView;
        [self.contentView addSubview:self.backView];
        [self.contentView bringSubviewToFront:self.frontView];
    }
}

- (void)setViewModel:(UNDCardViewModel *)viewModel{
    _viewModel = viewModel;
    UNDCardViewSideA *sideA = [[UNDCardViewSideA alloc]initWithFrame:self.contentView.bounds];
    [sideA configureSelf:_viewModel];
    UNDCardViewSideB *sideB = [[UNDCardViewSideB alloc]initWithFrame:self.contentView.bounds];
    self.frontView = sideA;
    self.backView = sideB;
}

#pragma mark - Animation

- (void)flipAnimation:(UITapGestureRecognizer *)sender{
    
    UIView *fromView = _isFront ? _frontView : _backView;
    UIView *toView = _isFront ? _backView : _frontView;
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        _isFront = !_isFront;
    }];
}



@end
