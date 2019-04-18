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



@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView * tableView;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property AppDelegate * appDelegate;



@end

