//
//  AppDelegate.h
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <CoreData/CoreData.h>
@import UserNotifications;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic,assign) BOOL allowAcrolls;

@property (nonatomic,assign) BOOL isCanPlayGame;

@property (nonatomic,assign) BOOL isShowShitAnmation;

@property (strong, nonatomic) UIWindow *window;

@property NSPersistentContainer * persistentContainer;

@property NSManagedObject * entity;

@property (nonatomic,assign) BOOL isNotToday;//上次打开和本次打开是否是同一天

@property UNUserNotificationCenter *center;
@property UNAuthorizationOptions options;

-(void) saveContext;

+ (AppDelegate *) App;


@end

