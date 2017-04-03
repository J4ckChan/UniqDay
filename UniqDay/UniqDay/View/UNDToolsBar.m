//
//  UNDToolsBar.m
//  UniqDay
//
//  Created by ChanLiang on 23/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDToolsBar.h"
#import <Masonry/Masonry.h>

@implementation UNDToolsBar

@synthesize editBtn,annivBtn,shareBtn,deleteBtn;

- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editBtn setImage:[UIImage imageNamed:@"editBtn"] forState:UIControlStateNormal];
        [self addSubview:self.editBtn];
        
        self.annivBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.annivBtn setImage:[UIImage imageNamed:@"annivBtn"] forState:UIControlStateNormal];
        [self addSubview:self.annivBtn];
        
        self.shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        [self addSubview:self.shareBtn];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn setImage:[UIImage imageNamed:@"deleteBtn"] forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        
        NSArray *btnArray = @[self.deleteBtn,self.shareBtn,self.annivBtn,self.editBtn];
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
        dropAnimation.duration = 0.3;
        dropAnimation.removedOnCompletion = NO;
        dropAnimation.fillMode = kCAFillModeForwards;
        
        for (int j = 0; j < 4; j++) {
            UIButton *btn = btnArray[j];
            dropAnimation.beginTime = CACurrentMediaTime() + j * 0.1;
            [btn.layer addAnimation:dropAnimation forKey:nil];
        }
    }
    return self;
}

-(void)hideButtons{
    self.editBtn.alpha   = 0;
    self.annivBtn.alpha  = 0;
    self.shareBtn.alpha  = 0;
    self.deleteBtn.alpha = 0;
}

-(void)removeButtons{
    [self.editBtn removeFromSuperview];
    [self.annivBtn removeFromSuperview];
    [self.shareBtn removeFromSuperview];
    [self.deleteBtn removeFromSuperview];
    self.editBtn   = nil;
    self.annivBtn  = nil;
    self.shareBtn  = nil;
    self.deleteBtn = nil;
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if ([self pointInside:point withEvent:event]) {
//        if (CGRectContainsPoint(self.editBtn.layer.presentationLayer.frame, point)) {
//            return self.editBtn;
//        }else if (CGRectContainsPoint(self.annivBtn.layer.presentationLayer.frame, point)){
//            return self.annivBtn;
//        }else if (CGRectContainsPoint(self.shareBtn.layer.presentationLayer.frame, point)){
//            return self.shareBtn;
//        }else if (CGRectContainsPoint(self.deleteBtn.layer.presentationLayer.frame, point)){
//            [self.deleteBtn.layer.presentationLayer hitTest:point];
//            return self.deleteBtn;
//        }else{
//            return self;
//        }
//    }else{
//        return nil;
//    }
//}

@end
