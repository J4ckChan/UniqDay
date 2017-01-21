//
//  UNDTitleTableViewCell.m
//  UniqDay
//
//  Created by ChanLiang on 21/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDTitleTableViewCell.h"

#import <Masonry/Masonry.h>

@implementation UNDTitleTableViewCell

@synthesize titleTextField;

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
        self.titleTextField = [[UITextField alloc]init];
        self.titleTextField.placeholder = @"TITLE";
        [self.contentView addSubview:self.titleTextField];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(4, 15, 4, 4);
        [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(insets);
        }];
    }
    return self;
}

@end
