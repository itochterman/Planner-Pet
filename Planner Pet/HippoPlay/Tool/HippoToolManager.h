//
//  HippoToolManager.h
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/13.
//  Copyright © 2019 xlkd 24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HippoModel+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface HippoToolManager : NSObject
+ (instancetype)shareInstance;

- (NSString *)getCurrentTiem;

//创建数据库
- (void)createSqlite;


- (void)insertDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood clean:(CGFloat)clean shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime;

- (void)updateDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood clean:(CGFloat)clean shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime;

- (HippoModel *)readData;

@end

NS_ASSUME_NONNULL_END
