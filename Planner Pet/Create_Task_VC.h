//
//  Create_Task_VC.h
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "FSCalendar.h"

NS_ASSUME_NONNULL_BEGIN

@interface Create_Task_VC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *taskTitle;
@property (weak, nonatomic) IBOutlet UIButton *createTaskButton;
- (IBAction)dateChanged:(id)sender;
@property NSDate * date;
@property NSManagedObject * entObj;
@property NSManagedObjectContext * CDContext;
@property (weak, nonatomic) IBOutlet UITextField *addDate;
@property AppDelegate * appDelegate;
@property BOOL canSave; 

@property (weak, nonatomic) FSCalendar *calendar;

-(void) saveDate: (UIDatePicker *) picker;


@end

NS_ASSUME_NONNULL_END
