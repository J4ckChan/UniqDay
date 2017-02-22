//
//  UNDTopBarView.h
//  UniqDay
//
//  Created by ChanLiang on 21/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACSignal;

@interface UNDTopBarView : UIView

- (RACSignal *)rac_moreSignal;

@end
