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
- (void)createNodeWithCenter:(CGPoint)center;
- (Node *)createNodeWithCenter:(CGPoint)center string:(NSString *)string;

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
    CanvasView *canvasView = (CanvasView *)self.view;
    canvasView.nodes = self.nodes;
    
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

- (void)createNodeWithCenter:(CGPoint)center {
    [self createNodeWithCenter:center string:@""];
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

@end
