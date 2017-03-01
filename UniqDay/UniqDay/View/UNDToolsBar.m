//
//  UNDToolsBar.m
//  UniqDay
//
//  Created by ChanLiang on 23/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDToolsBar.h"
#import <Masonry/Masonry.h>

@implementation UNDToolsBar{
    UIButton *_editBtn;
    UIButton *_annivBtn;
    UIButton *_shareBtn;
    UIButton *_deleteBtn;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
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
        
        NSArray *btnArray = @[_deleteBtn,_shareBtn,_annivBtn,_editBtn];
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 32;
        CGFloat space = - (width/8);
        
        UIButton *lastBtn;
        for (int i = 0; i < 4; i++) {
            UIButton *btn = btnArray[i];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastBtn != nil) {
                    make.centerX.equalTo(lastBtn.mas_centerX).offset(space*2);
                }else{
                    make.centerX.equalTo(self.mas_right).offset(space-16);
                }
                make.centerY.equalTo(self).offset(-150);
            }];
            lastBtn = btn;
        }
        
        CABasicAnimation *dropAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        dropAnimation.fromValue = @(-150);
        dropAnimation.toValue = @50;
        dropAnimation.duration = 0.4;
        dropAnimation.removedOnCompletion = NO;
        dropAnimation.fillMode = kCAFillModeForwards;
        
        for (int j = 0; j < 4; j++) {
            UIButton *btn = btnArray[j];
            dropAnimation.beginTime = CACurrentMediaTime() + j * 0.2;
            [btn.layer addAnimation:dropAnimation forKey:nil];
        }
    }
    return self;
}

-(void)hideButtons{
    _editBtn.alpha   = 0;
    _annivBtn.alpha  = 0;
    _shareBtn.alpha  = 0;
    _deleteBtn.alpha = 0;
}

-(void)removeButtons{
    [_editBtn removeFromSuperview];
    [_annivBtn removeFromSuperview];
    [_shareBtn removeFromSuperview];
    [_deleteBtn removeFromSuperview];
    _editBtn   = nil;
    _annivBtn  = nil;
    _shareBtn  = nil;
    _deleteBtn = nil;
}

@end
