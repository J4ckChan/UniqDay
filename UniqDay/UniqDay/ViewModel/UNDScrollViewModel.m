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
        self.models = [UNDCard allObjects];
    }
    return self;
}

@end
