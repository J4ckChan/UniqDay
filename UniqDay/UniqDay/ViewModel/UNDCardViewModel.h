//
//  UNDCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 16/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

#import "UNDCard.h"

@interface UNDCardViewModel : RVMViewModel

@property (nonatomic,strong) UNDCard *model;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSString *dayCountStr;


- (instancetype)initWithModel:(UNDCard*)model;

@end
