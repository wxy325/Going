//
//  WXYModuleCommentListViewController.h
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXYModuleTopicCell.h"
#import "WXYModuleNewTopicCell.h"
#import "WXYModuleAddCommentCell.h"
#import "WXYModuleCommentCell.h"
@class TopicEntity;

@interface WXYModuleCommentListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, WXYModuleNewTopicCellDelegate, WXYModuleTopicCellDelegate, WXYModuleAddCommentCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


- (IBAction)backButtonPressed:(id)sender;
- (IBAction)newButtonPressed:(id)sender;
- (IBAction)settingButtonPressed:(id)sender;

- (id)initWithTopicEntity:(TopicEntity*)t type:(ModuleType)type;

@end
