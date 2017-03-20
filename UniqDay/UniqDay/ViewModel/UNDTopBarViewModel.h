//
//  UNDTopBarViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 21/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@interface UNDTopBarViewModel : RVMViewModel

@property (nonatomic,copy) NSString *indexStr;

- (void)refreshIndex;

@end
