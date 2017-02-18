//
//  UNDCardViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 16/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewModel.h"
#import "UNDCard.h"

#import <UIKit/UIKit.h>

@implementation UNDCardViewModel

@synthesize title,dateStr,dayCountStr;

- (instancetype)initWithModel:(UNDCard *)model{
    self = [super init];
    if (self) {
        self.title       = model.title;
        self.dateStr     = [NSString stringWithFormat:@"%@",model.date];
        self.dayCountStr = [self dayCountFromNow:model.date];
        self.image       = [[UIImage alloc]initWithData:model.imageDate];
    }
    return self;
}
                            
- (NSString *)dayCountFromNow:(NSDate *)date{
    NSTimeInterval timeInter = date.timeIntervalSinceNow;
    return [NSString stringWithFormat:@"%lf",timeInter];
}

@end
