//
//  ViewController.h
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Task_VC.h"
#import "FSCalendar.h"
#import "Create_Task_VC.h"


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, FSCalendarDataSource, FSCalendarDelegate>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property AppDelegate * appDelegate;
@property (weak, nonatomic) IBOutlet UIButton *petView;


@end

