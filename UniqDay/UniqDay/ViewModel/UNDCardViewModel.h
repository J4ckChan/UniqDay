//
//  UNDCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 16/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

#import "UNDCard.h"

@class UIImage;

@interface UNDCardViewModel : RVMViewModel

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSString *dayCountStr;
@property (nonatomic,strong) UIImage *image;


- (instancetype)initWithModel:(UNDCard*)model;

@end
