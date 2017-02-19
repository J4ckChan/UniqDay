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
        self.dateStr     = [self dateString:model.date];
        self.dayCountStr = [self dayCountFromNow:model.date];
        self.image       = [[UIImage alloc]initWithData:model.imageDate];
    }
    return self;
}
                            
- (NSString *)dayCountFromNow:(NSDate *)date{
    NSTimeInterval timeInter = date.timeIntervalSinceNow;
    double dayDouble = timeInter/(24*3600);
    int dayInt = (int)dayDouble;
    NSString *dayStr;
    if (dayInt >= 0) {
        dayStr = [NSString stringWithFormat:@"D+%d",dayInt];
    }else{
        dayStr = [NSString stringWithFormat:@"D%d",dayInt];
    }
    return dayStr;
}

- (NSString *)dateString:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"MMM d, YYYY";
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

@end
