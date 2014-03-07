//
//  WXYModuleNewTopicCell.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleNewTopicCell.h"

@implementation WXYModuleNewTopicCell

#pragma mark - Static Method
+ (WXYModuleNewTopicCell*)makeCell
{
    UINib* nib = [UINib nibWithNibName:@"WXYModuleNewTopicCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    WXYModuleNewTopicCell* cell = nil;
    if (array.count)
    {
        cell = array[0];
    }
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editEnd:(UITextField*)sender
{
    if ([self.delegate respondsToSelector:@selector(textField:didSendContent:)])
    {
        [self.delegate textField:sender didSendContent:sender.text];
    }
}
@end
