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
    
    CAGradientLayer *myFkngAwsmGrad = [[CAGradientLayer alloc] init];
    [myFkngAwsmGrad setColors:@[(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor]]];
    myFkngAwsmGrad.frame = self.view.bounds;
    
    [self.view.layer insertSublayer:myFkngAwsmGrad atIndex:0];
    self.view.layer.backgroundColor = [[UIColor clearColor] CGColor];
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _CDContext = _appDelegate.persistentContainer.viewContext;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillAppear:(BOOL)animated
{

    
}

- (IBAction)touchDate:(id)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [self.addDate setInputView:datePicker];
    [datePicker addTarget:self action:@selector(saveDate:)
         forControlEvents:UIControlEventValueChanged];

//    NSLog(@"The date is: %@", self.addDate.text);

}

//
-(void) saveDate: (UIDatePicker *) picker{
    _date = picker.date;
    NSDateFormatter * dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
    _addDate.text = [dateForm stringFromDate: _date];

    NSLog([dateForm stringFromDate: _date]);

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)pushCTB:(id)sender {
    _entObj = [NSEntityDescription insertNewObjectForEntityForName: @"Task" inManagedObjectContext: _CDContext];
    
    [_entObj setValue: _date  forKey: @"dateStart"];
    [_entObj setValue: _taskDescription.text forKey: @"describe"];
    [_entObj setValue: _taskTitle.text forKey: @"title"];
    
    [_appDelegate saveContext];

    
    _taskTitle.delegate = self;
    _taskDescription.delegate = self;
    
    NSLog([_entObj valueForKey: @"title"]);
    
    [_appDelegate saveContext];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
