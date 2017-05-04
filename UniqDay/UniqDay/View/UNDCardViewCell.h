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
@property (nonatomic,strong) UIView *frontView;
@property (nonatomic,strong) UIView *backView;

@end
