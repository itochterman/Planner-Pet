//
//  Create_Task_VC.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "Create_Task_VC.h"
#import "HippoManager.h"
@import UserNotifications;

@interface Create_Task_VC ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskDescView;

@property BOOL filledOut;


@end


@implementation Create_Task_VC

- (void)viewDidLoad {
    
    NSLog(_taskDescView.text);
    
    NSDateFormatter * dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
    _addDate.text = [dateForm stringFromDate: _date];
    
    self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height/6.66;
    self.cancelButton.clipsToBounds = YES;
    
    self.createTaskButton.layer.cornerRadius = self.createTaskButton.frame.size.height/6.66;
    self.createTaskButton.clipsToBounds = YES;
    
    _taskDescView.clipsToBounds=YES;
    
    
    
    
    [super viewDidLoad];
    
    _warningLabel.hidden = YES;
    
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
    
    [datePicker setDate:_date];
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
- (IBAction)didCancelCT:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pushCTB:(id)sender {
    
    if(_date == nil || [_taskTitle.text isEqualToString:@""]){
        
        _warningLabel.hidden = NO;
    }
    
    //    if(_date == nil || _taskTitle == nil || _taskDescription == nil){
    //        //_createTaskButton.enabled = false;
    //        _filledOut = NO;
    //        _warningLabel.hidden = NO;
    //
    //
    //    }
    
    else{
        NSLog(@"Title is %@ ", _taskTitle.text);
        NSLog(@"Description is %@ ", _taskDescView.text);
        
        _entObj = [NSEntityDescription insertNewObjectForEntityForName: @"Task" inManagedObjectContext: _CDContext];
        
        [_entObj setValue: _date  forKey: @"dateStart"];
        [_entObj setValue: _taskDescView.text forKey: @"describe"];
        [_entObj setValue: _taskTitle.text forKey: @"title"];
        
        [_appDelegate saveContext];
        
        //Create Notification
        
        UNMutableNotificationContent *content = [UNMutableNotificationContent new];
        content.title = [NSString localizedUserNotificationStringForKey: @"Hippo is Sad! Why you no task!?" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey: _taskTitle.text arguments:nil];
        content.sound = [UNNotificationSound defaultSound];

        NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                                         components:NSCalendarUnitYear +
                                         NSCalendarUnitMonth + NSCalendarUnitDay +
                                         NSCalendarUnitHour + NSCalendarUnitMinute +
                                         NSCalendarUnitSecond fromDate:_date];
        NSLog(@"%d %d %d %d %d", triggerDate.year, triggerDate.month, triggerDate.day, triggerDate.hour, triggerDate.second);

        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:NO];

        NSString *identifier = [NSString stringWithFormat:(@"%@%@"), _taskTitle, _addDate.text ];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
//
        [_appDelegate.center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Something went wrong: %@",error);
            }
        }];
        
        //End Create Notification
        
        _taskTitle.delegate = self;
        _taskDescView.delegate = self;
        
        NSLog(@"%@", [_entObj valueForKey: @"title"]);
        
        [_appDelegate saveContext];
        
        //创建任务完成通知
        [self createTaskOk];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)createTaskOk
{
    [[HippoManager shareInstance] createTaskComplete];
}

@end
