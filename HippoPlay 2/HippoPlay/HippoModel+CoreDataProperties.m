//
//  HippoModel+CoreDataProperties.m
//  HippoPlay
//
//  Created by xlkd 24 on 2019/4/13.
//  Copyright © 2019 xlkd 24. All rights reserved.
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
@dynamic shitNumber;
@dynamic downStatus;
@dynamic changeShitTime;
@dynamic changeMoodTime;
@dynamic changeExpTime;
@dynamic actionTime;

@end
