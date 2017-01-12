//
//  UNDCardViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 09/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewModel.h"

//model
#import "UNDCard+CoreDataProperties.h"

//rac
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UNDCardViewModel ()

@property (nonatomic,strong) UNDCard *model;

@end

@implementation UNDCardViewModel

- (instancetype)initWithModel:(id)model{
    self = [super init];
    if (self) {
        self.model = model;
        
        RAC(self,titleStr) = RACObserve(self.model, title);
        RAC(self,timeStr) = [RACObserve(self.model,date) map:^id(NSDate *date) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            [dateFormatter setDateFormat:@"MM DD,YYYY"];
            return [dateFormatter stringFromDate:date];
        }];

        RAC(self,dayCountStr) = [RACObserve(self.model, date) map:^id(NSDate *value) {
            NSDate *now                = [NSDate date];
            NSCalendar *gregorian      = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            [gregorian setFirstWeekday:2];
            NSDateComponents *dateComp = [gregorian components:NSCalendarUnitDay fromDate:value toDate:now options:0];
            NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)dateComp.day];
            return dayStr;
        }];
        
        RAC(self,image) = [RACObserve(self.model,image) map:^id(NSData *value) {
            UIImage *image = [UIImage imageWithData:value];
            return image;
        }];
    }
    return self;
}

@end
