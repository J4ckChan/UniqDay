//
//  UNDTopBarView.h
//  UniqDay
//
//  Created by ChanLiang on 21/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UNDTopBarViewModel;

@interface UNDTopBarView : UIView

@property (nonatomic,strong) UNDTopBarViewModel *viewModel;

@property (nonatomic,strong) UIButton *moreBtn;
@property (nonatomic,strong) UIButton *allBtn;
@property (nonatomic,strong) UILabel *indexLabel;

- (void)refreshIndex;

@end
