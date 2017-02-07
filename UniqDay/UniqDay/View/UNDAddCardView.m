//
//  UNDAddCardView.m
//  UniqDay
//
//  Created by ChanLiang on 10/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDAddCardView.h"
#import <Masonry/Masonry.h>


enum : NSUInteger {
    AddCardTableViewTitleCell,
    AddCardTableViewDateCell,
    AddCardTableViewImageCell,
    AddCardTableViewRowNum,
};

@interface UNDAddCardView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIButton *cancelBtn;

@end

@implementation UNDAddCardView

static NSString *reuseIdetifierForTitle = @"Title";
static NSString *reuseIdetifierForDate  = @"Date";
static NSString *reuseIdetifierForImage  = @"Image";

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
        
        CGFloat tableViewHeight = 180;
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
        
        [self.tableView registerClass:[UNDTitleTableViewCell class] forCellReuseIdentifier:reuseIdetifierForTitle];
        [self.tableView registerClass:[UNDDateTableViewCell class] forCellReuseIdentifier:reuseIdetifierForDate];
        [self.tableView registerClass:[UNDImageTableViewCell class] forCellReuseIdentifier:reuseIdetifierForImage];
    }
    return self;
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return AddCardTableViewRowNum;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (indexPath.row == AddCardTableViewTitleCell) {
        cell = (UNDTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdetifierForTitle forIndexPath:indexPath];
    }else if (indexPath.row == AddCardTableViewDateCell){
        cell = (UNDDateTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdetifierForDate forIndexPath:indexPath];
    }else if (indexPath.row == AddCardTableViewImageCell){
        cell = (UNDImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:reuseIdetifierForImage forIndexPath:indexPath];
    }
    return  cell;
}

#pragma mark - rac signal

- (RACSignal *)cancelSignal{
    return [self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

- (RACSignal *)doneSignal{
    return [self.doneBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
}

@end
