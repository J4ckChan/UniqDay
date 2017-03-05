//
//  UNDCard.h
//  UniqDay
//
//  Created by ChanLiang on 09/02/2017.
//  Copyright © 2017 ChanLiang. All rights reserved.
//

#import <Realm/Realm.h>

@interface UNDCard : RLMObject

@property NSString *title;
@property NSDate *date;
@property NSData *imageData;
@property NSDate *createdDate;

@end
