//
//  UNDDateTableViewCell.m
//  UniqDay
//
//  Created by ChanLiang on 26/01/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDDateTableViewCell.h"

#import <Masonry/Masonry.h>

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UNDDateTableViewCell

NSString *kRaiseDatePickerNotification = @"RaiseDatePickerNotification";

@synthesize dateBtn;

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
        
        [self.contentView addSubview:({
            self.dateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.dateBtn setTitle:@"DATE" forState:UIControlStateNormal];
            [self.dateBtn setTitleColor:[UIColor colorWithWhite:0.667 alpha:0.7] forState:UIControlStateNormal];
            self.dateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            self.dateBtn;
        })];
        
        UIEdgeInsets insets = UIEdgeInsetsMake(4, 15, 4, 4);
        [self.dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(insets);
        }];
        
        [[self.dateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
         subscribeNext:^(id x) {
             [[NSNotificationCenter defaultCenter] postNotificationName:kRaiseDatePickerNotification object:nil];
        }];
    }
    return self;
}

- (void)resetDate{
    [self.dateBtn setTitle:@"DATE" forState:UIControlStateNormal];
}

@end
