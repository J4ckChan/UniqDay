//
//  UNDMainView.h
//  UniqDay
//
//  Created by ChanLiang on 07/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNDMainView : UIView

@property (nonatomic,strong) UIScrollView *cardScrollView;

//UIButtons
@property (nonatomic,strong) UIButton *toolBtn;
@property (nonatomic,strong) UIButton *displayBtn;

@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *orderBtnOfTimeline;
@property (nonatomic,strong) UIButton *orderBtnOfDayCount;


@end
