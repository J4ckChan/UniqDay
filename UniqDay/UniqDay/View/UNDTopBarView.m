//
//  UNDTopBarView.m
//  UniqDay
//
//  Created by ChanLiang on 21/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDTopBarView.h"
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UNDTopBarView{
    UIButton *_moreBtn;
    UIButton *_allBtn;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"moreBtn"] forState:UIControlStateNormal];
        [self addSubview:_moreBtn];
        
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setImage:[UIImage imageNamed:@"allBtn"] forState:UIControlStateNormal];
        [self addSubview:_allBtn];
        
        [_allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(16);
            make.size.mas_equalTo(CGSizeMake(24, 24));
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-16);
            make.size.mas_equalTo(CGSizeMake(24, 8));
        }];
    }
    return self;
}

- (RACSignal *)rac_moreSignal{
    return [_moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}



@end
