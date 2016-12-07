//
//  Card+CoreDataProperties.h
//  UniqDay
//
//  Created by ChanLiang on 07/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Card+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, retain) NSObject *image;

@end

NS_ASSUME_NONNULL_END
