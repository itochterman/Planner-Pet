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

/**
 插入数据
 
 @param hippoId id
 @param actionTime 河马是否趴下时间
 @param changeExpTime 开始饥饿度时间
 @param changeMoodTime 开始影响心情时间
 @param food 食物
 @param exp 饱程度
 @param mood 心情
 @param shitNumber 屎数量
 @param downStatus 河马是否趴下
 @param changeShitTime 开始拉屎时间
 */
- (void)insertDataId:(NSString *)hippoId actionTime:(NSString *)actionTime changeExpTime:(NSString *)changeExpTime changeMoodTime:(NSString *)changeMoodTime food:(CGFloat)food exp:(CGFloat)exp mood:(CGFloat)mood shitNumber:(NSInteger)shitNumber downStatus:(NSString *)downStatus changeShitTime:(NSString *)changeShitTime;
//更新，修改
- (void)updateData;
//读取查询
- (HippoModel *)readData;

@end

NS_ASSUME_NONNULL_END
