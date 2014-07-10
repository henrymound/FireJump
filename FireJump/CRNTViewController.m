//
//  CRNTViewController.m
//  FireJump
//
//  Created by Henry Mound on 12/23/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import "CRNTViewController.h"
#import "platform.h"
#import "Coin.h"

@interface CRNTViewController ()

@end


#define gPlaying 1
#define gFail 2
#define gGravity 0.2195
#define gPlatformConstant 8
#define gBounce 9
#define gTouchVelocity 0.2
#define gMaxSpeed 3.7
#define gTiltBoost 1.3

#define wPlatformWidth 64
#define wPlatfromHeight 12
#define wSparkyWidth 56
#define wSparkyHeight 71
#define wNumOfPlatforms 7

#define cAccelerometer 2
#define cTouch 4

#define tLeft 1
#define tRight 2
#define tEnded 3


@implementation CRNTViewController
@synthesize tempy, tempx;
@synthesize background, platform1, sparky, platformArray, coin1;
@synthesize touchState, gameState, sparkyVelocity, gravity, playAgainButton, score, labelScore, tiltVelocity, mainMenu, coinArray;

int controlState = cAccelerometer;

- (void)viewDidLoad{
    [super viewDidLoad];

    UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/100.0f;
    platformArray = [[NSMutableArray alloc] init];
    coinArray = [[NSMutableArray alloc] init];
    [self setUpPieces];
    sparky.center = CGPointMake(132 + (wSparkyWidth / 2.0), 471 + (wSparkyHeight / 2.0));
    sparky = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sparky.png"]];
    sparky.frame = CGRectMake(sparky.center.x, sparky.center.y, 65, 82.55);
    
    [self.view addSubview:sparky];

    gameState = gPlaying;
    touchState = tEnded;
    sparkyVelocity = CGPointMake(0, 0);
    tiltVelocity = CGPointMake(0, 0);
    gravity = CGPointMake(0, gGravity);
    score = 0;
    playAgainButton.enabled = FALSE;
    playAgainButton.hidden = TRUE;
    mainMenu.enabled = FALSE;
    mainMenu.hidden = TRUE;

    [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(refresh) userInfo:nil repeats:YES];

}

- (void)refresh{
    
    if (gameState == gPlaying) {
        [self play];
    }else if(gameState == gFail){
        NSLog(@"you lose");
    }

}

- (void)play{
    

    //Main player method
    sparkyVelocity.y += gravity.y;
    
    if  (controlState == cTouch){
        if (touchState == tLeft) sparkyVelocity.x -= gTouchVelocity;
        if (touchState == tRight) sparkyVelocity.x += gTouchVelocity;
    }else if(controlState == cAccelerometer){
        sparkyVelocity.x += gravity.x;}
    
    //Wraps around screen
    if (sparky.center.x > self.view.bounds.size.width) sparky.center = CGPointMake(0, sparky.center.y);
    if (sparky.center.x < 0) sparky.center = CGPointMake(self.view.bounds.size.width, sparky.center.y);
    //Doesn't let sparky move too fast
    if (sparkyVelocity.x > gMaxSpeed){sparkyVelocity.x = gMaxSpeed;}
    if (sparkyVelocity.x < -gMaxSpeed){sparkyVelocity.x = -gMaxSpeed;}
    
    //Moves the items as height increases, randomly generates new playforms
    if (sparky.center.y < self.view.bounds.size.height/4){

        float diffHeight = ((self.view.bounds.size.height/4) - sparky.center.y);

        score += diffHeight;
        labelScore.text = [NSString stringWithFormat:@"%li", (long)score];
        [self generateNewPlatforms];
        sparky.center =  CGPointMake(sparky.center.x, sparky.center.y + diffHeight);
        
        for (int i = 0; i < [platformArray count]; i++) {
            [(UIImageView *)[platformArray objectAtIndex:i] setCenter:CGPointMake([(UIImageView *)[platformArray objectAtIndex:i] center].x, [(UIImageView *)[platformArray objectAtIndex:i] center].y + diffHeight)];}
        for (int i = 0; i < [coinArray count]; i++) {
            [(UIImageView *)[coinArray objectAtIndex:i] setCenter:CGPointMake([(UIImageView *)[coinArray objectAtIndex:i] center].x, [(UIImageView *)[coinArray objectAtIndex:i] center].y + diffHeight)];
        }
        
    }
    
    //Ends game if you lose
    if (sparky.center.y > self.view.bounds.size.height)[self losingScreen];
    
    sparky.center = CGPointMake(sparky.center.x + sparkyVelocity.x, sparky.center.y + sparkyVelocity.y);
    [self hitPlatform];
    
}

