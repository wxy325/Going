//
//  WXYModuleTopicCell.m
//  Going
//
//  Created by wxy325 on 3/6/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#define CELL_HEIGHT_NORMAL 104.f
#define CELL_BUTTON_DELTA 26.f

#import "WXYModuleTopicCell.h"
#import "TopicEntity.h"
#import "WXYDataModel.h"

@interface WXYModuleTopicCell ()
@property (assign, nonatomic) ModuleType moduleType;

- (void)updateButtonHigh:(UIView*)v byCellHeight:(float)height;

@end

@implementation WXYModuleTopicCell


#pragma mark - Static Method
+ (WXYModuleTopicCell*)makeCellWithType:(ModuleType)type;
{
    UINib* nib = [UINib nibWithNibName:@"WXYModuleTopicCell" bundle:[NSBundle mainBundle]];
    NSArray* array = [nib instantiateWithOwner:self options:nil];
    WXYModuleTopicCell* cell = nil;
    if (array.count)
    {
        cell = array[0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.moduleType = type;
        
        [cell.commentButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"comment_normal" withModuleType:cell.moduleType]] forState:UIControlStateNormal];
        [cell.commentButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"comment_hover" withModuleType:cell.moduleType]] forState:UIControlStateHighlighted];
        [cell.commentButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"comment_hover" withModuleType:cell.moduleType]] forState:UIControlStateSelected];
        
        
        [cell.zanButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"zan" withModuleType:cell.moduleType]] forState:UIControlStateNormal];
        [cell.zanButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"zan_hover" withModuleType:cell.moduleType]] forState:UIControlStateHighlighted];
        [cell.zanButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"zan_hover" withModuleType:cell.moduleType]] forState:UIControlStateSelected];
        
        cell.dateAndNameLabel.textColor = SHARE_DM.moduleTypeColor[cell.moduleType];
        
        cell.commentNumberLabel.textColor = SHARE_DM.moduleTypeColor[cell.moduleType];
        cell.zanNumberLabel.textColor = SHARE_DM.moduleTypeColor[cell.moduleType];
    }
    return cell;
}

+ (float)getCellHeightWithTopicEntity:(TopicEntity*)t type:(WXYModuleTopicCellType)type
{
    if (type == WXYModuleTopicCellTypeNormal)
    {
        return CELL_HEIGHT_NORMAL;
    }
    else
    {
        float height = CELL_HEIGHT_NORMAL;
        CGSize size = CGSizeMake(297, INFINITY);
        CGSize cSize = [t.content sizeWithFont:[UIFont systemFontOfSize:14.f] constrainedToSize:size];
        height += cSize.height;
        return height;
    }
}

#pragma mark -

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - IBAction
- (IBAction)commentButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(commentButtonPressedCell:)])
    {
        [self.delegate commentButtonPressedCell:self];
    }
}
- (IBAction)zanButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(zanButtonPressedCell:)])
    {
        [self.delegate zanButtonPressedCell:self];
    }
}

#pragma mark -
- (void)bindWithTopicEntity:(TopicEntity*)t type:(WXYModuleTopicCellType)type
{
    self.type = type;
    if (self.type == WXYModuleTopicCellTypeNormal)
    {
        self.contentTextView.hidden = YES;
    }
    else if (self.type == WXYModuleTopicCellTypeDetail)
    {
        self.contentTextView.hidden = NO;
    }
    
    self.titleLabel.text = t.title;
    self.contentTextView.text = t.content;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];

    self.dateAndNameLabel.text = [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:t.time], t.userName];
    
    
    float height = [WXYModuleTopicCell getCellHeightWithTopicEntity:t type:type];

    [self updateButtonHigh:self.zanButton byCellHeight:height];
    [self updateButtonHigh:self.zanNumberLabel byCellHeight:height];
    [self updateButtonHigh:self.commentButton byCellHeight:height];
    [self updateButtonHigh:self.commentNumberLabel byCellHeight:height];
    
    
    CGRect rect = self.contentTextView.frame;
    rect.size.height = height;
    self.contentTextView.frame = rect;
    
    self.zanNumberLabel.text = t.good.stringValue;
    self.commentNumberLabel.text = t.comment.stringValue;
    self.zanButton.selected = t.gooded.boolValue;
    
}

- (void)updateButtonHigh:(UIView*)v byCellHeight:(float)height
{
    CGRect r = v.frame;
    r.origin.y = height - CELL_BUTTON_DELTA;
    v.frame = r;
}


@end
