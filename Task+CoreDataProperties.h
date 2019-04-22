//
//  Task+CoreDataProperties.h
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//
//

#import "Task+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

+ (NSFetchRequest<Task *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateStart;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSDate *dateEnd;
@property (nullable, nonatomic, retain) NSObject *describe;
@property (nullable, nonatomic, retain) NSNumber *isChecked;

@end

NS_ASSUME_NONNULL_END
