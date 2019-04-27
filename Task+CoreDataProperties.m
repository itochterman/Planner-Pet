//
//  Task+CoreDataProperties.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//
//

#import "Task+CoreDataProperties.h"

@implementation Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Task"];
}

@dynamic dateStart;
@dynamic title;
@dynamic dateEnd;
@dynamic describe;
@dynamic isChecked;

@end