- (void)losingScreen{

    //Resets Game
    gameState = gFail;
    sparkyVelocity.x = 0;
    sparkyVelocity.y = 0;
    
    //Resets Positions
    for (int i = 0; i < [platformArray count]; i++) 
        [(UIImageView *)[platformArray objectAtIndex:i] removeFromSuperview];
    
    [platformArray removeAllObjects];
    platformArray = [[NSMutableArray alloc] init];

    [self setUpPieces];
    sparky.center = CGPointMake(132 + (wSparkyWidth / 2.0), 471 + (wSparkyHeight / 2.0));
    
    playAgainButton.hidden = FALSE;
    mainMenu.enabled = TRUE;
    playAgainButton.enabled = TRUE;
    mainMenu.hidden = FALSE;

}

- (void)setUpPieces{

    int height = (int)self.view.bounds.size.height;
    int width = (int)self.view.bounds.size.width;
    
    platform1 = [platform createPlatform:[UIImage imageNamed:@"platform.png"] frame:CGRectMake(128, 538, wPlatformWidth, wPlatfromHeight)];
    [platformArray addObject:platform1];
    [self.view addSubview:platform1];
    
    platform1 = [platform createPlatform:[UIImage imageNamed:@"platform.png"] frame:CGRectMake(164, 475, wPlatformWidth, wPlatfromHeight)];
    [platformArray addObject:platform1];
    [self.view addSubview:platform1];
    
    for (int i = 0; i < wNumOfPlatforms; i++) {
        platform1 = [platform createPlatform:[UIImage imageNamed:@"platform.png"] frame:CGRectMake((random() % width), (random() % height + 50), wPlatformWidth, wPlatfromHeight)];
        [platformArray addObject:platform1];
        [self.view addSubview:platform1];
    }
    
}

- (void)hitPlatform{
    //Checks to see if sparky hits a platform. If so, bounce!
    for (int i = 0; i < [platformArray count]; i++) {
        if ((CGRectIntersectsRect(sparky.frame, [(UIImageView *)[platformArray objectAtIndex:i] frame]))
            && ((sparky.center.y + gPlatformConstant) < [(UIImageView *)[platformArray objectAtIndex:i] center].y)
            && (sparkyVelocity.y > 0)){sparkyVelocity.y = -gBounce;}
    }
    for (int i = 0; i < [coinArray count]; i++){
        if((CGRectIntersectsRect(sparky.frame, [(UIImageView *)[coinArray objectAtIndex:i] frame]))){
            [(UIImageView *)[coinArray objectAtIndex:i] removeFromSuperview];
            score+=50;
            labelScore.text = [NSString stringWithFormat:@"%li", (long)score];
        }
    }
}

- (void)generateNewPlatforms{
    float viewWidth = self.view.bounds.size.width;
    float fViewWidthMinusPlatformWidth = viewWidth - (float)(wPlatformWidth);
    int iViewWidthMinusPlatformWidth = (int)fViewWidthMinusPlatformWidth;
    
    for (int i = 0; i < [platformArray count]; i++) {
        if([(UIImageView *)[platformArray objectAtIndex:i] center].y >= (self.view.bounds.size.height + 6)){
            float x = random() % iViewWidthMinusPlatformWidth;
            x += (float)(wPlatformWidth/2);
            float y = (random() % 20) - (wPlatfromHeight/2);
            [(UIImageView *)[platformArray objectAtIndex:i] setCenter:CGPointMake(x, y)];
            [self setUpCoinArray:1 onPlatform:CGPointMake(x, y)];
        }
    }
    
}

- (void)setUpCoinArray:(int)arraySize onPlatform:(CGPoint)platformPoint{
    
    for (int i = 0; i < arraySize; i++) {
        
        coin1 = [Coin mintCoin:[UIImage imageNamed:@"index5.png"] frame:CGRectMake((platformPoint.x), (random() % 200)- 300, 35, 35)];
        [coinArray addObject:coin1];
        [self.view addSubview:coin1];
        
    }
}

- (IBAction)playAgain:(id)sender {
    gameState = gPlaying;
    playAgainButton.enabled = FALSE;
    playAgainButton.hidden = TRUE;
    mainMenu.enabled = FALSE;
    mainMenu.hidden = TRUE;
    score = 0;
    labelScore.text = [NSString stringWithFormat:@"%li", (long)score];
}







//Controls
+ (int)getControlState{return controlState;}
+ (void)setControlState:(int)cs{controlState = cs;}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
    if (controlState == cAccelerometer) {gravity.x = acceleration.x * gTiltBoost;}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (gameState == gPlaying && controlState == cTouch) {
        UITouch *touch = [[event allTouches] anyObject];
        CGPoint location = [touch locationInView:touch.view];
        
        if(location.x < (self.view.bounds.size.width / 2)){
            touchState = tLeft;
            sparkyVelocity.x -= gTouchVelocity;}
        else{
            touchState = tRight;
            sparkyVelocity.x += gTouchVelocity;}
        
        }
    
    }

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(controlState == cTouch)touchState = tEnded;}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];

    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


@end
