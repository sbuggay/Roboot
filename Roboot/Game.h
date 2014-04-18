//
//  MyScene.h
//  Roboot
//

//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#import "WinScene.h"
#import "Map.h"

#define ROBOOTBITMASK 1 << 0
#define WRENCHBITMASK 1 << 1
#define PORTALBITMASK 1 << 2

@interface Game : SKScene<SKPhysicsContactDelegate> {
    SKSpriteNode *roboot;
    SKSpriteNode *exit;
    int x, y;
    int tx, ty;
    bool moving;
    int direction;
    int speed;
    int commands[1000];
    int commandNum;
    int currentCommand;
    
    bool runningCommands;
    
    float background;
    
    int collectedWrenches;
}

@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@property (nonatomic) AVAudioPlayer * soundEffectsPlayer;

@property (nonatomic) Map *map;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;


-(void)startLevel;
-(void)loadLevel:(NSString *)level;
-(void)runCommand:(int)action;


@end
