//
//  UNDCardViewCell.h
//  UniqDay
//
//  Created by ChanLiang on 17/03/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UNDCardViewModel;

@interface UNDCardViewCell : UICollectionViewCell


@property (nonatomic,strong) UNDCardViewModel *viewModel;

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;;
@property (nonatomic,strong) UILabel *dayCountlabel;
@property (nonatomic,strong) UILabel *daysSinceLabel;

- (void)configureCardViewCellWithViewModel;

@end
