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

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSString *dayCountStr;
@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) UNDCard *model;

- (instancetype)initWithModel:(UNDCard*)model;

@end
