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

@property (nonatomic, strong) NodeView *sourceNode;
@property (nonatomic, assign) CGPoint currentTouchPosition;

@end

@implementation CanvasView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.alwaysBounceHorizontal = YES;
//        self.alwaysBounceVertical = YES;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, self.sourceNode.center.x, self.sourceNode.center.y);
    CGContextAddLineToPoint(context, self.currentTouchPosition.x, self.currentTouchPosition.y);
    [[UIColor blueColor] set];
    CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    
    
    UIView *touchedView = [self hitTest:location withEvent:event];
    
    
    if ([touchedView isKindOfClass:[NodeView class]]) {
        NSLog(@"I am inside a node");
        self.sourceNode = (NodeView *)touchedView;
    } else if ([touchedView isKindOfClass:[CanvasView class]]) {
        NSLog(@"I am inside the canvas");
    } else {
        NSLog(@"I am something else: %@", NSStringFromClass([touchedView class]));
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
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches ended");
}

@end
