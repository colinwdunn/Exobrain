//
//  NodeView.h
//  exobrain
//
//  Created by Timothy Lee on 11/3/13.
//  Copyright (c) 2013 colindunn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Node.h"

@interface NodeView : UIView

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) Node *node;

@end
