//
//  UNDScrollViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 17/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDScrollViewModel.h"
#import "UNDCard.h"

@implementation UNDScrollViewModel

@synthesize models;

- (instancetype)init{
    self = [super init];
    if (self) {
        RLMResults<UNDCard*> *reulsts = [UNDCard allObjects];
        self.models = [reulsts copy];
    }
    return self;
}

@end
