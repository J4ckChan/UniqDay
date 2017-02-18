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

@interface UNDAddCardViewModel ()

@property (nonatomic,strong) UNDCard *model;

@end

@implementation UNDAddCardViewModel

@synthesize title,date,image;

- (instancetype)init{
    self = [super init];
    if (self) {
        self.title = [[NSString alloc]init];
        self.date = nil;
        self.image = [[UIImage alloc]init];
    }
    return self;
}

- (UNDAddCardModelResult)addCardModel{

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
    
    _model = [[UNDCard alloc]init];
    _model.title = self.title;
    _model.date = self.date;
    _model.imageDate = UIImagePNGRepresentation(self.image);
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:_model];
    [realm commitWriteTransaction];
    
    return UNDAddCardModelSuccess;
}

@end
