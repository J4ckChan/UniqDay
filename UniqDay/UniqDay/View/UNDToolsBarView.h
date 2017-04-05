//
//  UNDToolsBarView.h
//  UniqDay
//
//  Created by ChanLiang on 04/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNDToolsBarView : UIView

@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *annivBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UITapGestureRecognizer *tapToHidden;

- (instancetype)initWithFrame:(CGRect)frame;

@end
