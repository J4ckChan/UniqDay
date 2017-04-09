//
//  UNDToolsBarView.m
//  UniqDay
//
//  Created by ChanLiang on 04/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDToolsBarView.h"
#import <Masonry/Masonry.h>

@implementation UNDToolsBarView{
    UIButton *lastBtn;
    NSArray *btnArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _tapToHidden = [[UITapGestureRecognizer alloc]init];
        [self addGestureRecognizer:_tapToHidden];
        
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
        [self addSubview:_editBtn];
        
        _annivBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_annivBtn setImage:[UIImage imageNamed:@"annivBtn"] forState:UIControlStateNormal];
        [self addSubview:_annivBtn];
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        [self addSubview:_shareBtn];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
        
        btnArray = @[_deleteBtn,_shareBtn,_annivBtn,_editBtn];
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 32;
        CGFloat space = - (width/8);
        
        //    UIButton *lastBtn;
        for (int i = 0; i < 4; i++) {
            UIButton *btn = btnArray[i];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastBtn != nil) {
                    make.centerX.equalTo(lastBtn.mas_centerX).offset(space*2);
                }else{
                    make.centerX.equalTo(self.mas_right).offset(space-16);
                }
                make.centerY.equalTo(self.mas_top).offset(110);
            }];
            lastBtn = btn;
            btn.hidden = YES;
        }
        
        [self addAnimationsToButtons];
    }
    return self;
}

- (void)addAnimationsToButtons{

    CABasicAnimation *dropAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    dropAnimation.fromValue = @(lastBtn.center.y);
    dropAnimation.toValue = @110;
    dropAnimation.duration = 0.4;
    dropAnimation.removedOnCompletion = NO;
    dropAnimation.fillMode = kCAFillModeForwards;
    
    for (int j = 0; j < 4; j++) {
        UIButton *btn = btnArray[j];
        btn.hidden = NO;
        dropAnimation.beginTime = CACurrentMediaTime() + j * 0.15;
        [btn.layer addAnimation:dropAnimation forKey:nil];
    }
}



@end
