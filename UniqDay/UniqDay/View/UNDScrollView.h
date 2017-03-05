//
//  UNDScrollView.h
//  UniqDay
//
//  Created by ChanLiang on 18/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLMResults;

@interface UNDScrollView : UIView

@property (nonatomic,strong) RLMResults *models;

- (void)generateContent;

- (void)configureScorllViewWithModels;

@end
