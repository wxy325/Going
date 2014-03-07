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
        _divider.backgroundColor = [UIColor colorWithRed:102.f/255.f green:204.f/255.f blue:1.f alpha:1.f];
    }
    return _divider;
}
- (WXYModuleNewTopicCell*)newTopicCell
{
    if (!_newTopicCell)
    {
        _newTopicCell = [WXYModuleNewTopicCell makeCell];
        _newTopicCell.delegate = self;
    }
    return _newTopicCell;
}

#pragma mark - Init
- (id)init
{
    self = [super initWithNibName:@"WXYModuleListViewController" bundle:nil];
    if (self)
    {
        self.datasourceArray = [@[] mutableCopy];
        self.stateArray = [@[] mutableCopy];
        
        self.fShowNewCell = NO;
        
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MBProgressHUD* hud = [self showNetworkWaitingHud];
    [SHARE_NW_ENGINE getModuleTopicList:1
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
            cell = [WXYModuleTopicCell makeCell];
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
}

#pragma mark - WXYModuleNewTopicCellDelegate

-(void)textField:(UITextField*)textField didSendContent:(NSString*)content
{
    NSRange range = [content rangeOfString:@"。"];
    if (range.location == NSNotFound)
    {
        range = [content rangeOfString:@"."];
    }
    
    NSString* title = nil;
    NSString* con = nil;
    if (range.location == NSNotFound)
    {
        title = content;
        con = @"";
    }
    else
    {
        title = [content substringToIndex:range.location];
        con = [content substringFromIndex:range.location + 1];
    }
    
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
    
}
- (void)zanButtonPressedCell:(UITableViewCell*)cell
{

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
