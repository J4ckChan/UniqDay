//
//  UNDToolsBarViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 07/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class UNDCard;

@interface UNDToolsBarViewModel : RVMViewModel

- (void)deleteCurrentCardModel:(UNDCard *)model;

@end
