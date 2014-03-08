//
//  WXYModuleCommentCell.h
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleType.h"

#define WXYModuleCommentCellIdentifier @"WXYModuleCommentCellIdentifier"

@class TopicCommentEntity;


@interface WXYModuleCommentCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView* headPhotoImageView;
@property (strong, nonatomic) IBOutlet UITextView* contentTextView;
@property (strong, nonatomic) IBOutlet UILabel* dateLabel;

- (void)bindWithCommentEntity:(TopicCommentEntity*)c;

+ (WXYModuleCommentCell*)makeCellWithType:(ModuleType)type;

+ (float)getCellHeightWithCommentEntity:(TopicCommentEntity*)c;

@end
