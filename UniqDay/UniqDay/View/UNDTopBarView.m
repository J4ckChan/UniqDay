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
#import "UNDTopBarViewModel.h"

@implementation UNDTopBarView

- (instancetype)init{
    self = [super init];
    if (self) {
        
        _viewModel = [[UNDTopBarViewModel alloc]init];
        
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"moreBtn"] forState:UIControlStateNormal];
        [self addSubview:_moreBtn];
        
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn setImage:[UIImage imageNamed:@"allBtn"] forState:UIControlStateNormal];
        [self addSubview:_allBtn];
        
        _indexLabel = [[UILabel alloc]init];
        _indexLabel.text = _viewModel.indexStr;
        RAC(_indexLabel,text) = RACObserve(_viewModel, indexStr);
        _indexLabel.textColor = [UIColor whiteColor];
        [self addSubview:_indexLabel];
        
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
        
        [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(_allBtn);
        }];
    }
    return self;
}

- (void)refreshIndex{
//    [_viewModel refreshIndex];
//    _indexLabel.text = _viewModel.indexStr;
}



@end
