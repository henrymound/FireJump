//
//  platform.m
//  FireJump
//
//  Created by Henry Mound on 12/23/13.
//  Copyright (c) 2013 Henry Mound. All rights reserved.
//

#import "platform.h"


@implementation platform

-(void)setImage:(UIImage *)newImage {
    platformImage = newImage;
}

-(UIImage *)getImage {
    return platformImage;
}

-(CGPoint)getCoords {
    return coords;
}
-(void)setCoords:(CGPoint)newCoords {
    coords = newCoords;
}

+(UIImageView *)createPlatform:(UIImage *)image frame:(CGRect)frame {
    UIImageView *platformView = [[UIImageView alloc] initWithImage:image];
    platformView.frame = frame;
    return platformView;
}




@end
