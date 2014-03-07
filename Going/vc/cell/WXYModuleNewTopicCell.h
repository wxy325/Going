//
//  WXYModuleNewTopicCell.h
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WXYModuleNewTopicCellIdentifier @"WXYModuleNewTopicCellIdentifier"
#define WXYModuleNewTopicCellHeight 125.f

@protocol WXYModuleNewTopicCellDelegate <NSObject>

-(void)textField:(UITextField*)textField didSendContent:(NSString*)content;

@end

@interface WXYModuleNewTopicCell : UITableViewCell

#pragma mark - Static Method
+ (WXYModuleNewTopicCell*)makeCell;
@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
- (IBAction)editEnd:(UITextField*)sender;

@property (weak, nonatomic) NSObject<WXYModuleNewTopicCellDelegate>* delegate;
@end