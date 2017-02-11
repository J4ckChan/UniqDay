//
//  UNDAddCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 12/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

typedef enum : NSUInteger {
    UNDAddCardModelTitleFailure,
    UNDAddCardModelDateFailure,
    UNDAddCardModelImageFailure,
    UNDAddCardModelSuccess,
} UNDAddCardModelResult;

@interface UNDAddCardViewModel : RVMViewModel

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSData *image;

- (UNDAddCardModelResult)adddCardModel;

@end
