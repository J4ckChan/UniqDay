//
//  UNDCardViewSideB.m
//  UniqDay
//
//  Created by ChanLiang on 05/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewSideB.h"
#import <Masonry/Masonry.h>
#import "UNDCardViewSideBCell.h"
#import "UNDCardViewSideBCellViewModel.h"

@interface UNDCardViewSideB ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *dayArray;

@end

@implementation UNDCardViewSideB

static NSString *const UNDCardViewSideBReuseIdentifier = @"UNDCardViewSideBReuseIdentifier";

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc]initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UNDCardViewSideBCell class] forCellReuseIdentifier:UNDCardViewSideBReuseIdentifier];
        _tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:_tableView];
        _date = date;
        _dayArray = @[@(-100),@(-50),@(-10),@0,@100,@200,@300,@365,@400,@500,@600,@700,@730];
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView         = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
    headerView.backgroundColor = [UIColor colorWithWhite:0.864 alpha:1];
    
    UILabel *anniversaryLabel  = [[UILabel alloc]init];
    anniversaryLabel.text      = @"Anniversary";
    anniversaryLabel.font      = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
    anniversaryLabel.textColor = [UIColor blackColor];
    [headerView addSubview:anniversaryLabel];
    UIEdgeInsets edgeInsets    = UIEdgeInsetsMake(8, 12, 8, 12);
    [anniversaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).insets(edgeInsets);
    }];
    
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UNDCardViewSideBCell *cell = [tableView dequeueReusableCellWithIdentifier:UNDCardViewSideBReuseIdentifier forIndexPath:indexPath];
    cell.viewModel = [[UNDCardViewSideBCellViewModel alloc]initWithDate:_date day:_dayArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
