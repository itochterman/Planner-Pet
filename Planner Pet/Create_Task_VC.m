//
//  Create_Task_VC.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "Create_Task_VC.h"

@interface Create_Task_VC ()


@end


@implementation Create_Task_VC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _CDContext = _appDelegate.persistentContainer.viewContext;
    
    NSManagedObject * entObj = [NSEntityDescription insertNewObjectForEntityForName: @"Task" inManagedObjectContext: _CDContext];
    
    
    NSLog(@"here!");
    
}
- (IBAction)pushCTB:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)releaseCTB:(id)sender {
}
@end
