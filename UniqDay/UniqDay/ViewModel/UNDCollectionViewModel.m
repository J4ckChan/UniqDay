//
//  UNDCollectionViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 18/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

//view
#import "UNDCollectionViewModel.h"

//viewModel
#import "UNDCardViewModel.h"

//model
#import <Realm/Realm.h>
#import "UNDCard.h"

@interface UNDCollectionViewModel ()

@property (nonatomic,strong) RLMResults *models;
@property (nonatomic,readwrite,copy) NSMutableArray *mutableCellViewModels;

@end

@implementation UNDCollectionViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _models = [UNDCard allObjects];
        _currentModel = _models.firstObject;
    }
    return self;
}

- (void)sortByCreatedDay{
    _models = [[UNDCard allObjects] sortedResultsUsingProperty:@"createdDate" ascending:NO];
    _currentModel = _models.firstObject;
}

- (void)sortByDate{
    _models = [[UNDCard allObjects] sortedResultsUsingProperty:@"date" ascending:NO];
    _currentModel = _models.firstObject;
}

- (NSArray <UNDCardViewModel *>*)cellViewModels{
    _mutableCellViewModels = [[NSMutableArray alloc]init];
    NSArray *cellViewModels = [[NSArray alloc]init];
    for (UNDCard *model in _models) {
        UNDCardViewModel *cardViewModel = [[UNDCardViewModel alloc] initWithModel:model];
        [_mutableCellViewModels addObject:cardViewModel];
    }
    cellViewModels = [_mutableCellViewModels copy];
    return cellViewModels;
}




@end
