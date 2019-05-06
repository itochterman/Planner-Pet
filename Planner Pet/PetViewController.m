//
//  PetViewController.m
//  Planner Pet
//
//  Created by Wenyin Zheng on 4/26/19.
//  Copyright © 2019 Wenyin Zheng. All rights reserved.
//

#import "PetViewController.h"
#import "AppDelegate.h"

#import "HippoMainView.h"
#import "Planner_Pet-Swift.h"
#import "HippoManager.h"

@interface PetViewController ()<GameViewControllerDelegate,GameFlyViewControllerDelegate>

@property (nonatomic,strong)HippoMainView *hippoMianView;

- (IBAction)dateChanged:(id)sender;
@property NSDate * date;
@property NSManagedObjectContext * CDContext;
@property (weak, nonatomic) IBOutlet UITextField *addDate;
@property AppDelegate * appDelegate;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) IBOutlet UILabel *dailyTotal;
@property (weak, nonatomic) IBOutlet UILabel *dailyaverage;
@property (weak, nonatomic) IBOutlet UILabel *weeklyTotal;
@property (weak, nonatomic) IBOutlet UILabel *weeklyaverage;
@property (weak, nonatomic) IBOutlet UILabel *montlyTotal;
@property (weak, nonatomic) IBOutlet UILabel *montlyTotalaverage;
@property (weak, nonatomic) IBOutlet UILabel *yearlyTotal;
@property (weak, nonatomic) IBOutlet UILabel *yearlyaverage;
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UIButton *data;

@property (weak, nonatomic) IBOutlet UIView *dataView;

@end

@implementation PetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.back.layer.cornerRadius = self.back.frame.size.height/6.66;
    self.back.clipsToBounds = YES;
    
    self.data.layer.cornerRadius = self.data.frame.size.height/6.66;
    self.data.clipsToBounds = YES;
    
    self.dataView.layer.cornerRadius = self.dataView.frame.size.height/30;
    self.dataView.clipsToBounds = YES;
    self.dataView.backgroundColor = [UIColor colorWithRed:0 green:(206/255.0) blue:(209/255.0) alpha:0.5];
    
    [SVProgressHUD showInfoWithStatus:@"Double tap on Mr. Hippo and his buttons!"];
    [SVProgressHUD dismissWithDelay:3.0];
    
//    [self.view.layer insertSublayer:myFkngAwsmGrad atIndex:0];
//    self.view.layer.backgroundColor = [[UIColor clearColor] CGColor];\
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sand.jpg"]];
    
    UIImage * backgroundImage = [UIImage imageNamed:@"hippoEn.jpg"];
    
   // [self resizeImageWithImage: backgroundImage toSize: CGSizeMake(100, 200)];
    
    UIImageView * imageBack = [[UIImageView  alloc] initWithFrame: self.view.bounds];
    [imageBack setImage: backgroundImage];
    [self.view addSubview:imageBack];
    [self.view sendSubviewToBack:imageBack];
    _appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _CDContext = _appDelegate.persistentContainer.viewContext;
    [self setLabels];
    [_dataView setHidden:YES];

    [self configUI];
}
    
