//
//  CanvasView.m
//  exobrain
//
//  Created by Timothy Lee on 11/15/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "CanvasView.h"
#import "NodeView.h"
#import "Node.h"
#import <QuartzCore/QuartzCore.h>

@interface CanvasView ()

@property (nonatomic, assign) BOOL linking;
@property (nonatomic, strong) NodeView *sourceNode;
@property (nonatomic, assign) CGPoint currentTouchPosition;

@end

@implementation CanvasView

- (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat h, s, b, a;
    if ([c getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b / 0.75
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat h, s, b, a;
    if ([c getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b / 0.75
                               alpha:a];
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.alwaysBounceHorizontal = YES;
        self.alwaysBounceVertical = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blueColor] set];
    
    // Draws a user creating a new connection
    if (self.linking) {
        CGContextMoveToPoint(context, self.sourceNode.center.x, self.sourceNode.center.y);
        CGContextAddLineToPoint(context, self.currentTouchPosition.x, self.currentTouchPosition.y);
        CGContextStrokePath(context);
    }
    
    // Draws existing connections
    for (Node *node in self.nodes) {
        for (Node *linkedNode in node.linkedNodes) {
            CGContextMoveToPoint(context, node.center.x, node.center.y);
            CGContextAddLineToPoint(context, linkedNode.center.x, linkedNode.center.y);
            CGContextStrokePath(context);
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    UIView *touchedView = [self hitTest:location withEvent:event];
    
    if ([touchedView isKindOfClass:[NodeView class]]) {
        NSLog(@"I am inside a node");
        self.sourceNode = (NodeView *)touchedView;
        self.currentTouchPosition = self.sourceNode.center;
        
        UIColor *darkerColor = [self darkerColorForColor:self.sourceNode.backgroundColor];
        self.sourceNode.backgroundColor = darkerColor;
        
    } else if ([touchedView isKindOfClass:[CanvasView class]]) {
        NSLog(@"I am inside the canvas");
    }
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches moves");
    UITouch *touch = [touches anyObject];
    self.currentTouchPosition = [touch locationInView:self];
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches cancelled");
    self.sourceNode = nil;
    
    UIColor *lighterColor = [self lighterColorForColor:self.sourceNode.backgroundColor];
    self.sourceNode.backgroundColor = lighterColor;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    UIView *touchedView = [self hitTest:location withEvent:event];
    if ([touchedView isKindOfClass:[NodeView class]]) {
        [self.sourceNode.node linkToNode:((NodeView *)touchedView).node];
    }
    
    NSLog(@"touches ended");
    self.sourceNode = nil;
}

#pragma mark - Private methods

- (void)setSourceNode:(NodeView *)sourceNode {
    _sourceNode = sourceNode;
    
    if (sourceNode) {
        self.linking = YES;
        self.scrollEnabled = NO;
    } else {
        self.linking = NO;
        self.scrollEnabled = YES;
    }
    [self setNeedsDisplay];
}

@end
