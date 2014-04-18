//
//  MyScene.m
//  Roboot
//
//  Created by Devan Buggay on 2/9/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Game.h"
#import "MapReader.h"


@implementation Game

@synthesize map;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        
        
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
        
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
        
        [self startLevel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    NSError *error;
    NSURL * soundEffectsURL;
    
    if ([node.name isEqualToString:@"leftNode"]) {
        NSLog(@"Left button pressed");
        commands[commandNum++] = 2;
        soundEffectsURL = [[NSBundle mainBundle] URLForResource:@"buttonOne" withExtension:@"mp3"];
        self.soundEffectsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectsURL error:&error];
        [self.soundEffectsPlayer prepareToPlay];
        [self.soundEffectsPlayer play];
    }
    if ([node.name isEqualToString:@"rightNode"]) {
        NSLog(@"Right button pressed");
        commands[commandNum++] = 0;
        soundEffectsURL = [[NSBundle mainBundle] URLForResource:@"buttonTwo" withExtension:@"mp3"];
        self.soundEffectsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectsURL error:&error];
        [self.soundEffectsPlayer prepareToPlay];
        [self.soundEffectsPlayer play];
    }
    if ([node.name isEqualToString:@"upNode"]) {
        NSLog(@"Up button pressed");
        commands[commandNum++] = 1;
        soundEffectsURL = [[NSBundle mainBundle] URLForResource:@"buttonThree" withExtension:@"mp3"];
        self.soundEffectsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectsURL error:&error];
        [self.soundEffectsPlayer prepareToPlay];
        [self.soundEffectsPlayer play];
    }
    if ([node.name isEqualToString:@"downNode"]) {
        NSLog(@"Down button pressed");
        commands[commandNum++] = 3;
        soundEffectsURL = [[NSBundle mainBundle] URLForResource:@"buttonFour" withExtension:@"mp3"];
        self.soundEffectsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectsURL error:&error];
        [self.soundEffectsPlayer prepareToPlay];
        [self.soundEffectsPlayer play];
    }
    
    if ([node.name isEqualToString:@"acceptNode"]) {
        NSLog(@"Accept button pressed");
        soundEffectsURL = [[NSBundle mainBundle] URLForResource:@"robootMoving" withExtension:@"mp3"];
        self.soundEffectsPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundEffectsURL error:&error];
        [self.soundEffectsPlayer prepareToPlay];
        [self.soundEffectsPlayer play];
        runningCommands = true;
    }
    
    
}

-(void)startLevel {
    
    commandNum = 0;
    currentCommand = 0;
    runningCommands = false;
    moving = false;
    speed = 1.5;
    
    collectedWrenches = 0;
    
    [self loadLevel:@"level_1"];
}

-(void)loadLevel:(NSString *)level {
    map = [MapReader readFile:level];
    
    
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            
            CGPoint point = {i * 32 + 16, j * 32 + 150};
            SKSpriteNode *sprite;
            SKSpriteNode *item;
            switch ([map getValueAtX:i andY:j]) {
                case 'w':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"wall"];
                    break;
                case 'a':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"abyss"];
                    break;
                case 'f':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"portal-closed"];
                    sprite.physicsBody.categoryBitMask = PORTALBITMASK;
                    //                    item.physicsBody.collisionBitMask;
                    sprite.physicsBody.contactTestBitMask = ROBOOTBITMASK;
                    exit = sprite;
                    break;
                case 's':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                    tx = i;
                    ty = j;
                    x = tx * 32 + 16;
                    y = ty * 32 + 150;
                    break;
                case 'p':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                    item = [SKSpriteNode spriteNodeWithImageNamed:@"block"];
                    item.position = point;
                    item.zPosition = 1.0;
                    item.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:item.frame.size];
                    item.physicsBody.usesPreciseCollisionDetection = YES;
