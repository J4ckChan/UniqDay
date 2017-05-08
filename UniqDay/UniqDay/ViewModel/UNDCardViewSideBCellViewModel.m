//
//  UNDCardViewSideBCellViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 08/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewSideBCellViewModel.h"

@interface UNDCardViewSideBCellViewModel ()

@property (nonatomic,strong) NSDate *date;
@property (nonatomic,assign) double dayDouble;

@end

@implementation UNDCardViewSideBCellViewModel

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        _date            = dict[@"date"];
        NSNumber *dayNum = dict[@"day"];
        _dayDouble       = [dayNum doubleValue];
        
        _dayStr = [NSString stringWithFormat:@"%f",_dayDouble];
        _dateStr = [self dateStrFormatMMMMDDYYYY:_date];
        _dayCountStr = @"D-00";
    }
    return self;
}

#pragma mark - Private Method

- (NSString *)dateStrFormatMMMMDDYYYY:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"MMMM,dd,yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

@end
