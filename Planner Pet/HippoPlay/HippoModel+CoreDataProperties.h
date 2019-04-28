//
//  HippoModel+CoreDataProperties.h
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/13.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//
//

#import "HippoModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HippoModel (CoreDataProperties)

+ (NSFetchRequest<HippoModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *hippoId;
@property (nonatomic) float mood;
@property (nonatomic) float food;
@property (nonatomic) float exp;
@property (nonatomic) float clean;
@property (nonatomic) int16_t shitNumber;
@property (nullable, nonatomic, copy) NSString *downStatus;
@property (nullable, nonatomic, copy) NSString *changeShitTime;
@property (nullable, nonatomic, copy) NSString *changeCleanTime;
@property (nullable, nonatomic, copy) NSString *changeMoodTime;
@property (nullable, nonatomic, copy) NSString *changeExpTime;
@property (nullable, nonatomic, copy) NSString *actionTime;


@end

NS_ASSUME_NONNULL_END
