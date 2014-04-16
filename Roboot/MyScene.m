//
//  MyScene.m
//  Roboot
//
//  Created by Devan Buggay on 2/9/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "MyScene.h"
#import "MapReader.h"


@implementation MyScene

@synthesize map;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Roboot test!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetHeight(self.frame) - 30);
        
        [self addChild:myLabel];
        
        
        
        roboot = [SKSpriteNode spriteNodeWithImageNamed:@"roboot_front.png"];
        
        roboot.position = CGPointMake(x * 60 + 35, y * 60 + 100);
        roboot.name = @"roboot"; //how the node is identified later
        roboot.zPosition = 1.0;
        
        tx = 1;
        ty = 1;
        speed = 2;
        
        
        commandNum = 0;
        currentCommand = 0;
    
        [self addChild:roboot];

        
        
        map = [[Map alloc] initWithWidth:5 andHeight:7];
        
        
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 7; j++) {
                SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                
                CGPoint point = {i * 60 + 35, j * 60 + 100};
                sprite.position = point;
                
                
                [self addChild:sprite];
            }
        }
        NSError *error;
        NSURL * backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"song" withExtension:@"mp3"];
        self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
        self.backgroundMusicPlayer.numberOfLoops = -1;
        [self.backgroundMusicPlayer prepareToPlay];
        [self.backgroundMusicPlayer play];
        
        
        
        
        //add controls
        SKSpriteNode *leftNode = [SKSpriteNode spriteNodeWithImageNamed:@"ButtonLeft.png"];
        leftNode.position = CGPointMake(25, 25);
        leftNode.name = @"leftNode";//how the node is identified later
        leftNode.zPosition = 1.0;
        [self addChild:leftNode];
        
        SKSpriteNode *downNode = [SKSpriteNode spriteNodeWithImageNamed:@"ButtonDown.png"];
        downNode.position = CGPointMake(75, 25);
        downNode.name = @"downNode";//how the node is identified later
        downNode.zPosition = 1.0;
        [self addChild:downNode];
        
        SKSpriteNode *upNode = [SKSpriteNode spriteNodeWithImageNamed:@"ButtonUp.png"];
        upNode.position = CGPointMake(125, 25);
        upNode.name = @"upNode";//how the node is identified later
        upNode.zPosition = 1.0;
        [self addChild:upNode];
        
        SKSpriteNode *rightNode = [SKSpriteNode spriteNodeWithImageNamed:@"ButtonRight.png"];
        rightNode.position = CGPointMake(175, 25);
        rightNode.name = @"rightNode";//how the node is identified later
        rightNode.zPosition = 1.0;
        [self addChild:rightNode];
        
        SKSpriteNode *acceptNode = [SKSpriteNode spriteNodeWithImageNamed:@"ButtonAccept.png"];
        acceptNode.position = CGPointMake(225, 25);
        acceptNode.name = @"acceptNode";//how the node is identified later
        acceptNode.zPosition = 1.0;
        [self addChild:acceptNode];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"leftNode"]) {
        NSLog(@"Left button pressed");
        commands[commandNum++] = 0;
    }
    if ([node.name isEqualToString:@"rightNode"]) {
        NSLog(@"Right button pressed");
        commands[commandNum++] = 2;

    }
    if ([node.name isEqualToString:@"upNode"]) {
        NSLog(@"Up button pressed");
        commands[commandNum++] = 1;
    }
    if ([node.name isEqualToString:@"downNode"]) {
        NSLog(@"Down button pressed");
        commands[commandNum++] = 3;
    }
    
    if ([node.name isEqualToString:@"acceptNode"]) {
        NSLog(@"Accept button pressed");
        
        [self runCommand:commands[currentCommand++]];
    }
    NSLog(@"%d|%d", tx, ty);
    
}

-(void)runCommand:(int)command {
    switch (command) {
        case 0:
            tx++;
            moving = true;
            break;
        case 1:
            ty++;
            moving = true;
            break;
        case 2:
            tx--;
            moving = true;
            break;
        case 3:
            ty --;
            moving = true;
            break;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (moving) {
        moving = false;
        if (tx * 60 > x) {
            x = x + speed;
            moving = true;
            direction = 1;
        }
        if (tx * 60 < x) {
            x = x - speed;
            moving = true;
            direction = 3;
        }
        if (ty * 60 > y) {
            y = y + speed;
            moving = true;
            direction = 0;
        }
        if (ty * 60 < y) {
            y = y - speed;
            moving = true;
            direction = 2;
        }
        
    }
    
    
    switch (direction) {
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
    }
    
    
    [roboot setPosition:CGPointMake(x, y)];
}

@end
