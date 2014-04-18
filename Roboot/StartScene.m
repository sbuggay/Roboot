//
//  StartScene.m
//  Roboot
//
//  Created by Devan Buggay on 4/14/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "StartScene.h"
#import "Game.h"

@implementation StartScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        
        SKSpriteNode *start = [SKSpriteNode spriteNodeWithImageNamed:@"start"];
        start.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:start];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    SKScene *game  = [[Game alloc] initWithSize:self.size];
    SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:1];
    [self.view presentScene:game transition:doors];
    
    
}

@end
