//
//  platform.h
//  FireJump
//
//  Created by Henry Mound on 12/23/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface platform : NSObject{
    
    NSInteger platform_id;
    CGRect platformFrame;
    UIImage *platformImage;
    CGPoint coords;

}

-(void)setImage:(UIImage *)newImage;
-(void)setCoords:(CGPoint)newCoords;

-(CGPoint)getCoords;
-(UIImage *)getImage;
+(UIImageView *)createPlatform:(UIImage *)image frame:(CGRect)frame;

@end
