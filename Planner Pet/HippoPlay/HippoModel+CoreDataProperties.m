//
//  HippoModel+CoreDataProperties.m
//  HippoPlay
//
//  Created by Wenyin Zheng on 2019/4/13.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//
//

#import "HippoModel+CoreDataProperties.h"

@implementation HippoModel (CoreDataProperties)

+ (NSFetchRequest<HippoModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"HippoModel"];
}

@dynamic hippoId;
@dynamic mood;
@dynamic food;
@dynamic exp;
@dynamic clean;
@dynamic shitNumber;
@dynamic downStatus;
@dynamic changeShitTime;
@dynamic changeCleanTime;
@dynamic changeMoodTime;
@dynamic changeExpTime;
@dynamic actionTime;

@end
