//
//  UNDCollectionViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 18/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class UNDCardViewModel,UNDCard;

@interface UNDCollectionViewModel : RVMViewModel

@property (nonatomic,readonly,copy) NSArray<UNDCardViewModel *> *cellViewModels;
@property (nonatomic,strong) UNDCard *currentModel;

- (void)sortByCreatedDay;
- (void)sortByDate;

@end
