//
//  MapReader.m
//  Roboot
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "MapReader.h"


@implementation MapReader

+ (Map*)readFile:(NSString*)fileName {
    
    NSError *error;
    NSString * buffer = [NSString stringWithContentsOfFile:fileName
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    if (buffer == nil)
        NSLog (@"Error! %@", error);
    int pieces[100] = {0};
    for (int i=0; i < 100; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [buffer characterAtIndex:i]];
        if ([ichar isEqualToString:@"\n"]) {
            continue;
        }
        pieces[i] = (int)[ichar integerValue];
    }
    
    Map * newMap = [[Map alloc] initWithWidth:10 andHeight:10];
    for (int x = 0, y = 0, z = 0; z < 100; x++, z++) {
        if (x % 9 == 0 && x > 1 && y != 9) {
            y++;
            x = 0;
        }
        else if (x == 9 && y == 9) break;
        switch (pieces[x]) {
            case 0:
                // wall
                [newMap set:0 atX:x andY:y];
                break;
            case 1:
                // abyss
                [newMap set:1 atX:x andY:y];
                break;
            case 2:
                // finish
                [newMap set:2 atX:x andY:y];
                break;
            case 3:
                // start
                [newMap set:3 atX:x andY:y];
                break;
            case 4:
                // push block
                [newMap set:4 atX:x andY:y];
                break;
            case 5:
                // battery
                [newMap set:5 atX:x andY:y];
                break;
            case 6:
                // wrench
                [newMap set:6 atX:x andY:y];
                break;
            case 7:
                // Fall tile
                [newMap set:7 atX:x andY:y];
                break;
            case 8:
                // Tile
                [newMap set:8 atX:x andY:y];
                break;
            default:
                break;
        }
    }
    
    return newMap;
}

@end
