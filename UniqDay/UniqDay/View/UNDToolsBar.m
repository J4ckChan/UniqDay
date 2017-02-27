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
        [_editBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_editBtn];
        
        _annivBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_annivBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_annivBtn];
        
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_shareBtn];
        
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_deleteBtn];
        
        NSArray *btnArray = @[_editBtn,_annivBtn,_shareBtn,_deleteBtn];
        CGFloat width = [UIScreen mainScreen].bounds.size.width - 32;
        CGFloat space = - (width/8);
        CGSize btnSize = CGSizeMake(44, 44);
        
        UIButton *lastBtn;
        for (int i = 0; i < 4; i++) {
            UIButton *btn = btnArray[i];
            btn.backgroundColor = [UIColor greenColor];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastBtn != nil) {
                    make.centerX.equalTo(lastBtn.mas_centerX).offset(space*2);
                }else{
                    make.centerX.equalTo(self.mas_right).offset(space-16);
                }
                make.centerY.equalTo(self).offset(-120);
                make.size.mas_equalTo(btnSize);
            }];
            lastBtn = btn;
        }
        
        CABasicAnimation *dropAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
        dropAnimation.fromValue = @(-120);
        dropAnimation.toValue = @(self.center.y + 30);
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

@end
