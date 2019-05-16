//
//  ViewController.m
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Wenyin Zheng, Will Powers. All rights reserved.
//

#import "ViewController.h"
#import "HippoManager.h"
#import "HippoMainView.h"

@interface ViewController ()

@property(nonatomic,strong)UIImageView *hippoBackImageView;
@property (nonatomic,strong)HippoMainView *hippoMainView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic, strong) NSMutableArray * relaxImageAry;
@property (weak, nonatomic) IBOutlet UIButton *taskViewB;
@property (weak, nonatomic) IBOutlet UILabel *currentDT;
@property (weak, nonatomic) IBOutlet UIButton *createTask;
@property NSDate * selectedDate;

@property (weak, nonatomic) IBOutlet FSCalendar *calendar;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSDictionary<NSString *, UIImage *> *images;


@end

@implementation ViewController



- (void)viewDidLoad {
    
    _selectedDate = NSDate.date;
    
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.petView.layer.cornerRadius = self.petView.frame.size.height/6.66;
    self.petView.clipsToBounds = YES;
    self.createTask.layer.cornerRadius = self.createTask.frame.size.height/6.66;
    self.createTask
    .clipsToBounds = YES;
    self.calendar.layer.cornerRadius = self.calendar.frame.size.height/39.5;
    self.calendar.clipsToBounds = YES;
    
    self.tableView.layer.cornerRadius=self.tableView.frame.size.height/67;
    
    self.tableView.clipsToBounds=YES;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //Calendar Stuff
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"h:mm a";
    
    NSDate * date = NSDate.date;
    
    NSString * daDate = [self.dateFormatter stringFromDate: date];
    
    _currentDT.text = daDate;
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startPalyGameNot) name:@"begainPlayGame" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endPlayGameNot:) name:@"endPlayGame" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFlyPlayGameNot:) name:@"flyGameEndPlayGame" object:nil];
    
    // [self.calendar selectDate:[self.dateFormatter dateFromString:@"2016/02/03"]];
    
    /*
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self.calendar setScope:FSCalendarScopeWeek animated:YES];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     [self.calendar setScope:FSCalendarScopeMonth animated:YES];
     });
     });
     */
    
}

//收到开始游戏的通知
- (void)startPalyGameNot
{
    [[HippoManager shareInstance] startPlayGame];
}

//结束游戏的通知
- (void)endPlayGameNot:(NSNotification *)not
{
    int score = [[not.userInfo objectForKey:@"score"] intValue];
    NSLog(@"该局游戏获得的分数:%d",score);
    if (score>10) {
        [[HippoManager shareInstance] configDataWithAddMood:score / 10 + 1 moodSuccess:^(float mood, float food, float exp, float clean) {
            
        }];
    }
}

- (void)endFlyPlayGameNot:(NSNotification *)not
{
    int point = [[not.userInfo objectForKey:@"point"] intValue];
    int score = [[not.userInfo objectForKey:@"score"] intValue];
    [[HippoManager shareInstance] configDataWithAddFood:point*HippoUnit moodSuccess:^(float mood, float food, float exp, float clean) {
        
    }];
    
//    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"Tip" message:[NSString stringWithFormat:@"Score:%d",score] preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"I know" style:UIAlertActionStyleCancel handler:nil];
//    [alertCtr addAction:action];
//    [self presentViewController:alertCtr animated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated{
    
    [self initializeFetchedResultsController];

}
- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"dateStart" ascending:YES];
    
    [request setSortDescriptors:@[dateSort]];
    
    NSDate * currentDate = _selectedDate;
    
    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
    
    NSDate * minDate = [cal dateFromComponents: components];
    
    [components setHour: 23];
    [components setMinute: 59];
    [components setSecond: 59];
    
    NSDate * maxDate = [cal dateFromComponents: components];

    
    NSPredicate * taskPred = [NSPredicate predicateWithFormat: @"(dateStart >= %@) AND (dateStart <= %@)", minDate, maxDate];
    
    
    [request setPredicate:taskPred];
    
    NSManagedObjectContext * moc = _appDelegate.persistentContainer.viewContext;
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

