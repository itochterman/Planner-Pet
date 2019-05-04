//
//  Task_VC.h
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/18/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <CoreData/CoreData.h>
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task_VC : UIViewController
@property NSManagedObject * task;
@property (weak, nonatomic) FSCalendar *calendar;
@end

NS_ASSUME_NONNULL_END
