//
//  AppDelegate.h
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property NSPersistentContainer * persistentContainer;

@property NSManagedObject * entity;


@end

