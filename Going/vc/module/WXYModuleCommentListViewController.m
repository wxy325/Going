//
//  WXYModuleCommentListViewController.m
//  Going
//
//  Created by wxy325 on 3/7/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleCommentListViewController.h"
#import "WXYNetworkEngine.h"
#import "MBProgressHUD.h"
#import "UIViewController+ShowHud.h"


@interface WXYModuleCommentListViewController ()
@property (strong, nonatomic) TopicEntity* topicEntity;
@property (strong, nonatomic) NSMutableArray* stateArray;
@property (strong, nonatomic) NSMutableArray* datasourceArray;
@property (assign, nonatomic) BOOL fShowNewCell;
@property (strong, nonatomic) WXYModuleNewTopicCell* newTopicCell;
@property (strong, nonatomic) WXYModuleAddCommentCell* addCommentCell;
@property (strong, nonatomic) UIView* divider;
@property (strong, nonatomic) UIView* zeroView;
@property (assign, nonatomic) ModuleType moduleType;
@end

@implementation WXYModuleCommentListViewController

- (UIView*)zeroView
{
    if (!_zeroView)
    {
        _zeroView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _zeroView;
}
- (UIView*)divider
{
    if (!_divider)
    {
        _divider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 6)];
        _divider.backgroundColor = SHARE_DM.moduleTypeColor[self.moduleType];
    }
    return _divider;
}
- (WXYModuleNewTopicCell*)newTopicCell
{
    if (!_newTopicCell)
    {
        _newTopicCell = [WXYModuleNewTopicCell makeCellWithType:self.moduleType];
        _newTopicCell.delegate = self;
    }
    return _newTopicCell;
}
- (WXYModuleAddCommentCell*)addCommentCell
{
    if (!_addCommentCell)
    {
        _addCommentCell = [WXYModuleAddCommentCell makeCellWithType:self.moduleType];
        _addCommentCell.delegate = self;
    }
    return _addCommentCell;
}

#pragma mark - Init
- (id)initWithTopicEntity:(TopicEntity*)t type:(ModuleType)type;
{
    self = [super initWithNibName:@"WXYModuleCommentListViewController" bundle:nil];
    if (self)
    {
        self.topicEntity = t;
        self.datasourceArray = [@[] mutableCopy];
        self.moduleType = type;
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.iconButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"icon" withModuleType:self.moduleType]] forState:UIControlStateNormal];
    [self.addButton setImage:[UIImage imageNamed:[SHARE_DM getResourceName:@"add" withModuleType:self.moduleType]] forState:UIControlStateNormal];
    self.titleLabel.text = SHARE_DM.moduleTypeTitle[self.moduleType];
    
//    self.iconButton setImage:[] forState:<#(UIControlState)#>
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SHARE_NW_ENGINE moduleTopicGetCommentList:self.topicEntity.topicId
                                          page:@1
                                     onSucceed:^(NSArray *resultArray)
     {
         [self.datasourceArray removeAllObjects];
         [self.datasourceArray addObjectsFromArray:resultArray];
         [self.tableView reloadData];
     }
                                       onError:^(NSError *error)
     {
         [self showErrorHudWithText:@"系统错误"];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (self.fShowNewCell)
        {
            return self.newTopicCell;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            WXYModuleTopicCell* cell = (WXYModuleTopicCell*)[tableView dequeueReusableCellWithIdentifier:ModuleTopicCellIdentifier];
            if (!cell)
            {
                cell = [WXYModuleTopicCell makeCellWithType:self.moduleType];
                cell.delegate = self;
            }
            [cell bindWithTopicEntity:self.topicEntity type:WXYModuleTopicCellTypeDetail];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            return self.addCommentCell;
        }
        else
        {
            TopicCommentEntity* c = self.datasourceArray[indexPath.row - 2];
            WXYModuleCommentCell* cell = (WXYModuleCommentCell*)[tableView dequeueReusableCellWithIdentifier:WXYModuleCommentCellIdentifier];
            if (!cell)
            {
                cell = [WXYModuleCommentCell makeCellWithType:self.moduleType];
            }
            [cell bindWithCommentEntity:c];
            return cell;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if (self.fShowNewCell)
        {
            return 1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        return (self.datasourceArray.count + 2);
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


#pragma mark - UITableView Delegate
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return WXYModuleNewTopicCellHeight;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return [WXYModuleTopicCell getCellHeightWithTopicEntity:self.topicEntity type:WXYModuleTopicCellTypeDetail];
        }
        else if (indexPath.row == 1)
        {
            return WXYModuleAddCommentCellHeight;
        }
        else
        {
            TopicCommentEntity* c = self.datasourceArray[indexPath.row - 2];
            return [WXYModuleCommentCell getCellHeightWithCommentEntity:c];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        
        return self.zeroView;
    }
    else
    {
        //        return nil;
        return self.divider;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        
        return 0;
    }
    else
    {
        //        return nil;
        return self.divider.frame.size.height;
    }
}
#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.newTopicCell.contentTextField resignFirstResponder];
}

#pragma mark - WXYModuleNewTopicCellDelegate

-(void)textField:(UITextField*)textField didSendContent:(NSString*)content title:(NSString *)title
{

    NSString* con = content;
    
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    
    [SHARE_NW_ENGINE moduleNewTopicTitle:title
                                 Content:con
                                    type:1
                               onSucceed:^(TopicEntity *t)
     {
         [hud hide:YES];
         textField.text = @"";
         [self showSuccessHudWithText:@"发送成功"];
     }
                                 onError:^(NSError *error)
     {
         [hud hide:YES];
         [self showErrorHudWithText:@"发送失败"];
     }];
}

#pragma mark - WXYModuleTopicCellDelegate
- (void)commentButtonPressedCell:(UITableViewCell*)cell
{
    
}
- (void)zanButtonPressedCell:(UITableViewCell*)cell
{
    
}
#pragma mark - WXYModuleAddCommentCell Delegate
- (void)textField:(UITextField*)textField didAddComment:(NSString*)comment
{
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE moduleTopicAddComment:self.topicEntity.topicId content:comment onSucceed:^(TopicCommentEntity *c) {
        [hud hide:YES];
        textField.text = @"";
        [self.datasourceArray insertObject:c atIndex:0];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
    } onError:^(NSError *error)
    {
        [hud hide:YES];
        [self showErrorHudWithText:@"系统错误"];
    }];
}
#pragma mark - IBAction
- (IBAction)backButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)newButtonPressed:(id)sender
{
    if (self.fShowNewCell)
    {
        self.fShowNewCell = NO;
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else
    {
        self.fShowNewCell = YES;
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 10, 10) animated:YES];
    }
    
}

- (IBAction)settingButtonPressed:(id)sender
{
    
}

@end
