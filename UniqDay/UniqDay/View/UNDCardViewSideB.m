//
//  UNDCardViewSideB.m
//  UniqDay
//
//  Created by ChanLiang on 05/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewSideB.h"
#import <Masonry/Masonry.h>

@interface UNDCardViewSideB ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation UNDCardViewSideB

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc]initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
        [self addSubview:_tableView];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];
    cell.textLabel.text = @"hello world";
    return cell;
}

@end
