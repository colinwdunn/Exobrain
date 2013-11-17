//
//  Node.h
//  exobrain
//
//  Created by Timothy Lee on 11/15/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGPoint center;
@property (nonatomic, strong) NSMutableSet *linkedNodes;

@end
