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
- (void)sizeToFit:(NSString *)text;;

@end

@implementation NodeView

float scaleFactor = 1.1f;
float cornerRadius = 3.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        self.backgroundColor = [UIColor colorWithRed:23/255.0 green:135/255.0 blue:251/255.0 alpha:1.0];
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [[UIColor blackColor] CGColor];
        layer.cornerRadius = cornerRadius;
        
        [self.layer addSublayer:layer];
        self.layer.cornerRadius = cornerRadius;
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

#pragma mark - Public methods

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
    
    [self sizeToFit];
}

#pragma mark - UITextField delegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self sizeToFit:text];
    return YES;
}

#pragma mark - Private methods

- (void)sizeToFit {
    [self sizeToFit:self.textField.text];
}

- (void)sizeToFit:(NSString *)text {
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}];
    CGPoint center = self.center;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width + 22, self.frame.size.height);
    self.center = center;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    
    [[NSBundle mainBundle] loadNibNamed:@"NodeView" owner:self options:nil];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
    
    self.textField.delegate = self;
}

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //Long Press Engaged]
        [UIView animateWithDuration:0.75 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], scaleFactor, scaleFactor);
//            self.layer.shadowColor = self.backgroundColor.CGColor;
            self.layer.shadowOffset = CGSizeMake(2, 2);
            self.layer.shadowOpacity = 0.5f;
            self.layer.shadowRadius = 5.0f;
        }completion:^(BOOL finished){
            //Animation Finished
        }];
        
        [[self superview] bringSubviewToFront:self];
        CGPoint touchCenter = [gestureRecognizer locationInView:self];
        self.touchOffset = CGSizeMake(touchCenter.x - self.frame.size.width / 2, touchCenter.y - self.frame.size.height / 2);
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint touchCenter = [gestureRecognizer locationInView:self.superview];
        self.center = CGPointMake(touchCenter.x - self.touchOffset.width, touchCenter.y - self.touchOffset.height);
        self.node.center = self.center;
        [self.superview setNeedsDisplay];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        NSLog(@"Long press ended");
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.25 initialSpringVelocity:5.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [gestureRecognizer view].transform = CGAffineTransformScale([[gestureRecognizer view] transform], 1.0 / scaleFactor, 1.0 / scaleFactor);
            self.layer.shadowOpacity = 0.0;
        }completion:^(BOOL finished){
            //Animation Finished
        }];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"Long press cancelled");
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
