//
//  WXYModuleAddCommentCell.h
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WXYModuleAddCommentCellHeight 51.f

@protocol WXYModuleAddCommentCellDelegate <NSObject>

- (void)textField:(UITextField*)textField didAddComment:(NSString*)comment;

@end

@interface WXYModuleAddCommentCell : UITableViewCell

+ (WXYModuleAddCommentCell*)makeCell;


@property (strong, nonatomic) IBOutlet UITextField* commentTextField;
@property (weak, nonatomic) NSObject<WXYModuleAddCommentCellDelegate>* delegate;

- (IBAction)editEnd:(UITextField*)sender;
@end
