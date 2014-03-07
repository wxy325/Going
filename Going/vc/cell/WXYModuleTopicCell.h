//
//  WXYModuleTopicCell.h
//  Going
//
//  Created by wxy325 on 3/6/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ModuleTopicCellIdentifier @"ModuleTopicCellIdentifier"

@class TopicEntity;

typedef NS_ENUM(NSInteger, WXYModuleTopicCellType)
{
    WXYModuleTopicCellTypeNormal,
    WXYModuleTopicCellTypeDetail
};

@protocol WXYModuleTopicCellDelegate <NSObject>

- (void)commentButtonPressedCell:(UITableViewCell*)cell;
- (void)zanButtonPressedCell:(UITableViewCell*)cell;

@end

@interface WXYModuleTopicCell : UITableViewCell

#pragma mark - View
@property (strong, nonatomic) IBOutlet UIImageView* headPhotoImageView;
@property (strong, nonatomic) IBOutlet UILabel* titleLabel;
@property (strong, nonatomic) IBOutlet UILabel* dateAndNameLabel;
@property (strong, nonatomic) IBOutlet UILabel* zanNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel* commentNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton* commentButton;
@property (strong, nonatomic) IBOutlet UIButton* zanButton;

@property (strong, nonatomic) IBOutlet UITextView* contentTextView;

#pragma mark - IBAction
- (IBAction)commentButtonPressed:(id)sender;
- (IBAction)zanButtonPressed:(id)sender;

#pragma mark - Static Method
+ (WXYModuleTopicCell*)makeCell;
+ (float)getCellHeightWithTopicEntity:(TopicEntity*)t type:(WXYModuleTopicCellType)type;
#pragma mark -
@property (weak, nonatomic) NSObject<WXYModuleTopicCellDelegate>* delegate;
- (void)bindWithTopicEntity:(TopicEntity*)t type:(WXYModuleTopicCellType)type;



@end
