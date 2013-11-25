//
//  Node.m
//  exobrain
//
//  Created by Timothy Lee on 11/15/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "Node.h"

@implementation Node

- (id)init {
    self = [super init];
    if (self) {
        self.linkedNodes = [NSMutableSet set];
    }
    
    return self;
}

- (void)linkToNode:(Node *)node {
    [self.linkedNodes addObject:node];
    [node.linkedNodes addObject:self];
}

@end
