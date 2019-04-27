//
//  ViewController.m
//  Planner Pet
//
//  Created by Will Powers on 4/9/19.
//  Copyright © 2019 Will Powers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *taskViewB;
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
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    //Calendar Stuff
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"MMM dd h:mm a";
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
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
    [[cell subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSManagedObject * task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    

    
    UIView* cellView = [UIView new];
    cellView.frame = CGRectMake(0.0, 0.0, cell.bounds.size.width, cell.bounds.size.height);
    
    
    //sets image states
    UIImage* checked = [UIImage imageNamed:@"checked.png"];
    UIImage* unChecked = [UIImage imageNamed:@"unchecked.png"];
    //sets up button
    UIButton *checkbox = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, checked.size.width, checked.size.height);
    checkbox.frame = frame;
    checkbox.backgroundColor = [UIColor clearColor];
    //sets up images for states

    ([task valueForKey:@"isChecked"]) ? NSLog(@"TRUE") : NSLog(@"FALSE");
    if ([[task valueForKey:@"isChecked"]boolValue]){
        [checkbox setBackgroundImage:checked forState:UIControlStateNormal];
    }else{
        [checkbox setBackgroundImage:unChecked forState:UIControlStateNormal];
    }
    
    
    //adds method to check the box
    [checkbox addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    int checkboxCenterWidth = (cell.frame.size.width) - (checkbox.frame.size.width  / 2);
    int checkboxCenterHeight = cell.frame.size.height / 2;
    checkbox.center =  CGPointMake(checkboxCenterWidth, checkboxCenterHeight);
    
    //creates date label
    UILabel * date = [UILabel new];
    NSDate * taskDate = [task valueForKey: @"dateStart"];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"h:mm a";
    date.text = [format stringFromDate:taskDate];
    date.textColor = [UIColor grayColor];
    date.font=[date.font fontWithSize:15];
    date.frame = CGRectMake(0.0, 0.0, date.intrinsicContentSize.width, date.intrinsicContentSize.height);
    int dateCenterWidth = (cell.frame.size.width) - (10*checkbox.frame.size.width/6);
    int dateCenterHeight = cell.frame.size.height / 2;
    date.center =  CGPointMake(dateCenterWidth, dateCenterHeight);
    
    
//    Creates title button
    UILabel* title = [UILabel new];
    //creates text for button
    title.text = [task valueForKey:@"title"];
    
    // aligns button in cell frame
    title.frame = CGRectMake(20, cell.frame.size.height / 4, title.intrinsicContentSize.width, title.intrinsicContentSize.height);
//    int titleCenterWidth = (title.frame.size.width);
//    int titleCenterHeight = cell.frame.size.height / 2;
//    title.center =  CGPointMake(titleCenterWidth, titleCenterHeight);
    
    

    [cellView addSubview:title];
    [cellView addSubview:date];
    [cellView addSubview:checkbox];
    [cell addSubview:cellView];
    
    
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
            [_appDelegate saveContext];
        }else{
            [task setValue:[NSNumber numberWithBool:YES] forKey:@"isChecked"];
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
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [[self tableView] endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [[self tableView] insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - Segues

- (IBAction)creatTaskBP:(id)sender {
    [self performSegueWithIdentifier: @"createNewTask" sender:self];
}

- (IBAction)viewTaskBP:(id)sender {
    
//    [self performSegueWithIdentifier:@"taskView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"taskView"]) {
        Task_VC * segueDest = [segue destinationViewController];
        NSManagedObject * task = (NSManagedObject *) sender;
        segueDest.task = task;
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
//deleted


#pragma mark - helper functions


@end



