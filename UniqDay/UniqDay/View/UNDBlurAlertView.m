//
//  UNDBlurAlertView.m
//  UniqDay
//
//  Created by ChanLiang on 16/04/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import "UNDBlurAlertView.h"

@interface UNDBlurAlertView ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) NSString *message;

@end

@implementation UNDBlurAlertView

- (instancetype)initWithMessage:(NSString *)message{
    self = [super init];
    if (self) {
        _message = message;
        UIFont *font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        NSDictionary *dict = @{NSFontAttributeName:font};
        CGSize size = [_message boundingRectWithSize:CGSizeMake(134, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
        
        self.frame = CGRectMake(0, 0, 150, size.height + 16);
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 4;
        self.alpha = 1;
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _backgroundView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
        _backgroundView.frame = self.frame;
        [self addSubview:_backgroundView];
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 134, size.height)];
        _label.font = font;
        _label.numberOfLines = 0;
        _label.text = _message;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.center = self.center;
        [self addSubview:_label];
    }
    return self;
}

- (void)showAlertOnView:(UIView *)view completion:(void (^)(void))completion{
    self.center = view.center;
    [view addSubview:self];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        completion();
    });
}

@end
