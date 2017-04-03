//
//  UNDAddCardViewModel.m
//  UniqDay
//
//  Created by ChanLiang on 12/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDAddCardViewModel.h"

#import "UNDCard.h"

#import <UIKit/UIKit.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UNDAddCardViewModel ()

@property (nonatomic,strong) UNDCard *model;
@property (nonatomic,strong) RACSignal *rac_validSignal;

@end

@implementation UNDAddCardViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _model                = [[UNDCard alloc]init];
        _model.createdDate    = [NSDate date];
        RAC(_model,title)     = RACObserve(self, title);
        RAC(_model,date)      = RACObserve(self, date);
        RAC(_model,imageData) = [RACObserve(self, image) map:^id(UIImage *value) {
            return UIImagePNGRepresentation(value);
        }];
    }
    return self;
}

- (UNDAddCardModelResult)addCardModel{

//    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    if (self.title == nil || [self.title isEqualToString:@""]) {
        return UNDAddCardModelTitleFailure;
    }

    if (self.date == nil) {
        return UNDAddCardModelDateFailure;
    }
    
    if (self.image == nil) {
        return UNDAddCardModelImageFailure;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:_model];
    [realm commitWriteTransaction];
    
    return UNDAddCardModelSuccess;
}


@end
