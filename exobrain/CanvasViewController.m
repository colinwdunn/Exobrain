//
//  CanvasViewController.m
//  exobrain
//
//  Created by Timothy Lee on 11/3/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import "CanvasViewController.h"
#import "NodeView.h"

@interface CanvasViewController ()

@property (nonatomic, strong) NSMutableArray *nodeViews;

- (IBAction)onTap:(id)sender;

@end

@implementation CanvasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.nodeViews = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NodeView *root = [[NodeView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    root.center = self.view.center;
    [self.nodeViews addObject:root];
    [self.view addSubview:root];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    
}

@end
