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


@end

@implementation ViewController



- (void)viewDidLoad {
    
    _selectedDate = NSDate.date;
    
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
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

    NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
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
    NSManagedObject * task = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell.textLabel setText:[task valueForKey:@"title"]];
    NSDate * taskDate = [task valueForKey: @"dateStart"];
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"MMM dd h:mm a";
    [cell.detailTextLabel setText:[format stringFromDate:taskDate]];
    
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


@end



