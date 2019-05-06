//
//  HippoManager.h
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/16.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HippoModel+CoreDataProperties.h"

typedef enum : NSUInteger {
    GETDOWN = 1,
    ACTIVE,
    GETDOWNSHIT,
    ACTIVESHIT,
} SummerOrderStatus;

NS_ASSUME_NONNULL_BEGIN

@interface HippoManager : NSObject
+ (instancetype)shareInstance;


- (void)createSqlite;


/**
 每天重置
 */
- (void)resetData;

- (SummerOrderStatus)configDataNormalWithUI;

- (void)configDataWithGcdTimerSuccess:(void (^)(float mood,float food,float exp,float clean,NSInteger shitNumber))success;

- (void)configDataWithClearShitSuccess:(void (^)(float mood,float food,float exp,float clean))clearShitSuccess;

- (void)configDataWithEatSuccess:(void (^)(float mood,float food,float exp,float clean))eatSuccess eatFailure: (void (^)(void))eatFailure;


- (void)configDataWithAddFood:(CGFloat)food foodSuccess:(void (^)(float mood,float food,float exp,float clean))foodSuccess;


- (void)configDataWithAddMood:(CGFloat)mood moodSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess;

- (void)configDataWithCleanSuccess:(void (^)(float mood,float food,float exp,float clean))eatSuccess eatFailure: (void (^)(void))eatFailure;


- (void)configDataWithGifWoth:(NSInteger)time timerSuccess:(void (^)(void))gifSuccess;


- (void)configStandUpChangeTime;


- (HippoModel *)configDataWithModel;

- (void)createTaskComplete;

- (void)completeTask:(BOOL)isComplete;

- (void)startPlayGame;

- (void)takeShowerSuccess:(void (^)(float mood,float food,float exp,float clean))clearShitSuccess;

- (void)configDataWithExp:(CGFloat)exp Success:(void (^)(float mood,float food,float exp,float clean)) Success;

- (void)configDataWithAddFood:(CGFloat)food andClean:(CGFloat)clean moodSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess;

- (void)configDataWithAddFood:(CGFloat)food moodSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess;

- (void)playGameSuccess:(void (^)(float mood,float food,float exp,float clean))moodSuccess;
@end

NS_ASSUME_NONNULL_END
