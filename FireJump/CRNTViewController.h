//
//  CRNTViewController.h
//  FireJump
//
//  Created by Henry Mound on 12/23/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CRNTViewController : UIViewController <UIAccelerometerDelegate>{

    int tempy;
    int tempx;
    
    IBOutlet UIImageView *background;
    IBOutlet UIButton *playAgainButton;
    IBOutlet UIButton *mainMenu;
    IBOutlet UILabel *labelScore;

    NSInteger gameState;
    NSInteger touchState;
    NSInteger score;
    NSMutableArray *platformArray;
    NSMutableArray *coinArray;
    UIImageView *platform1;
    UIImageView *coin1;
    UIImageView *sparky;

    CGPoint sparkyVelocity;
    CGPoint tiltVelocity;
    CGPoint gravity;
}

@property (strong, nonatomic) IBOutlet UIButton *playAgainButton;
@property (strong, nonatomic) IBOutlet UIImageView *background;
@property (strong, nonatomic) IBOutlet UIButton *mainMenu;

@property (nonatomic) UIImageView *sparky;
@property (nonatomic) UIImageView *platform1;
@property (nonatomic) UIImageView *coin1;
@property (nonatomic) NSMutableArray *platformArray;
@property (nonatomic) NSMutableArray *coinArray;
@property (nonatomic) NSInteger gameState;
@property (nonatomic) NSInteger touchState;
@property (nonatomic) NSInteger score;
@property (nonatomic) UILabel *labelScore;

@property (nonatomic) CGPoint sparkyVelocity;
@property (nonatomic) CGPoint tiltVelocity;
@property (nonatomic) CGPoint gravity;

@property (nonatomic) int tempx;
@property (nonatomic) int tempy;

+ (int*)getControlState;
+ (void)setControlState:(int)cs;

@end
