//
//  UNDCardViewSideBCellViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 08/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@interface UNDCardViewSideBCellViewModel : RVMViewModel

@property (nonatomic,copy) NSString *dayStr;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,copy) NSString *dayCountStr;
@property (nonatomic,assign) BOOL flag;

- (instancetype)initWithDate:(NSDate *)date
                         day:(NSNumber *)dayNum;

@end
