//
//  UNDAddCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 12/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UNDAddCardModelTitleFailure,
    UNDAddCardModelDateFailure,
    UNDAddCardModelImageFailure,
    UNDAddCardModelSuccess,
} UNDAddCardModelResult;

@class RACCommand,UNDCard;

@interface UNDAddCardViewModel : RVMViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) RACCommand *rac_addCardModelCommand;
@property (nonatomic,copy) NSString *statusMessage;
@property (nonatomic,strong) UNDCard *model;

- (instancetype)initWithModel:(UNDCard *)model;
- (UNDAddCardModelResult)addCardModel;
- (UNDAddCardModelResult)modifyCardMode:(UNDCard *)model;

@end
