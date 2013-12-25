//
//  Coin.m
//  FireJump
//
//  Created by Henry Mound on 12/25/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import "Coin.h"

@implementation Coin

-(CGPoint)getCoords{return coords;}

-(UIImage *)getImage{return coinImage;}

+(UIImageView *)mintCoin:(UIImage *)image frame:(CGRect)frame{
    UIImageView *coinImageView = [[UIImageView alloc] initWithImage:image];
    coinImageView.frame = frame;
    return coinImageView;
}

@end