//                    item.physicsBody.categoryBitMask = WRENCHBITMASK;
//                    item.physicsBody.collisionBitMask = ROBOOTBITMASK;
                    item.physicsBody.contactTestBitMask = ROBOOTBITMASK | WRENCHBITMASK;
                    [self addChild:item];
                    break;
                case 'b':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                    
                    break;
                case 'e':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                    item = [SKSpriteNode spriteNodeWithImageNamed:@"wrench"];
                    item.position = point;
                    item.zPosition = 1.0;
                    item.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:item.frame.size];
                    item.physicsBody.usesPreciseCollisionDetection = YES;
                    item.physicsBody.categoryBitMask = WRENCHBITMASK;
//                    item.physicsBody.collisionBitMask;
                    item.physicsBody.contactTestBitMask = ROBOOTBITMASK;
                    item.name = @"wrench";
                    [self addChild:item];
                    break;
                case 'c':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"fall"];
                    break;
                case 't':
                    sprite = [SKSpriteNode spriteNodeWithImageNamed:@"tile"];
                    break;
                default:
                    break;
            }
            
            sprite.position = point;
            
            
            [self addChild:sprite];
        }
        
    }
    
    roboot = [SKSpriteNode spriteNodeWithImageNamed:@"roboot_front.png"];
    roboot.name = @"roboot"; //how the node is identified later
    roboot.zPosition = 1.0;
    
    
    roboot.position = CGPointMake(x, y);
    
    
    roboot.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:roboot.frame.size];
    roboot.physicsBody.usesPreciseCollisionDetection = YES;
    roboot.physicsBody.categoryBitMask = ROBOOTBITMASK;
    roboot.physicsBody.collisionBitMask = 0;
    roboot.physicsBody.contactTestBitMask = WRENCHBITMASK | PORTALBITMASK;

    
    [self addChild:roboot];
}

-(void)runCommand:(int)command {
    NSLog(@"Running command: %d", command);
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
    if (runningCommands) {
        if (currentCommand >= commandNum) {
            runningCommands = false;
        }
        else if (moving == false){
            [self runCommand:commands[currentCommand++]];
        }
        
    }
    
    if (moving) {
        moving = false;
        if (tx * 32 + 16 > x) {
            x = x + speed;
            moving = true;
            direction = 0;
        }
        if (tx * 32 + 16 < x) {
            x = x - speed;
            moving = true;
            direction = 2;
        }
        if (ty * 32 + 150> y) {
            y = y + speed;
            moving = true;
            direction = 1;
        }
        if (ty * 32 + 150< y) {
            y = y - speed;
            moving = true;
            direction = 3;
        }
    }
    

    switch (direction) {
        case 0:
            roboot.texture = [SKTexture textureWithImageNamed:@"roboot_right"];
            break;
        case 1:
            roboot.texture = [SKTexture textureWithImageNamed:@"roboot_back"];
            break;
        case 2:
            roboot.texture = [SKTexture textureWithImageNamed:@"roboot_left"];
            break;
        case 3:
            roboot.texture = [SKTexture textureWithImageNamed:@"roboot_front"];
            break;
    }
    
    if (collectedWrenches >= 3) {
        exit.texture = [SKTexture textureWithImageNamed:@"portal-open"];
    }
    
    [roboot setPosition:CGPointMake(x, y)];
    
    self.backgroundColor = [SKColor colorWithRed:sin(background * 2) green:cos(background) blue:(sin(background + cos(background * 2)) / 2) alpha:1];
    
    background += .001;
}

- (void) didBeginContact:(SKPhysicsContact *)contact
{

    SKPhysicsBody* firstBody;
    SKPhysicsBody* secondBody;
    // 2 Assign the two physics bodies so that the one with the lower category is always stored in firstBody
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == ROBOOTBITMASK && secondBody.categoryBitMask == WRENCHBITMASK) {
        [secondBody.node removeFromParent];
        collectedWrenches++;
    }
    
    if (firstBody.categoryBitMask == ROBOOTBITMASK && secondBody.categoryBitMask == PORTALBITMASK) {
        NSLog(@"Win!");
        if (collectedWrenches >= 3) {
            SKScene *win  = [[WinScene alloc] initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:1];
            [self.view presentScene:win transition:doors];
        }
    }
    
}

@end
