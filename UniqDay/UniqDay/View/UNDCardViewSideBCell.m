//
//  UNDCardViewSideBCell.m
//  UniqDay
//
//  Created by ChanLiang on 09/05/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDCardViewSideBCell.h"
#import <Masonry/Masonry.h>

@interface UNDCardViewSideBCell ()

@property (nonatomic,strong) UIImageView *flagImageView;
@property (nonatomic,strong) UILabel *dayLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) UILabel *dayCountLabel;

@end

@implementation UNDCardViewSideBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _flagImageView = [[UIImageView alloc]init];
        _flagImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_flagImageView];
        [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(16);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.text = @"100";
        [self.contentView addSubview:_dayLabel];
        [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_flagImageView.mas_right).offset(8);
            make.top.equalTo(self.contentView).offset(8);
            make.size.mas_equalTo(CGSizeMake(100, 18));
        }];
        
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.text = @"January,25,2017";
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_flagImageView.mas_right).offset(8);
            make.bottom.equalTo(self.contentView).offset(-8);
            make.size.mas_equalTo(CGSizeMake(200, 18));
        }];
        
        _dayCountLabel = [[UILabel alloc]init];
        _dayCountLabel.text = @"D-20";
        [self.contentView addSubview:_dayCountLabel];
        [_dayCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-16);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setViewModel:(UNDCardViewSideBCellViewModel *)viewModel{
    
}

@end
