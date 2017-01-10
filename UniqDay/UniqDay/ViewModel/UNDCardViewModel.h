//
//  UNDCardViewModel.h
//  UniqDay
//
//  Created by ChanLiang on 09/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <ReactiveViewModel/ReactiveViewModel.h>
#import <UIKit/UIKit.h>

@interface UNDCardViewModel : RVMViewModel

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *timeStr;
@property (nonatomic,copy) NSString *dayCountStr;
@property (nonatomic,copy) UIImage *image;

@end
