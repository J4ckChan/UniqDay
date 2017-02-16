//
//  UNDCardViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 16/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewModel.h"
#import "UNDCard.h"

@implementation UNDCardViewModel{
    UNDCard *_model;
}

@synthesize model,title,dateStr,dayCountStr;

- (instancetype)initWithModel:(UNDCard *)modelP{
    self = [super init];
    if (self) {
        _model = self.model;
        self.title = _model.title;
        self.dateStr = [NSString stringWithFormat:@"%@",_model.date];
        self.dayCountStr = [self dayCountFromNow:_model.date];
    }
    return self;
}
                            
- (NSString *)dayCountFromNow:(NSDate *)date{
    NSTimeInterval timeInter = date.timeIntervalSinceNow;
    return [NSString stringWithFormat:@"%lf",timeInter];
}

@end
