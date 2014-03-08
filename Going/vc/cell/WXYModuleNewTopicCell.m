//
//  WXYModuleNewTopicCell.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleNewTopicCell.h"

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