#pragma mark - UITableViewDelegate Implementation

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ID"];
    }
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.backgroundColor = [UIColor colorWithRed: 0/255.0 green:206/255.0 blue:209/255.0 alpha:0.5];
    
    
    NSManagedObject * task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //sets image states
    UIImage* checked = [UIImage imageNamed:@"checked.png"];
    UIImage* unChecked = [UIImage imageNamed:@"unchecked.png"];
    //sets up button
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    checkbox.backgroundColor = [UIColor clearColor];
    //sets up images for states
    
    
    if ([[task valueForKey:@"isChecked"]boolValue]){
        [checkbox setBackgroundImage:checked forState:UIControlStateNormal];
    }else{
        [checkbox setBackgroundImage:unChecked forState:UIControlStateNormal];
    }
    
    //adds method to check the box
    [checkbox addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:checkbox];
    checkbox.translatesAutoresizingMaskIntoConstraints = NO;
    [[checkbox.trailingAnchor constraintEqualToAnchor:cell.trailingAnchor] setActive:YES];
    [[checkbox.widthAnchor constraintEqualToConstant:checked.size.width] setActive:YES];
    [[checkbox.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor] setActive:YES];
    [[checkbox.topAnchor constraintEqualToAnchor:cell.topAnchor] setActive:YES];
    
    //creates date label
    UILabel * date = [UILabel new];
    NSDate * taskDate = [task valueForKey: @"dateStart"];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"h:mm a";
    date.text = [format stringFromDate:taskDate];
    date.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    date.font=[date.font fontWithSize:15];
    
    [cell.contentView addSubview:date];
    date.translatesAutoresizingMaskIntoConstraints = NO;
    [[date.trailingAnchor constraintEqualToAnchor:checkbox.leadingAnchor] setActive:YES];
    [[date.bottomAnchor constraintEqualToAnchor:cell.bottomAnchor] setActive:YES];
    [[date.topAnchor constraintEqualToAnchor:cell.topAnchor] setActive:YES];
    
    
    // Set the text label
    cell.textLabel.text = [task valueForKey:@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self fetchedResultsController] sections] count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id< NSFetchedResultsSectionInfo> sectionInfo = [[self fetchedResultsController] sections][section];
    return [sectionInfo numberOfObjects];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject * task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"taskView" sender:task];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"editingStyleForRowAtIndexPath");
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{    return YES; // allow that row to swipe
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak ViewController* weakSelf = self;
    UITableViewRowAction* delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSManagedObject * task = [weakSelf.fetchedResultsController objectAtIndexPath: indexPath];
        NSManagedObjectContext * moc = weakSelf.appDelegate.persistentContainer.viewContext;
        NSLog(@"Deleting Task %@", [task valueForKey:@"title"]);
        [moc deleteObject:task];
        [weakSelf.appDelegate saveContext];
    }];
        
    return @[delete];
}

#pragma mark - Cell button methods

- (void)checkButtonTapped:(UIButton*)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil)
    {
        NSManagedObject * task = [self.fetchedResultsController objectAtIndexPath:indexPath];
        ([task valueForKey:@"isChecked"]) ? NSLog(@"TRUE") : NSLog(@"FALSE");
        if([[task valueForKey:@"isChecked"]boolValue]){
            [task setValue:[NSNumber numberWithBool:NO] forKey:@"isChecked"];
            //任务没有完成
            [[HippoManager shareInstance] completeTask:NO];
            [_appDelegate saveContext];
        }else{
            [task setValue:[NSNumber numberWithBool:YES] forKey:@"isChecked"];
            //任务完成
            [[HippoManager shareInstance] completeTask:YES];
            [_appDelegate saveContext];
        }
        
        ([task valueForKey:@"isChecked"]) ? NSLog(@"TRUE") : NSLog(@"FALSE");
    }
}


#pragma mark - NSFetchedResultsControllerDelegate Implementation

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] beginUpdates];
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>) section atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)changeType
{
    //if a new task is added....
    if(changeType == NSFetchedResultsChangeInsert){
        [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    }
    //if a task is deleted...
    else if(changeType == NSFetchedResultsChangeDelete){
        [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    }

}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}

- (void)controller:(NSFetchedResultsController *)resController didChangeObject:(id)task atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType) changeType newIndexPath:(NSIndexPath *)newIndexPath
{
    if (changeType==NSFetchedResultsChangeInsert){
        [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(changeType == NSFetchedResultsChangeDelete){
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(changeType ==NSFetchedResultsChangeUpdate){
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Segues

- (IBAction)creatTaskBP:(id)sender {
    [self performSegueWithIdentifier: @"createNewTask" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"taskView"]) {
        Task_VC * segueDest = [segue destinationViewController];
        NSManagedObject * task = (NSManagedObject *) sender;
        segueDest.task = task;
        segueDest.calendar = _calendar;
    }
    if ([segue.identifier isEqualToString:@"createNewTask"]) {
        Create_Task_VC * cTask = [segue destinationViewController];
        //Create_Task_VC * segueDest = [segue destinationViewController];
       // NSManagedObject * task = (NSManagedObject *) sender;
        cTask.date = _selectedDate;
        cTask.calendar = _calendar;
    }
}


#pragma mark - <FSCalendarDelegate>

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"should select date %@",[self.dateFormatter stringFromDate:date]);
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    
    _selectedDate = date;
    [self initializeFetchedResultsController];
    [_tableView reloadData];
    
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}


#pragma mark - <FSCalendarDataSource>
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: date];
    
    NSDate * minDate = [cal dateFromComponents: components];
    
    [components setHour: 23];
    [components setMinute: 59];
    [components setSecond: 59];
    
    NSDate * maxDate = [cal dateFromComponents: components];
    
    
    NSPredicate * taskPred = [NSPredicate predicateWithFormat: @"(dateStart >= %@) AND (dateStart <= %@)", minDate, maxDate];
    
    
    [request setPredicate:taskPred];
    
    NSManagedObjectContext * moc = _appDelegate.persistentContainer.viewContext;
    
    NSArray *results = [moc executeFetchRequest:request error: nil ];
    
    if ([results count]>0){
        return 1;
    }else{
        return 0;
    };
}


#pragma mark - helper functions


@end


