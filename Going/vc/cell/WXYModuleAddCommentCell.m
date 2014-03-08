//
//  WXYModuleAddCommentCell.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleAddCommentCell.h"
#import "WXYDataModel.h"

@interface WXYModuleAddCommentCell ()

@property (assign, nonatomic) ModuleType moduleType;

@end

@implementation WXYModuleAddCommentCell

#pragma mark - Static Method
+ (WXYModuleAddCommentCell*)makeCellWithType:(ModuleType)type
{
    UINib* nib = [UINib nibWithNibName:@"WXYModuleAddCommentCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    WXYModuleAddCommentCell* cell = nil;
    if (array.count)
    {
        cell = array[0];
        cell.moduleType = type;
        cell.commentBackground.image = [UIImage imageNamed:[SHARE_DM getResourceName:@"comment_background" withModuleType:cell.moduleType]];
    }
    return cell;
}


#pragma mark -
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBAction

- (IBAction)editEnd:(UITextField*)sender
{
    if ([self.delegate respondsToSelector:@selector(textField:didAddComment:)])
    {
        [self.delegate textField:sender didAddComment:sender.text];
    }
}

@end
