//
//  WXYRootViewController.h
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYRootViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;

- (IBAction)moduleButtonPressed:(UIButton *)sender;


@end
