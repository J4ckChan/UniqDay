//
//  UNDBottomBarView.m
//  UniqDay
//
//  Created by ChanLiang on 21/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDBottomBarView.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UNDBottomBarView{
    UIButton *_addBtn;
    UIButton *_dayCountOrderBtn;
    UIButton *_listBtn;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self addSubview:_addBtn];
        
        _dayCountOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dayCountOrderBtn setImage:[UIImage imageNamed:@"dayCountBtn"] forState:UIControlStateNormal];
        [self addSubview:_dayCountOrderBtn];
        
        _listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_listBtn setImage:[UIImage imageNamed:@"listBtn"] forState:UIControlStateNormal];
        [self addSubview:_listBtn];
        
        [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [_dayCountOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-16);
            make.size.mas_equalTo(CGSizeMake(36, 24));
        }];
        
        [_listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_dayCountOrderBtn.mas_left).offset(-16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(24,24));
        }];
    }
    return self;
}

- (RACSignal*)rac_addCardSignal{
    return [_addBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
