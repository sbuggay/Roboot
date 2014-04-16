//
//  LossScene.m
//  Roboot
//
//  Created by Michael on 4/15/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "LossScene.h"

@implementation LossScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        SKSpriteNode *start = [SKSpriteNode spriteNodeWithImageNamed:@"failScreen"];
        start.position = CGPointMake(CGRectGetMidX(self.frame),
                                     CGRectGetMidY(self.frame));
        [self addChild:start];
    }
    return self;
}

@end
