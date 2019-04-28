//
//  HippoToolManager.m
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/13.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import "HippoToolManager.h"
#import <CoreData/CoreData.h>


@interface HippoToolManager ()
{
    NSManagedObjectContext * _context;
}

@end

@implementation HippoToolManager

static HippoToolManager* _instance = nil;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    
    return _instance ;
}

- (NSString *)getCurrentTiem {
    
    NSDate *date = [[NSDate alloc]init];
    
    return [NSString stringWithFormat:@"%.0f",[date timeIntervalSince1970]];
}


- (void)createSqlite{
    

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HippoPlayModel" withExtension:@"momd"];

    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    

    NSPersistentStoreCoordinator *store = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    

    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sqlPath = [docStr stringByAppendingPathComponent:@"coreData.sqlite"];

    NSURL *sqlUrl = [NSURL fileURLWithPath:sqlPath];
    
    NSError *error = nil;

    [store addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    } else {

    }
    

    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    

    context.persistentStoreCoordinator = store;
    
    _context = context;
}



- (void)insertDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood clean:(CGFloat)clean shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime {
    
    

    
    HippoModel * model = [NSEntityDescription
                         insertNewObjectForEntityForName:@"HippoModel"
                         inManagedObjectContext:_context];
    NSLog(@"%@",model);
    

    model.hippoId = hippoId;
    model.actionTime = actionTime;
    model.changeExpTime = changeExpTime;
    model.changeMoodTime = changeMoodTime;
    model.changeCleanTime = changeExpTime;
    model.food = food;
    model.exp = exp;
    model.mood = mood;
    model.clean = clean;
    model.shitNumber = shitNumber;
    model.downStatus = downStatus;
    model.changeShitTime = changeShitTime;
    
    NSLog(@"%@",model);

    NSError *error = nil;
    if ([_context save:&error]) {

    }else{

    }
    
}


- (void)updateDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood clean:(CGFloat)clean shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime {
    

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HippoModel"];
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"hippoId = %@", hippoId];
    request.predicate = pre;
    

    NSArray *resArray = [_context executeFetchRequest:request error:nil];


    for (HippoModel *stu in resArray) {
        if ([stu.hippoId isEqualToString:hippoId]) {
            stu.actionTime = actionTime;
            stu.changeExpTime = changeExpTime;
            stu.changeMoodTime = changeMoodTime;
            stu.changeCleanTime = changeExpTime;
            stu.food = food;
            stu.exp = exp;
            stu.mood = mood;
            stu.clean = clean;
            stu.shitNumber = shitNumber;
            stu.downStatus = downStatus;
            stu.changeShitTime = changeShitTime;
            
            if (exp < 5 || clean <= 0) {
                [AppDelegate App].isCanPlayGame = NO;
            }else{
                [AppDelegate App].isCanPlayGame = YES;
            }
        }
    }
    

    NSError *error = nil;
    if ([_context save:&error]) {

    }else{

    }
}


- (HippoModel *)readData{

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"HippoModel"];
    

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"hippoId = %@", @"1"];
//    NSPredicate *pre = [[NSPredicate alloc]init];
    request.predicate = pre;
    
    

    NSArray *resArray = [_context executeFetchRequest:request error:nil];
    
    if (resArray.count > 0) {
        return [resArray firstObject];
    }
    NSLog(@"%ld",resArray.count);
    return nil;
}


@end
