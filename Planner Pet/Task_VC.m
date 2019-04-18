//
//  Task_VC.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/18/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "Task_VC.h"

@interface Task_VC ()

@end

@implementation Task_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)doneButtonPress:(id)sender {
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

@end