- (UIImage*)resizeImageWithImage:(UIImage*)image toSize:(CGSize)newSize{
        // Create a graphics image context
        UIGraphicsBeginImageContext(newSize);
        
        // draw in new context, with the new size
        [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        
        // Get the new image from the context
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // End the context
        UIGraphicsEndImageContext();
        return newImage;

}

- (void)configUI {
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.navigationController.navigationBar setTranslucent:NO];
    self.hippoMianView.isCanShow=YES;
    [self.view addSubview:self.hippoMianView];
    __weak typeof(self) weakSelf = self;
    [self.hippoMianView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.view.mas_right).offset(-STSizeWithWidth(30.0));
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(STSizeWithWidth(500.0));
        make.width.mas_equalTo(STSizeWithWidth(600.0));
        
    }];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    if (self.hippoMianView !=nil){
        self.hippoMianView.isCanShow=NO;
        self.hippoMianView=nil;
        
    }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)back:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)setLabels{
    NSArray* dailyTasks = [self getData:0];
    int dailyTasksCompleted = [self countCompleted: dailyTasks];
    NSArray* weekTasks = [self getData:1];
    int weekTasksCompleted = [self countCompleted: weekTasks];
    NSArray* monthTasks = [self getData:2];
    int monthTasksCompleted = [self countCompleted: monthTasks];
    NSArray* yearTasks = [self getData:3];
    int yearTasksCompleted = [self countCompleted: yearTasks];
    
    //*100/arr.count
    self.dailyTotal.text = [NSString stringWithFormat:@"%d",dailyTasksCompleted];
    self.dailyTotal.textColor = [UIColor whiteColor];
    self.dailyaverage.text = (dailyTasks.count==0) ? @"N/A" : [NSString stringWithFormat:@"%lu%%",dailyTasksCompleted*100/dailyTasks.count];
    self.dailyaverage.textColor = [UIColor whiteColor];
    
    
    self.weeklyTotal.text = [NSString stringWithFormat:@"%d",weekTasksCompleted];
    self.weeklyTotal.textColor = [UIColor whiteColor];
    self.weeklyaverage.text = (weekTasks.count==0) ? @"N/A" : [NSString stringWithFormat:@"%lu%%",weekTasksCompleted*100/weekTasks.count];
    self.weeklyaverage.textColor = [UIColor whiteColor];

    self.montlyTotal.text = [NSString stringWithFormat:@"%d",monthTasksCompleted];
    self.montlyTotal.textColor = [UIColor whiteColor];

    self.montlyTotalaverage.text = (monthTasks.count==0) ? @"N/A" : [NSString stringWithFormat:@"%lu%%",monthTasksCompleted*100/monthTasks.count];
    self.montlyTotalaverage.textColor = [UIColor whiteColor];

    self.yearlyTotal.text = [NSString stringWithFormat:@"%d",yearTasksCompleted];
    self.yearlyTotal.textColor = [UIColor whiteColor];

    self.yearlyaverage.text = (yearTasks.count==0) ? @"N/A" : [NSString stringWithFormat:@"%lu%%",yearTasksCompleted*100/yearTasks.count];
    self.yearlyaverage.textColor = [UIColor whiteColor];


}



-(int) countCompleted: (NSArray*) arr{
    int numCompleted = 0;
    for (id object in arr){
        numCompleted += [[object valueForKey:@"isChecked"]boolValue] ? 1 : 0;
    }
    return numCompleted;
}



-(NSArray*) getData:(int) bounds {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Task"];
    
    NSDate * currentDate = NSDate.date;
    NSDate * minDate;
    NSDate * maxDate;
    
    NSSortDescriptor *dateSort = [NSSortDescriptor sortDescriptorWithKey:@"dateStart" ascending:YES];
    
    [request setSortDescriptors:@[dateSort]];
    
    switch (bounds) {
        case 0:
        {
            //Daily TASKS
            NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
            
            
            NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
            
//            //LOGGING PUPROSES DELETE!!!!
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"MMM dd h:mm a"];
//            NSString *stringFromDate =
//            [formatter stringFromDate:[cal dateFromComponents: components]];
//            NSLog(stringFromDate);
//            ///DELETE!!!!
            
            minDate = [cal dateFromComponents: components];
            
            [components setHour: 23];
            [components setMinute: 59];
            [components setSecond: 59];
            
//            //LOGGING PUPROSES DELETE!!!!
//            stringFromDate = [formatter stringFromDate:[cal dateFromComponents: components]];
//            NSLog(stringFromDate);
//            ///DELETE!!!!
            
            maxDate = [cal dateFromComponents: components];
            //Daily TASKS
            
        }
            break;
        case 1:
        {
            //WEEKLY TASKS
            NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
            cal.firstWeekday = 1;
            NSDate *startOfTheWeek;
            NSDate *endOfWeek;
            NSTimeInterval interval;
            [cal rangeOfUnit:NSCalendarUnitWeekOfYear
                   startDate:&startOfTheWeek
                    interval:&interval
                     forDate:currentDate];
            endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval - 1];
            
            
            NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: startOfTheWeek];
            
            minDate = [cal dateFromComponents: components];
            
            components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: endOfWeek];
            
            [components setHour: 23];
            [components setMinute: 59];
            [components setSecond: 59];
            
            maxDate = [cal dateFromComponents: components];
            //WEEKLY TASKS
            
        }
            break;
        case 2:
        {
            //MONTHLY TASKS
            //WEEKLY TASKS
            NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
            
            NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
            
            [components setDay:1];
            
            minDate = [cal dateFromComponents: components];
            
            [components setMonth:[components month]+1];
            [components setDay:0];
            
            [components setHour: 23];
            [components setMinute: 59];
            [components setSecond: 59];
            
            maxDate = [cal dateFromComponents: components];
            //WEEKLY TASKS
            
            //MONTHLY TASKS
            break;
        }
        case 3:
        {
             //YEARLY TASKS
            NSCalendar * cal = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
            
            NSDateComponents * components = [cal components: NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate: currentDate];
            
            [components setMonth:1];
            [components setDay:1];
            
            minDate = [cal dateFromComponents: components];
            
            [components setMonth:12];
            [components setMonth:[components month]+1];
            [components setDay:0];
            
            [components setHour: 23];
            [components setMinute: 59];
            [components setSecond: 59];
            
            maxDate = [cal dateFromComponents: components];
            
             //YEARLY TASKS
            break;
        }
        default:
            break;
    }
    
    
    NSPredicate * taskPred = [NSPredicate predicateWithFormat: @"(dateStart >= %@) AND (dateStart <= %@)", minDate, maxDate];


    [request setPredicate:taskPred];

    NSManagedObjectContext * moc = _appDelegate.persistentContainer.viewContext;

    NSFetchedResultsController* FSFRC = [NSFetchedResultsController alloc];
    FSFRC = [FSFRC initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];
    [self setFetchedResultsController: FSFRC];

    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    NSArray *tempArray = [[NSArray alloc] initWithArray:self.fetchedResultsController.fetchedObjects];
    
