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


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)buttonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createNewTask" sender:self];
}


@end
