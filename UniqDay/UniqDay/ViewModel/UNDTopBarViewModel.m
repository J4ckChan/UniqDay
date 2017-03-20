//
//  UNDTopBarViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 21/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDTopBarViewModel.h"
#import "UNDCard.h"

@implementation UNDTopBarViewModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self refreshIndex];
    }
    return self;
}

- (void)refreshIndex{
    RLMResults *cards = [UNDCard allObjects];
    int cardCount = (int)cards.count;
    if (cardCount == 0) {
        _indexStr = @"0/0";
    }else{
        _indexStr = [NSString stringWithFormat:@"1/%d",cardCount];
    }
}

@end
