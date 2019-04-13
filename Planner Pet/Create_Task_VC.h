//
//  Create_Task_VC.h
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface Create_Task_VC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UIButton *createTaskButton;
@property NSManagedObjectContext * CDContext;
@property AppDelegate * appDelegate;

@end

NS_ASSUME_NONNULL_END
