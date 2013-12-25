//
//  ControlsViewViewController.h
//  FireJump
//
//  Created by Henry Mound on 12/24/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRNTViewController.h"


@interface ControlsViewViewController : UIViewController{
    IBOutlet UISegmentedControl *touchTiltSwitch;
}


@property (strong, nonatomic) IBOutlet UISegmentedControl *touchTiltSwitch;

@end
