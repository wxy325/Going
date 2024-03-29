//
//  WXYModuleNewTopicCell.h
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModuleType.h"
#define WXYModuleNewTopicCellIdentifier @"WXYModuleNewTopicCellIdentifier"
#define WXYModuleNewTopicCellHeight 175.f

@protocol WXYModuleNewTopicCellDelegate <NSObject>

-(void)textField:(UITextField*)textField didSendContent:(NSString*)content title:(NSString*)title;

@end

@interface WXYModuleNewTopicCell : UITableViewCell

#pragma mark - Static Method
+ (WXYModuleNewTopicCell*)makeCellWithType:(ModuleType)type;

@property (weak, nonatomic) IBOutlet UIImageView *buttonBackground;
@property (weak, nonatomic) IBOutlet UIImageView *titleBackground;
@property (weak, nonatomic) IBOutlet UIImageView *contentBackground;


@property (weak, nonatomic) IBOutlet UITextField *contentTextField;
- (IBAction)editEnd:(UITextField*)sender;

@property (strong, nonatomic) IBOutlet UITextField* titleTextField;
- (IBAction)titleEditEnd:(UITextField*)sender;

@property (weak, nonatomic) NSObject<WXYModuleNewTopicCellDelegate>* delegate;
@end
