//
//  HippoModel+CoreDataProperties.h
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/13.
//  Copyright © 2019 xlkd 24. All rights reserved.
//
//

#import "HippoModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HippoModel (CoreDataProperties)

+ (NSFetchRequest<HippoModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *hippoId;
@property (nonatomic) float mood;//心情
@property (nonatomic) float food;//食物
@property (nonatomic) float exp;//饱程度
@property (nonatomic) int16_t shitNumber;//屎数量
@property (nullable, nonatomic, copy) NSString *downStatus;//河马是否趴下
@property (nullable, nonatomic, copy) NSString *changeShitTime;//开始拉屎时间
@property (nullable, nonatomic, copy) NSString *changeMoodTime;//开始影响心情时间
@property (nullable, nonatomic, copy) NSString *changeExpTime;//开始饥饿度时间
@property (nullable, nonatomic, copy) NSString *actionTime;//河马是否趴下时间

@end

NS_ASSUME_NONNULL_END
