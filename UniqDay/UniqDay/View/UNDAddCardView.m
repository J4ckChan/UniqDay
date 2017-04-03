//
//  UNDAddCardView.m
//  UniqDay
//
//  Created by ChanLiang on 10/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDAddCardView.h"
#import <Masonry/Masonry.h>


typedef enum : NSUInteger {
    UNDAddCardTableViewTitleCell,
    UNDAddCardTableViewDateCell,
    UNDAddCardTableViewImageCell,
    UNDAddCardTableViewRowNum,
}UNDAddCardTableCell;

@interface UNDAddCardView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation UNDAddCardView

static NSString * const UNDReuseIdetifierForTitle = @"UNDReuseIdetifierForTitle";
static NSString * const UNDReuseIdetifierForDate  = @"UNDReuseIdetifierForDate";
static NSString * const UNDReuseIdetifierForImage = @"UNDReuseIdetifierForImage";

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds       = YES;
        self.layer.cornerRadius  = 8;

        _tableView               = [[UITableView alloc]init];
        _tableView.delegate      = self;
        _tableView.dataSource    = self;
        _tableView.scrollEnabled = NO;
        _cancelBtn               = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:NSLocalizedString(@"CANCEL", nil) forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
        _doneBtn                 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:NSLocalizedString(@"DONE", nil) forState:UIControlStateNormal];
        [_doneBtn setBackgroundColor:[UIColor brownColor]];
        
        [self addSubview:_tableView];
        [self addSubview:_cancelBtn];
        [self addSubview:_doneBtn];
        
        CGFloat tableViewHeight = 196;
        NSNumber *tablViewHeightNum = [NSNumber numberWithFloat:tableViewHeight];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.height.equalTo(tablViewHeightNum);
        }];
        
        CGFloat btnHeight      = self.frame.size.height - tableViewHeight;
        NSNumber *btnHeightNum = [NSNumber numberWithFloat:btnHeight];
        CGFloat btnWidth       = self.frame.size.width/2;
        NSNumber *btnWidthNum  = [NSNumber numberWithFloat:btnWidth];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(_tableView.mas_bottom);
            make.width.equalTo(btnWidthNum);
            make.height.equalTo(btnHeightNum);
        }];
        
        [_doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.top.equalTo(_tableView.mas_bottom);
            make.width.equalTo(btnWidthNum);
            make.height.equalTo(btnHeightNum);
        }];
        
        [self.tableView registerClass:[UNDTitleTableViewCell class] forCellReuseIdentifier:UNDReuseIdetifierForTitle];
        [self.tableView registerClass:[UNDDateTableViewCell class] forCellReuseIdentifier:UNDReuseIdetifierForDate];
        [self.tableView registerClass:[UNDImageTableViewCell class] forCellReuseIdentifier:UNDReuseIdetifierForImage];
        
    }
    return self;
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return UNDAddCardTableViewRowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == UNDAddCardTableViewImageCell) {
        return 78;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (indexPath.row == UNDAddCardTableViewTitleCell) {
        cell = (UNDTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForTitle
                                                                       forIndexPath:indexPath];
    }else if (indexPath.row == UNDAddCardTableViewDateCell){
        cell = (UNDDateTableViewCell*)[tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForDate
                                                                      forIndexPath:indexPath];
    }else if (indexPath.row == UNDAddCardTableViewImageCell){
        cell = (UNDImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForImage
                                                                       forIndexPath:indexPath];
    }
    return  cell;
}


#pragma mark - rac signal

- (RACSignal *)cancelSignal{
    return [self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

- (RACSignal *)rac_doneSignal{
    return [self.doneBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -

- (void)dismissKeyboard{
    NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
    UNDTitleTableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
    [cell textFieldResignFirstResponder];
}

- (void)clearData{
    for (NSUInteger i = 0; i < UNDAddCardTableViewRowNum ; i++) {
        if (i == UNDAddCardTableViewTitleCell) {
            NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
            UNDTitleTableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
            [cell resetTitle];
        }else if (i == UNDAddCardTableViewDateCell){
            NSIndexPath *indePath = [NSIndexPath indexPathForRow:1 inSection:0];
            UNDDateTableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
            [cell resetDate];
        }else if (i == UNDAddCardTableViewImageCell){
            NSIndexPath *indePath = [NSIndexPath indexPathForRow:2 inSection:0];
            UNDImageTableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
            [cell resetAllImageView:cell.imageArray];
        }
    }
}

- (RACSignal *)rac_titleSignal{
    NSIndexPath *indePath = [NSIndexPath indexPathForRow:0 inSection:0];
    UNDTitleTableViewCell *cell = [_tableView cellForRowAtIndexPath:indePath];
    return cell.titleTextField.rac_textSignal;
}

- (RACSignal *)rac_imageSignal{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    UNDImageTableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    return RACObserve(cell, image);
}


@end
