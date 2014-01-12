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

- (IBAction)onTap:(id)sender;
- (void)createRootNode;

@end

@implementation CanvasViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

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
    CanvasView *canvasView = (CanvasView *)self.view;
    canvasView.nodes = self.nodes;
    canvasView.canvasViewController = self;
    
    [self createRootNode];
}

#pragma mark - Private methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    UITapGestureRecognizer *gestureRecognizer = (UITapGestureRecognizer *)sender;
    CGPoint touchCenter = [gestureRecognizer locationInView:self.view];
    
    UIView *touchedView = [self.view hitTest:touchCenter withEvent:nil];
    if (![touchedView isKindOfClass:[NodeView class]]) {
        [self createNodeWithCenter:touchCenter];
    }
}

- (void)createRootNode {
    Node *one = [self createNodeWithCenter:self.view.center string:@"One"];
    Node *two = [self createNodeWithCenter:CGPointMake(100, 100) string:@"Two"];
    Node *three = [self createNodeWithCenter:CGPointMake(300, 300) string:@"Three"];
    
    // Add links
    [one linkToNode:three];
    [two linkToNode:three];
}

- (Node *)createNodeWithCenter:(CGPoint)center {
    return [self createNodeWithCenter:center string:@""];
}

- (Node *)createNodeWithCenter:(CGPoint)center string:(NSString *)string {
    Node *node = [[Node alloc] init];
    node.center = center;
    node.text = string;
    [self.nodes addObject:node];
    
    NodeView *view = [[NodeView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    view.node = node;
    view.textField.text = string;
    view.center = center;
    [self.nodeViews addObject:view];
    [self.view addSubview:view];
    
    return node;
}

#pragma mark - NodeView Delegate methods

- (void)nodeView:(NodeView *)nodeView didDragToPoint:(CGPoint)point {
    // If this is near a trash can, display the trash can.  Or hide the trash can
}

- (void)nodeView:(NodeView *)nodeView didFinishDraggingToPoint:(CGPoint)point {
    // Delete the node
    //   - Remove the node model object from self.nodes
    //   - Update all nodes and remove node from linkedNodes, if applicable
    //   - Update canvas view (setNeedsDisplay)
    //   - Remove nodeView from the superview.
}

@end
