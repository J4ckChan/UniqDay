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

@property (nonatomic,strong) RACSignal *rac_validSignal;

@end

@implementation UNDAddCardViewModel

- (instancetype)initWithModel:(UNDCard *)model{
    self = [super init];
    if (self) {
        if (model != nil) {
            _model     = model;
            self.title = _model.title;
            self.date  = _model.date;
            self.image = [UIImage imageWithData:_model.imageData];
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = nil;
        self.date  = nil;
        self.image = nil;
        [self initModel];
    }
    return self;
}

- (void)initModel{
    _model                = [[UNDCard alloc]init];
    _model.createdDate    = [NSDate date];
    [self bindViewModelToModel];
}

- (void)bindViewModelToModel{
    RAC(_model,title)     = RACObserve(self, title);
    RAC(_model,date)      = RACObserve(self, date);
    RAC(_model,imageData) = [RACObserve(self, image) map:^id(UIImage *value) {
        return UIImagePNGRepresentation(value);
    }];
}

- (UNDAddCardModelResult)addCardModel{

    UNDAddCardModelResult result = [self catchExceptionOfStoreModel];
    
    if (result == UNDAddCardModelSuccess) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:_model];
        [realm commitWriteTransaction];
    }
    return result;
}

- (UNDAddCardModelResult)modifyCardMode:(UNDCard *)model{
    
    UNDAddCardModelResult result = [self catchExceptionOfStoreModel];
    
    if (result == UNDAddCardModelSuccess) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        model.title = self.title;
        model.date = self.date;
        model.imageData = UIImagePNGRepresentation(self.image);
        [realm commitWriteTransaction];
    }
    return result;
}

- (UNDAddCardModelResult)catchExceptionOfStoreModel{
    
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
    
    if (self.title == nil || [self.title isEqualToString:@""]) {
        return UNDAddCardModelTitleFailure;
    }
    
    if (self.date == nil) {
        return UNDAddCardModelDateFailure;
    }
    
    if (self.image == nil) {
        return UNDAddCardModelImageFailure;
    }
    
    return UNDAddCardModelSuccess;
}



@end
