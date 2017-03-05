//
//  UNDScrollViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 17/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

#import <UIKit/UIKit.h>

@class RLMResults;

@interface UNDScrollViewModel : RVMViewModel

@property (nonatomic,strong) RLMResults *models;

- (void)sortByCreatedDate;
- (void)sortByCountDay;
- (void)addNewCardModel;
- (void)deleteCardModel;

@end
