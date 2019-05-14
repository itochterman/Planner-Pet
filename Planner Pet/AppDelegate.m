//
//  AppDelegate.m
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    [JSUserDefaultTool initUserDefaultTool];
    
    
    //Sets up notification center
    _center = [UNUserNotificationCenter currentNotificationCenter];
    _options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    [_center requestAuthorizationWithOptions: _options
completionHandler:^(BOOL granted, NSError * _Nullable error) {
    if (!granted) {
        NSLog(@"Something went wrong");
    }
}];
    
    //存储当前打开的时间
    
    
    [[HippoToolManager shareInstance] createSqlite];
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Core Data stack
//initialize the app's container if it does not already exist 
- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Model"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * storDescript, NSError * e) {
                if (e != nil) {
                    NSLog(@"Error: aborting %@, %@", e, e.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *objectContext = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([objectContext hasChanges] && ![objectContext save:&error]) {
        NSLog(@"Error: aborting %@, %@", error, error.userInfo);
        abort();
    }
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowAcrolls) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }
    return UIInterfaceOrientationMaskPortrait;
}

//returns the app delegate
+ (AppDelegate *) App
{
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

@end
