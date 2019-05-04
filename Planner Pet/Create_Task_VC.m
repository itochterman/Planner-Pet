//
//  Create_Task_VC.m
//  Planner Pet
//
//  Created by Isabella Tochterman on 4/12/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "Create_Task_VC.h"
#import "HippoManager.h"
#import "FSCalendar.h"
@import UserNotifications;

@interface Create_Task_VC ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITextView *taskDescView;

@property BOOL filledOut;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@end


@implementation Create_Task_VC

- (void)viewDidLoad {
    
    NSLog(_taskDescView.text);
    
    NSDateFormatter * dateForm = [[NSDateFormatter alloc] init];
    dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
    _addDate.text = [dateForm stringFromDate: _date];
    _addDate.delegate = self;
    
    self.cancelButton.layer.cornerRadius = self.cancelButton.frame.size.height/6.66;
    self.cancelButton.clipsToBounds = YES;
    
    self.createTaskButton.layer.cornerRadius = self.createTaskButton.frame.size.height/6.66;
    self.createTaskButton.clipsToBounds = YES;
    
    self.taskDescView.layer.cornerRadius = self.taskDescView.layer.frame.size.height/12;
    _taskDescView.clipsToBounds=YES;
    
    
    
    
    
    [super viewDidLoad];
    
    _warningLabel.hidden = YES;
    
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == _addDate){
        return NO;
    }
    else{
        return YES;
    }
}

- (IBAction)touchDate:(id)sender {
//    _dateLabel.text = @"Date: ";
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];

    
    
    [datePicker setDate:_date];
    [self.addDate setInputView:datePicker];
    [datePicker addTarget: self action:@selector(datePickerChange:) forControlEvents:UIControlEventValueChanged];
//    [datePicker addTarget:self action:@selector(saveDate:)
//         forControlEvents:UIControlEventValueChanged];
    
    //    NSLog(@"The date is: %@", self.addDate.text);
    
}

-(void)datePickerChange:(id)sender{
    UIDatePicker * picker = (UIDatePicker*) sender;
    
    NSDate * date = picker.date;
    _date = date;
    
    NSComparisonResult * result = [date compare: NSDate.date];
    
    if(result != NSOrderedAscending){
        _dateLabel.text = @"Date: ";
        _dateLabel.textColor = [UIColor colorWithRed:93/255.0 green:188/255.0 blue:210/255.0 alpha:1];
        self.canSave = YES;
        [self saveDate: picker];
        

    }
    else{
        _dateLabel.text = @"Task must be in the Future";
        _dateLabel.textColor = [UIColor redColor];
        self.canSave = NO; 
        
    }
}

//
-(void) saveDate: (UIDatePicker *) picker{
    _date = picker.date;

    
//    NSComparisonResult * result= [_date compare: NSDate.date];
//    if(result != NSOrderedAscending){
        NSDateFormatter * dateForm = [[NSDateFormatter alloc] init];
        dateForm.dateFormat = @"yyyy-MM-dd HH:mm";
        _addDate.text = [dateForm stringFromDate: _date];
        
        NSLog([dateForm stringFromDate: _date]);

//    }

//    else{
//        NSLog(@"ERROR: ENTER AN UPCOMING TIME.");
//        _dateLabel.text = @"Error: Invalid date/time.";
//        _dateLabel.textColor = [UIColor blackColor];
//        _dateLabel.backgroundColor = [UIColor redColor];
//        
//        
//    }
    
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
    
    else if(self.canSave){
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
        [_calendar reloadData];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)createTaskOk
{
    [[HippoManager shareInstance] createTaskComplete];
}

@end
