//
//  NodeView.m
//  exobrain
//
//  Created by Timothy Lee on 11/3/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "NodeView.h"

@interface NodeView ()

@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (assign, nonatomic) CGSize touchOffset;
@property (nonatomic, assign) BOOL isScaled;

- (IBAction)onLongPress:(id)sender;

@end

@implementation NodeView

float scaleFactor = 1.1f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor = [UIColor colorWithRed:23/255.0 green:135/255.0 blue:251/255.0 alpha:1.0];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [[UIColor blackColor] CGColor];
        layer.cornerRadius = 3.0f;
        
        [self.layer addSublayer:layer];
        self.layer.cornerRadius = 3.0f;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Private methods

- (void)setup {
    self.userInteractionEnabled = YES;
    
    [[NSBundle mainBundle] loadNibNamed:@"NodeView" owner:self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
}

//- (IBAction)onTap:(UIGestureRecognizer *)gestureRecognizer {
//    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"Tap began");
//    }
//}

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //Long Press Engaged]
        [UIView animateWithDuration:0.75 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], scaleFactor, scaleFactor);
            self.layer.shadowOpacity = 0.55f;
            self.layer.shadowRadius = 15.0f;
        }completion:^(BOOL finished){
            //Animation Finished
        }];
        
        CGPoint touchCenter = [gestureRecognizer locationInView:self];
        self.touchOffset = CGSizeMake(touchCenter.x - self.frame.size.width / 2, touchCenter.y - self.frame.size.height / 2);
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint touchCenter = [gestureRecognizer locationInView:self.superview];
        self.center = CGPointMake(touchCenter.x - self.touchOffset.width, touchCenter.y - self.touchOffset.height);
        self.node.center = self.center;
        [self.superview setNeedsDisplay];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        NSLog(@"User lifted their finger.  Colin, size it back to what it was!");
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], 1.0 / scaleFactor, 1.0 / scaleFactor);
            self.layer.shadowOpacity = 0.0;
            self.layer.shadowRadius = 0.0;
        }completion:^(BOOL finished){
            //Animation Finished
        }];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"Something cancelled the gesture.  Colin, if necessary, size it back to what it was!");
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowRadius = 0.0;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return self;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end
