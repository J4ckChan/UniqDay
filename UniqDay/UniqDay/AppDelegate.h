//
//  AppDelegate.h
//  UniqDay
//
//  Created by ChanLiang on 07/12/2016.
//  Copyright © 2016 ChanLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

