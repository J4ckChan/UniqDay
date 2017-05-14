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

- (instancetype)initWithDate:(NSDate *)date
                         day:(NSNumber *)dayNum{
    self = [super init];
    if (self) {
        _date            = date;
        _dayDouble       = [dayNum doubleValue];
        
        if (_dayDouble < 0) {
            _dayStr = [NSString stringWithFormat:@"D%d",(int)_dayDouble];
        }else if (_dayDouble == 0){
            _dayStr = @"D-DAY";
        }else{
            _dayStr = [NSString stringWithFormat:@"%dTH",(int)_dayDouble];
        }
        
        NSDate *dateTemp = [NSDate dateWithTimeInterval:_dayDouble*24*3600 sinceDate:_date];
        _dateStr         = [self dateStrFormatMMMMDDYYYY:dateTemp];
        NSDate *nowDate  = [NSDate date];
        
        if ([dateTemp compare:nowDate] == NSOrderedDescending) {
            _flag = YES;
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *components = [gregorian components:NSCalendarUnitDay fromDate:dateTemp toDate:nowDate options:NSCalendarWrapComponents];
            _dayCountStr = [NSString stringWithFormat:@"D%ld",(long)components.day];
        }else{
            _flag = NO;
        }
    
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