//    NSLog(@"Temp Array Count is @lu", tempArray.count);
    
    return tempArray;

}

- (IBAction)didSelectDataButton:(id)sender {
    
    [_dataView setHidden:!_dataView.isHidden];
}

- (void)configHippoPlayGame {
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];
    if (model.exp < HippoUnit*10 || model.clean <= 0) {
        [SVProgressHUD showErrorWithStatus:@"I’m too HUNGRY to play games with u now. \n\n Do some tasks and feed me cheeseburgers!"];
        [SVProgressHUD dismissWithDelay:3.0];
        return;
    }
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"game" message:@"chooseGame" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"game1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self game1];
    }];
    UIAlertAction *suerAction2 = [UIAlertAction actionWithTitle:@"game2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self game2];
    }];
    [alertCtr addAction:suerAction];
    [alertCtr addAction:suerAction2];
    [self presentViewController:alertCtr animated:YES completion:nil];
    
    
    
    
    
}
- (void)game1 {
    
//    configDataWithExpSuccess
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"Tip" message:@"YOU HAVE FOR TOTAL 5 MINS TO EARN YOUR POINTS; EVERY FOX = 1 POINT; IF YOU HAVE GREATER THAN 10 FOXS , HIPPO MOOD+2; GREATER THAN 20, HIPPO MOOD +3 AND SO ON, TRY TO HIT AS MUCH AS YOU CAN!!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"I know" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        GameViewController *gameVC = [[GameViewController alloc]init];
        gameVC.delegate = self;
        [self presentViewController:gameVC animated:YES completion:nil];
    }];
    [alertCtr addAction:suerAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
}
- (void)game2 {
    
    HippoModel *model = [[HippoManager shareInstance] configDataWithModel];
    if (model.exp < HippoUnit*10) {
        [SVProgressHUD showErrorWithStatus:@"I'm too tired to play games!"];
        [SVProgressHUD dismissWithDelay:3.0];
        return;
    }
    
    UIAlertController *alertCtr = [UIAlertController alertControllerWithTitle:@"Tip" message:@"You have UNLIMTED time for this game！Try to collect as much GOLD mental as you can... FIVE gold= ONE food pt" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *suerAction = [UIAlertAction actionWithTitle:@"I know" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self.hippoMianView configWithChangeExp:HippoUnit*10];
        [[HippoManager shareInstance] playGameSuccess:^(float mood, float food, float exp, float clean) {
            
        }];
        GameFlyViewController *gameVC = [[GameFlyViewController alloc]init];
        gameVC.delegate = self;
        [self presentViewController:gameVC animated:YES completion:nil];
    }];
    [alertCtr addAction:suerAction];
    [self presentViewController:alertCtr animated:YES completion:nil];
}

#pragma mark - GameViewControllerDelegate
- (void)playGameSuccess {
    [[HippoManager shareInstance] playGameSuccess:^(float mood, float food, float exp, float clean) {
        
    }];
}
- (void)playFlyGameSuccess {
    
}
#pragma mark - get
- (HippoMainView *)hippoMianView {
    if (!_hippoMianView) {
        __weak typeof(self) weakSelf = self;
        _hippoMianView = [[HippoMainView alloc]initWithEnterAction:^{
            [weakSelf configHippoPlayGame];
        }];
        _hippoMianView.isCanShow = YES;
    }
    return _hippoMianView;
}

- (void)orientationToPortrait:(UIInterfaceOrientation)orientation {
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];
    [invocation invoke];
}

@end
