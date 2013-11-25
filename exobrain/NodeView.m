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

- (IBAction)onLongPress:(id)sender;

@end

@implementation NodeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
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

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)gesterRecognizer {
    if (gesterRecognizer.state == UIGestureRecognizerStateBegan) {
        // Note to Colin: Long press has been engaged!
//        [UIView animateWithDuration:0.250 animations:^{
//            // Things that will automatically animate!
              //   frame
              //   backgroundColor
//        }];
        
        CGPoint touchCenter = [gesterRecognizer locationInView:self];
        self.touchOffset = CGSizeMake(touchCenter.x - self.frame.size.width / 2, touchCenter.y - self.frame.size.height / 2);
    } else if (gesterRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint touchCenter = [gesterRecognizer locationInView:self.superview];
        self.center = CGPointMake(touchCenter.x - self.touchOffset.width, touchCenter.y - self.touchOffset.height);
        self.node.center = self.center;
        [self.superview setNeedsDisplay];
    } else if (gesterRecognizer.state == UIGestureRecognizerStateEnded){
        // Note to Colin: Long press has been engaged!
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
