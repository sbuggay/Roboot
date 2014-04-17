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
    NSString *filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSString * buffer = [NSString stringWithContentsOfFile:filepath
                                                  encoding:NSUTF8StringEncoding
                                                     error:&error];
    if (buffer == nil) NSLog (@"Error! %@", error);
    
    
    Map * newMap = [[Map alloc] initWithWidth:10 andHeight:10];
    NSMutableArray *rows = [[buffer componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]] mutableCopy];
    
    int x = 0;
    int y = 0;
    for (NSString *row in rows) {
        x = 0;
        NSLog(@"%@", row);
        for (int i = 0; i < [row length]; i++) {
            switch ([row characterAtIndex:i]) {
                case 'w':
                    // wall = w
                    [newMap set:'w' atX:x andY:y];
                    break;
                case 'a':
                    // abyss = a
                    [newMap set:'a' atX:x andY:y];
                    break;
                case 'f':
                    // finish = f
                    [newMap set:'f' atX:x andY:y];
                    break;
                case 's':
                    // start = s
                    [newMap set:'s' atX:x andY:y];
                    break;
                case 'p':
                    // push block = p
                    [newMap set:'p' atX:x andY:y];
                    break;
                case 'b':
                    // battery = b
                    [newMap set:'b' atX:x andY:y];
                    break;
                case 'e':
                    // wrench = e
                    [newMap set:'e' atX:x andY:y];
                    break;
                case 'c':
                    // cracked tile = c
                    [newMap set:'c' atX:x andY:y];
                    break;
                case 't':
                    // Tile = t
                    [newMap set:'t' atX:x andY:y];
                    break;
                default:
                    break;
            }
            x++;
        }
        y++;
    }
    return newMap;
}



@end

/*
 commit
 pull
 push
 */
