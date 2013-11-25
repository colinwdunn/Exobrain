//
//  CanvasView.m
//  exobrain
//
//  Created by Timothy Lee on 11/15/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "CanvasView.h"
#import "NodeView.h"
#import <QuartzCore/QuartzCore.h>

@interface CanvasView ()

@property (nonatomic, assign) BOOL linking;
@property (nonatomic, strong) NodeView *sourceNode;
@property (nonatomic, assign) CGPoint currentTouchPosition;

@end

@implementation CanvasView

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
    if (self.linking) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, self.sourceNode.center.x, self.sourceNode.center.y);
        CGContextAddLineToPoint(context, self.currentTouchPosition.x, self.currentTouchPosition.y);
        [[UIColor blueColor] set];
        CGContextStrokePath(context);
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
