//
//  Task_VC.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/18/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "Task_VC.h"
#import "FSCalendar.h"

@interface Task_VC ()

@property (weak, nonatomic) IBOutlet UITextField *taskTitle;
@property (weak, nonatomic) IBOutlet UITextView *taskDetail;
@property (weak, nonatomic) IBOutlet UITextField *taskDate;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;


@end

@implementation Task_VC

- (void)viewDidLoad {
    
    
    _taskDetail.layer.cornerRadius = _taskDetail.frame.size.height/12;
    _taskDetail.clipsToBounds=YES;
    
    self.doneButton.layer.cornerRadius = self.doneButton.frame.size.height/6.66;
    self.doneButton.clipsToBounds = YES;
    
    
    NSLog(@"%@", [self.task valueForKey: @"title"]);
    _taskTitle.text = [self.task valueForKey: @"title"];
    _taskDetail.text = [self.task valueForKey: @"describe"];
    
    _taskTitle.delegate = self;
    _taskTitle.delegate = self;
    
    NSDate * taskDate = [self.task valueForKey: @"dateStart"];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MMM dd h:mm a";
    _taskDate.text = [format stringFromDate: taskDate];
    _taskDate.enabled = NO;
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
- (IBAction)doneButtonPress:(id)sender {
    [self.task setValue: _taskDetail.text forKey: @"describe"];
    [_calendar reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
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
