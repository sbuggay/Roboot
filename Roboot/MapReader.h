//
//  MapReader.h
//  Roboot
//
//  Created by Michael on 4/13/14.
//  Copyright (c) 2014 Devan Buggay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Map.h"

@interface MapReader : NSObject

- (Map*)readFile:(NSString*)fileName;

@end
