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

typedef enum : NSUInteger {
    UNDAddCardStatus,
    UNDModifyCardStatus,
} UNDAddCardViewStatus;

@class UNDCard,UNDAddCardViewModel;

@interface UNDAddCardView : UIView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIButton *cancelBtn;
@property (nonatomic,strong) UNDAddCardViewModel *viewModel;

- (instancetype)initWithFrame:(CGRect)frame model:(UNDCard *)model;
- (void)clearData;
- (void)dismissKeyboard;

@end
