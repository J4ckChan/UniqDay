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

- (void)sortByCountDay{
    self.models = [[UNDCard allObjects] sortedResultsUsingProperty:@"date" ascending:NO];
}

- (void)sortByCreatedDate{
    self.models = [[UNDCard allObjects] sortedResultsUsingProperty:@"createdDate" ascending:YES];
}

- (void)updateCardModels{
    self.models = [UNDCard allObjects];
}



@end
