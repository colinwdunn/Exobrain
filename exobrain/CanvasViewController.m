//
//  CanvasViewController.m
//  exobrain
//
//  Created by Timothy Lee on 11/3/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "CanvasViewController.h"
#import "CanvasView.h"
#import "NodeView.h"
#import "Node.h"

@interface CanvasViewController ()

@property (nonatomic, strong) NSMutableArray *nodeViews;
@property (nonatomic, strong) NSMutableArray *nodes;
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

- (IBAction)onTap:(id)sender;
- (void)createRootNode;
- (void)createNodeWithCenter:(CGPoint)center;
- (void)onPanGesture:(UIPanGestureRecognizer *)panGestureRecognizer;

@end

@implementation CanvasViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.nodeViews = [NSMutableArray array];
        self.nodes = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    
//    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    CanvasView *canvasView = (CanvasView *)self.view;
//    [canvasView addGestureRecognizer:self.panGestureRecognizer];
    
    NSLog(@"frame: %@", NSStringFromCGRect(canvasView.frame));
//    canvasView.contentSize = CGSizeMake(canvasView.frame.size.height * 3, canvasView.frame.size.width * 3);
    
    [self createRootNode];
}

#pragma mark - Private methods

- (IBAction)onLongPress:(UILongPressGestureRecognizer *)gesterRecognizer {

}

- (void)onPanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //
        
//        CGPoint touchCenter = [panGestureRecognizer locationInView:self];
//        self.touchOffset = CGSizeMake(touchCenter.x - self.frame.size.width / 2, touchCenter.y - self.frame.size.height / 2);
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        CGPoint touchCenter = [panGestureRecognizer locationInView:self.superview];
//        self.center = CGPointMake(touchCenter.x - self.touchOffset.width, touchCenter.y - self.touchOffset.height);
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded){
        //Do whatever You want on end of gesture
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches moves");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touches ended");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    UITapGestureRecognizer *gestureRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint touchCenter = [gestureRecognizer locationInView:self.view];
    
//    [self createNodeWithCenter:touchCenter];
}

- (void)createRootNode {
    [self createNodeWithCenter:self.view.center];
}

- (void)createNodeWithCenter:(CGPoint)center {
    Node *node = [[Node alloc] init];
    node.center = center;
    [self.nodes addObject:node];
    
    NodeView *view = [[NodeView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    view.center = center;
    [self.nodeViews addObject:view];
    [self.view addSubview:view];
}

@end
