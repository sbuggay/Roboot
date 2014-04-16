//
//  MapReader.m
//  Roboot
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "MapReader.h"


@implementation MapReader

- (Map*)readFile:(NSString*)fileName {
    
    NSError *error;
    NSString * buffer = [NSString stringWithContentsOfFile:fileName
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    if (buffer == nil) NSLog (@"Error! %@", error);
    int pieces[100] = {0};
    for (int i=0; i < 100; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [buffer characterAtIndex:i]];
        if ([ichar isEqualToString:@"\n"]) continue;
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
                // wall = w
                [newMap set:'w' atX:x andY:y];
                break;
            case 1:
                // abyss = a
                [newMap set:'a' atX:x andY:y];
                break;
            case 2:
                // finish = f
                [newMap set:'f' atX:x andY:y];
                break;
            case 3:
                // start = s
                [newMap set:'s' atX:x andY:y];
                break;
            case 4:
                // push block = p
                [newMap set:'p' atX:x andY:y];
                break;
            case 5:
                // battery = b
                [newMap set:'b' atX:x andY:y];
                break;
            case 6:
                // wrench = w
                [newMap set:'w' atX:x andY:y];
                break;
            case 7:
                // cracked tile = c
                [newMap set:'c' atX:x andY:y];
                break;
            case 8:
                // Tile = t
                [newMap set:'t' atX:x andY:y];
                break;
            default:
                break;
        }
    }
    
    return newMap;
}

@end

/*
 commit
 pull
 push
*/