//
//  UNDBlurAlertView.h
//  UniqDay
//
//  Created by ChanLiang on 16/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNDBlurAlertView : UIView

- (instancetype)initWithMessage:(NSString *)message;
- (void)showAlertOnView:(UIView *)view completion: (void (^)(void))completion;

@end
