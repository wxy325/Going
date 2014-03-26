//
//  WXYModuleListViewController.m
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYModuleListViewController.h"


#import "WXYNetworkEngine.h"
#import "UIViewController+ShowHud.h"
#import "MBProgressHUD.h"

#import "WXYModuleCommentListViewController.h"

@interface WXYModuleTopicListViewCellState : NSObject

@property (assign, nonatomic) WXYModuleTopicCellType subtype;

@end

@implementation WXYModuleTopicListViewCellState

- (id)init
{
    self = [super init];
    if (self)
    {
        self.subtype = WXYModuleTopicCellTypeNormal;
    }
    return self;
}

@end


@interface WXYModuleListViewController ()

@property (strong, nonatomic) NSMutableArray* stateArray;
@property (strong, nonatomic) NSMutableArray* datasourceArray;
@property (assign, nonatomic) BOOL fShowNewCell;
@property (strong, nonatomic) WXYModuleNewTopicCell* newTopicCell;
@property (strong, nonatomic) UIView* divider;
@property (strong, nonatomic) UIView* zeroView;

@property (assign, nonatomic) ModuleType moduleType;
@end

@implementation WXYModuleListViewController
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

#pragma mark - Init
- (id)initWithModuleType:(ModuleType)type
{
    self = [super initWithNibName:@"WXYModuleListViewController" bundle:nil];
    if (self)
    {
        self.datasourceArray = [@[] mutableCopy];
        self.stateArray = [@[] mutableCopy];
        
        self.fShowNewCell = NO;
        
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
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE getModuleTopicList:self.moduleType
                                   page:@1
                              onSucceed:^(NSArray *resultArray)
     {
         [hud hide:YES];
         [self.datasourceArray removeAllObjects];
         [self.datasourceArray addObjectsFromArray:resultArray];
         
         [self.stateArray removeAllObjects];
         for (TopicEntity* e in self.datasourceArray)
         {
             [self.stateArray addObject:[[WXYModuleTopicListViewCellState alloc] init]];
         }
         
         [self.tableView reloadData];
     }
                                onError:^(NSError *error)
     {
         [hud hide:YES];
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
        WXYModuleTopicCell* cell = (WXYModuleTopicCell*)[tableView dequeueReusableCellWithIdentifier:ModuleTopicCellIdentifier];
        if (!cell)
        {
            cell = [WXYModuleTopicCell makeCellWithType:self.moduleType];
            cell.delegate = self;
        }
        TopicEntity* e = self.datasourceArray[indexPath.row];
        WXYModuleTopicListViewCellState* state = self.stateArray[indexPath.row];
        [cell bindWithTopicEntity:e type:state.subtype];
        return cell;
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
        return self.datasourceArray.count;
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
        TopicEntity* e = self.datasourceArray[indexPath.row];
        WXYModuleTopicListViewCellState* state = self.stateArray[indexPath.row];
        return [WXYModuleTopicCell getCellHeightWithTopicEntity:e type:state.subtype];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {

    }
    else
    {
        WXYModuleTopicListViewCellState* state = self.stateArray[indexPath.row];
        if (state.subtype == WXYModuleTopicCellTypeNormal)
        {
            state.subtype = WXYModuleTopicCellTypeDetail;
        }
        else
        {
            state.subtype = WXYModuleTopicCellTypeNormal;
        }

        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    [self.newTopicCell.titleTextField resignFirstResponder];
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
         [self.datasourceArray insertObject:t atIndex:0];
         [self.stateArray insertObject:[[WXYModuleTopicListViewCellState alloc] init] atIndex:0];
         [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    TopicEntity* t = self.datasourceArray[indexPath.row];
    WXYModuleCommentListViewController* vc = [[WXYModuleCommentListViewController alloc] initWithTopicEntity:t type:self.moduleType];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)zanButtonPressedCell:(UITableViewCell*)cell
{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    TopicEntity* t = self.datasourceArray[indexPath.row];
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE moduleTopicZan:t.topicId onSucceed:^{
        [hud hide:YES];
        t.gooded = [NSNumber numberWithBool:YES];
        NSNumber* g = t.good;
        t.good = @(g.longLongValue + 1);
        WXYModuleTopicCell* c = (WXYModuleTopicCell*)cell;
        [c bindWithTopicEntity:t type:c.type];
        
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
