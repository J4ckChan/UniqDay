//
//  UNDCard+CoreDataProperties.m
//  
//
//  Created by ChanLiang on 09/01/2017.
//
//  This file was automatically generated and should not be edited.
//

#import "UNDCard+CoreDataProperties.h"

@implementation UNDCard (CoreDataProperties)

+ (NSFetchRequest<UNDCard *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDCard"];
}

@dynamic date;
@dynamic image;
@dynamic title;

@end
