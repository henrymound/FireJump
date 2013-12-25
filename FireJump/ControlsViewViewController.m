//
//  ControlsViewViewController.m
//  FireJump
//
//  Created by Henry Mound on 12/24/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import "ControlsViewViewController.h"
#import <UIKit/UIKit.h>

@interface ControlsViewViewController ()

@end

#define cAccelerometer 2
#define cTouch 4

@implementation ControlsViewViewController
@synthesize touchTiltSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self checkSwitch];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self checkSwitch];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeTilt:(id)sender {
    [CRNTViewController setControlState:cAccelerometer];
}
- (IBAction)changeTouch:(id)sender {
    [CRNTViewController setControlState:cTouch];
}

- (void)checkSwitch{
    NSLog(@"Getting control state: %i", (int)[CRNTViewController getControlState]);
    if ((int)[CRNTViewController getControlState] == cAccelerometer) {
        [touchTiltSwitch setSelectedSegmentIndex:0];
        NSLog(@"Setting to tilt");
    }else{
        [touchTiltSwitch setSelectedSegmentIndex:1];
        NSLog(@"Setting to touch");
    }
}

@end
