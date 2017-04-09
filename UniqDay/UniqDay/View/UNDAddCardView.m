//
//  UNDAddCardView.m
//  UniqDay
//
//  Created by ChanLiang on 10/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDAddCardView.h"
#import <Masonry/Masonry.h>

#import "UNDAddCardViewModel.h"
#import "UNDCard.h"


typedef enum : NSUInteger {
    UNDAddCardTableViewTitleCell,
    UNDAddCardTableViewDateCell,
    UNDAddCardTableViewImageCell,
    UNDAddCardTableViewRowNum,
}UNDAddCardTableCell;


@interface UNDAddCardView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation UNDAddCardView{
    UNDAddCardViewStatus status;
}

static NSString * const UNDReuseIdetifierForTitle = @"UNDReuseIdetifierForTitle";
static NSString * const UNDReuseIdetifierForDate  = @"UNDReuseIdetifierForDate";
static NSString * const UNDReuseIdetifierForImage = @"UNDReuseIdetifierForImage";


#pragma mark - View Life Cycle

- (instancetype)initWithFrame:(CGRect)frame model:(UNDCard *)model{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCardViewLayoutSubiviews];
        if (model) {
            _viewModel = [[UNDAddCardViewModel alloc]initWithModel:model];
            status = UNDModifyCardStatus;
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCardViewLayoutSubiviews];
        _viewModel = [[UNDAddCardViewModel alloc]init];
        status = UNDAddCardStatus;
    }
    return self;
}

- (void)addCardViewLayoutSubiviews{
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


#pragma mark - Tableview Delegate & Datasource

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
    
    if (indexPath.row == UNDAddCardTableViewTitleCell) {
        UNDTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForTitle
                                                                       forIndexPath:indexPath];
        switch (status) {
            case UNDModifyCardStatus:
                cell.titleTextField.text = _viewModel.model.title;
                break;
            case UNDAddCardStatus:
                break;
        }
        
        RAC(_viewModel,title) = cell.titleTextField.rac_textSignal;
        
        return cell;
    }else if (indexPath.row == UNDAddCardTableViewDateCell){
        UNDDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForDate
                                                                     forIndexPath:indexPath];
        switch (status) {
            case UNDModifyCardStatus:
                [cell.dateBtn setTitle:[self dateToDateStr:_viewModel.model.date] forState:UIControlStateNormal];
                break;
            case UNDAddCardStatus:
                break;
        }
        
        return cell;
    }else{
        UNDImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UNDReuseIdetifierForImage
                                                                      forIndexPath:indexPath];
        RAC(_viewModel,image) = RACObserve(cell,image);
        return cell;
    }
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

- (NSString *)dateToDateStr:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateStyle = kCFDateFormatterMediumStyle;
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

@end
