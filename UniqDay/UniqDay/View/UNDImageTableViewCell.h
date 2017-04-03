//
//  UNDImageTableViewCell.h
//  UniqDay
//
//  Created by ChanLiang on 07/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const UNDAddImageNotification;

@interface UNDImageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,strong) UIButton *addImageBtn;
@property (nonatomic,strong) UIImage *image;

- (void)resetAllImageView:(NSMutableArray *)images;

@end
