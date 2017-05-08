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

@interface UNDCardViewSideB ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy) NSArray *annviersayDateArray;

@end

@implementation UNDCardViewSideB

- (instancetype)initWithFrame:(CGRect)frame date:(NSDate *)date
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _tableView = [[UITableView alloc]initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UNDCardViewSideBCell class] forCellReuseIdentifier:@"test"];
        [self addSubview:_tableView];
        _date = date;
        [self initAnnviersayDateArrayWithDate:date];
    }
    return self;
}

#pragma mark - Private Method

- (void)initAnnviersayDateArrayWithDate:(NSDate *)date{
    double day[13] = {-100,-50,-10,0,100,200,300,365,400,500,600,700,730};
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < 13; i++) {
        double daySec = day[i] * 24 * 3600;
        NSDate *dateTemp = [NSDate dateWithTimeInterval:daySec sinceDate:date];
        [tempArray addObject:dateTemp];
    }
    
    NSString *dateStr = [self dateStrFormatMMMMDDYYYY:tempArray[0]];
    NSLog(@"%@",dateStr);
    _annviersayDateArray = [tempArray copy];
}

- (NSString *)dateStrFormatMMMMDDYYYY:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"MMMM,dd,yyyy"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
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
    UNDCardViewSideBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test" forIndexPath:indexPath];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

@end
