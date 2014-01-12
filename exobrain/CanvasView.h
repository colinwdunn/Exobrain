//
//  CanvasView.h
//  exobrain
//
//  Created by Timothy Lee on 11/15/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasViewController.h"

@interface CanvasView : UIScrollView

@property (nonatomic, strong) NSMutableArray *nodes;
@property (nonatomic, weak) CanvasViewController *canvasViewController;

@end
