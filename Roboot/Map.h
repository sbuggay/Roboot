//
//  Map.h
//  Roboot
//
//  Created by Devan Buggay on 4/1/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject
@property (nonatomic) NSMutableArray *map;
@property (nonatomic) NSInteger width;
@property (nonatomic) NSInteger height;

- (id)initWithWidth:(int)width andHeight:(int)height;
- (int)getValueAtX:(int)x andY:(int)y;
- (void)set:(int)value atX:(int)x andY:(int)y;

@end
