//
//  UNDToolsBar.h
//  UniqDay
//
//  Created by ChanLiang on 23/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNDToolsBar : UIView

@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong) UIButton *annivBtn;
@property (nonatomic,strong) UIButton *shareBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

-(void)hideButtons;
-(void)removeButtons;

@end
