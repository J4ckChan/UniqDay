//
//  UNDToolsBarViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 07/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>

@class RACCommand;

@interface UNDToolsBarViewModel : RVMViewModel

@property (nonatomic,strong) RACCommand *rac_editComand;

@end
