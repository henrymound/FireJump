//
//  Coin.h
//  FireJump
//
//  Created by Henry Mound on 12/25/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Coin : NSObject{

    UIImageView *coinImageView;
    NSInteger coin_id;
    CGRect coinFrame;
    UIImage *coinImage;
    CGPoint coords;
    
}

-(void)setImage:(UIImage *)newImage;
-(void)setCoords:(CGPoint)newCoords;

-(CGPoint)getCoords;
-(UIImage *)getImage;
+(UIImageView *)mintCoin:(UIImage *)image frame:(CGRect)frame;


@end
