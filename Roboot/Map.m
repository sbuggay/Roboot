//
//  Map.m
//  Roboot
//
//  Created by Devan Buggay on 4/1/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import "Map.h"

@implementation Map

@synthesize map;

- (id)init
{
    return [self initWithWidth:0 andHeight:0];
}

- (id)initWithWidth:(int)width andHeight:(int)height
{
    _width = width;
    _height = height;
    self = [super init];
    if(self) {
        map = [NSMutableArray arrayWithCapacity: (_width*_height)];
        
        for(int i=0; i < (_width*_height); i++) [map addObject: @0];
        
        // replace 0s with something more interesting
        for(int i = 0; i < width; i++) {
            for(int j = 0; j < height; j++) {
                map[i * _height+j] = @0;
            }
        }
    }
    return self;
}

- (void)set:(int)value atX:(int)x andY:(int)y {
    map[y*_width+x] = @(value);
}

- (int)getValueAtX:(int)x andY:(int)y {
    return (int) [map[y*_width+x] integerValue];
}

- (int)getWidth {
    if (self) return (int)map[_width];
    else return 0;
}

- (int)getHeight {
    if (self) return (int)map[_height];
    else return 0;
}

- (void)printCoordinates {
    for (int y = 9; y >= 0; y--) {
        for (int x = 0; x < 9; x++) {
            printf("%d", [self getValueAtX:x andY:y]);
            if (x % 8 == 0 && x > 1) {
                printf("\n");
            }
        }
    }
}

@end