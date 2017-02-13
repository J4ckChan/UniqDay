//
//  UNDAddCardView.h
//  UniqDay
//
//  Created by ChanLiang on 10/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNDTitleTableViewCell.h"
#import "UNDDateTableViewCell.h"
#import "UNDImageTableViewCell.h"

//rac
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UNDAddCardView : UIView

@property (nonatomic,strong) UITableView *tableView;

- (RACSignal *)rac_titleSignal;
- (RACSignal *)rac_imageSignal;
- (RACSignal*)cancelSignal;
- (RACSignal*)doneSignal;
- (void)clearData;
- (void)dismissKeyboard;

@end
