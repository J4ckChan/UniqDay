//
//  UNDTitleTableViewCell.h
//  UniqDay
//
//  Created by ChanLiang on 21/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kRaiseAddCardViewNotification;

@interface UNDTitleTableViewCell : UITableViewCell

@property (nonatomic,strong) UITextField *titleTextField;

- (void)resetTitle;
- (void)textFieldResignFirstResponder;

@end
