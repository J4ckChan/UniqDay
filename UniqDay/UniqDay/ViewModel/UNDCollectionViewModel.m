//
//  UNDCollectionViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 18/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

//view
#import "UNDCollectionViewModel.h"
#import "UNDCard.h"

//viewModel
#import "UNDCardViewModel.h"

//model
#import <Realm/Realm.h>

@interface UNDCollectionViewModel ()

@property (nonatomic,strong) RLMResults *models;
@property (nonatomic,readwrite,copy) NSMutableArray *mutableCellViewModels;

@end

@implementation UNDCollectionViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _models = [UNDCard allObjects];
        _mutableCellViewModels = [[NSMutableArray alloc]init];
        for (UNDCard *model in _models) {
            UNDCardViewModel *cardViewModel = [[UNDCardViewModel alloc] initWithModel:model];
            [_mutableCellViewModels addObject:cardViewModel];
        }
        _cellViewModels = [_mutableCellViewModels copy];
    }
    return self;
}


@end
