//
//  Task.h
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject

@property NSString * name;

@property NSDate * dateCreated;

@property NSDate * dateToComplete;

@property NSString * txtDescription;

@property NSNumber * isChecked;

@end

NS_ASSUME_NONNULL_END
