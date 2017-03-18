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

- (instancetype)initWithModel:(UNDCard *)model{
    self = [super init];
    if (self) {
        _title       = model.title;
        _dateStr     = [self dateString:model.date];
        _dayCountStr = [self dayCountFromNow:model.date];
        _image       = [[UIImage alloc]initWithData:model.imageData];
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
