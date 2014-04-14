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
        for(int i = 0; i < 6; i++) {
            for(int j = 0; j < 9; j++) {
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

@end

/*
Tiles       8
Fall tiles	7
wrenches	6
battery     5
pushblock	4
start       3
finish      2
abyss       1
wall        0
*/