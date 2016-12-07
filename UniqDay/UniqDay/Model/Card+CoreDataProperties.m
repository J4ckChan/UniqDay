//
//  Card+CoreDataProperties.m
//  UniqDay
//
//  Created by ChanLiang on 07/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Card+CoreDataProperties.h"

@implementation Card (CoreDataProperties)

+ (NSFetchRequest<Card *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Card"];
}

@dynamic title;
@dynamic date;
@dynamic image;

@end
