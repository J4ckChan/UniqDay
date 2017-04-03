//
//  UNDToolsBarViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 07/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDToolsBarViewModel.h"

#import "UNDCard.h"

@implementation UNDToolsBarViewModel

- (void)deleteCurrentCardModel:(UNDCard *)model{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:model];
    [realm commitWriteTransaction];
}

@end
