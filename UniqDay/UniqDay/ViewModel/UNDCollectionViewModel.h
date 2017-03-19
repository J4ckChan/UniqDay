//
//  UNDCollectionViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 18/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class UNDCardViewModel;

@interface UNDCollectionViewModel : RVMViewModel

@property (nonatomic,readonly,copy) NSArray *cellViewModels;

- (void)sortByCreatedDay;
- (void)sortByDate;


@end
