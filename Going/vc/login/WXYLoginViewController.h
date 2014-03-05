//
//  WXYLoginViewController.h
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXYLoginViewController : UIViewController
- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)sighUpButtonPressed:(id)sender;
- (IBAction)forgetButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *usernameBackground;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIImageView *passwordBackground;

@end
