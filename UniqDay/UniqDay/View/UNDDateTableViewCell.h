//
//  UNDDateTableViewCell.h
//  UniqDay
//
//  Created by ChanLiang on 26/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const UNDRaiseDatePickerNotification;

@interface UNDDateTableViewCell : UITableViewCell

@property (nonatomic,strong) UIButton *dateBtn;

- (void)resetDate;

@end
