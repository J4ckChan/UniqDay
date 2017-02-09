//
//  UNDImageTableViewCell.h
//  UniqDay
//
//  Created by ChanLiang on 07/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kAddImageNotification;

@interface UNDImageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) UIButton *addImageBtn;

@end
