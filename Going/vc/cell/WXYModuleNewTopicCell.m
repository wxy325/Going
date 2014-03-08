//
//  WXYModuleNewTopicCell.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleNewTopicCell.h"
#import "WXYDataModel.h"


@interface WXYModuleNewTopicCell ()

@property (assign, nonatomic) ModuleType moduleType;
@end

@implementation WXYModuleNewTopicCell

#pragma mark - Static Method
+ (WXYModuleNewTopicCell*)makeCellWithType:(ModuleType)type
{
    UINib* nib = [UINib nibWithNibName:@"WXYModuleNewTopicCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    WXYModuleNewTopicCell* cell = nil;
    if (array.count)
    {
        cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moduleType = type;
        
        cell.buttonBackground.image = [UIImage imageNamed:[SHARE_DM getResourceName:@"new_cell" withModuleType:cell.moduleType]];
        cell.titleBackground.image = [UIImage imageNamed:[SHARE_DM getResourceName:@"title_background" withModuleType:cell.moduleType]];
        cell.contentBackground.image = [UIImage imageNamed:[SHARE_DM getResourceName:@"comment_background" withModuleType:cell.moduleType]];
        
    }
    return cell;
}

#pragma mark -
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)titleEditEnd:(UITextField*)sender
{
    [self.contentTextField becomeFirstResponder];
}
- (IBAction)editEnd:(UITextField*)sender
{
    if ([self.delegate respondsToSelector:@selector(textField:didSendContent:title:)])
    {
        [self.delegate textField:sender didSendContent:sender.text title:self.titleTextField.text];
    }
}
@end
