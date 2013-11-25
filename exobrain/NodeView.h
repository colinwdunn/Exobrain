//
//  NodeView.h
//  exobrain
//
//  Created by Timothy Lee on 11/3/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@protocol NodeViewDelegate;

@interface NodeView : UIView

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) Node *node;
@property (nonatomic, weak) id<NodeViewDelegate> delegate;

@end

@protocol NodeViewDelegate <NSObject>

- (void)nodeView:(NodeView *)nodeView didDragToPoint:(CGPoint)point;
- (void)nodeView:(NodeView *)nodeView didFinishDraggingToPoint:(CGPoint)point;

@end
