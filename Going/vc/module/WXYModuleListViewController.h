//
//  WXYModuleListViewController.h
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYModuleTopicCell.h"
#import "WXYModuleNewTopicCell.h"
#import "ModuleType.h"

@interface WXYModuleListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WXYModuleNewTopicCellDelegate, WXYModuleTopicCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)newButtonPressed:(id)sender;
- (IBAction)settingButtonPressed:(id)sender;

- (id)initWithModuleType:(ModuleType)type;

@end
