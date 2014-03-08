//
//  WXYModuleCommentCell.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleCommentCell.h"
#import "WXYNetworkEngine.h"


@implementation WXYModuleCommentCell

#pragma mark - Static Method
+ (WXYModuleCommentCell*)makeCell
{
    UINib* nib = [UINib nibWithNibName:@"WXYModuleCommentCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    WXYModuleCommentCell* cell = nil;
    if (array.count)
    {
        cell = array[0];
    }
    return cell;
}

+ (float)getCellHeightWithCommentEntity:(TopicCommentEntity*)c
{
    float height = 0;
    
    CGSize size = CGSizeMake(237, INFINITY);
    CGSize cSize = [c.content sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:size];
    height = cSize.height;
    height = height < 49? 49: height;
    height += 57;
    return height;
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
#pragma mark - 
- (void)bindWithCommentEntity:(TopicCommentEntity*)c
{
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@:%@",c.userName,c.content]];
    [str setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, c.userName.length + 1)];
    self.contentTextView.attributedText = str;
    self.dateLabel.text = [c.timeStr stringValue];
    float height = [WXYModuleCommentCell getCellHeightWithCommentEntity:c];
    
    CGRect rect = self.contentTextView.frame;
    rect.size.height = height - 57;
    self.contentTextView.frame = rect;
    
    rect = self.dateLabel.frame;
    rect.origin.y = height - 28;
    self.dateLabel.frame = rect;
    
}
@end
