//
//  UNDCardViewSideA.h
//  UniqDay
//
//  Created by ChanLiang on 04/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UNDCardViewModel;

@interface UNDCardViewSideA : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;;
@property (nonatomic,strong) UILabel *dayCountlabel;
@property (nonatomic,strong) UILabel *daysSinceLabel;

- (void)configureSelf:(UNDCardViewModel *)viewModel;

@end
