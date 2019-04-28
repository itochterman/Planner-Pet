//
//  JSUserDefaultTool.h
//  Planner Pet
//
//  Created by Mr_Jesson on 2019/4/26.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <Foundation/Foundation.h>

#define EXP @"hippo_exp"

#define MOOD @"hippo_mood"

#define CLEAN @"hippo_clean"

#define FOOD @"hippo_food"

#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

NS_ASSUME_NONNULL_BEGIN

@interface JSUserDefaultTool : NSObject

+ (void)initUserDefaultTool;

/**
 获取当前时间戳

 @return 时间戳
 */
+(NSString *)getNowTimeTimestamp;

+ (BOOL)isSameDay:(long)iTime1 Time2:(long)iTime2;

+ (BOOL)isCanShit;

@end

NS_ASSUME_NONNULL_END
