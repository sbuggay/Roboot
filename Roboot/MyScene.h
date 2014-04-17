//
//  MyScene.h
//  Roboot
//

//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#import "Map.h"


@interface MyScene : SKScene {
    SKNode *roboot;
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
}

@property (nonatomic) AVAudioPlayer * backgroundMusicPlayer;
@property (nonatomic) AVAudioPlayer * soundEffectsPlayer;

@property (nonatomic) Map *map;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;

-(void)runCommand:(int)action;

@end
