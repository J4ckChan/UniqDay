//
//  UNDCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 16/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class UIImage,UNDCard;

@interface UNDCardViewModel : RVMViewModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *dateStr;
@property (nonatomic,copy) NSString *dayCountStr;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) UNDCard *model;

- (instancetype)initWithModel:(UNDCard*)model;

@end
