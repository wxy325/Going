//
//  WXYRootViewController.m
//  Going
//
//  Created by wxy325 on 3/4/14.
//  Copyright (c) 2014 wxy. All rights reserved.
//

#import "WXYRootViewController.h"

@interface WXYRootViewController ()

@property (assign, nonatomic) BOOL fFirst;

@end

@implementation WXYRootViewController

#pragma mark - Init Method
- (id)init
{
    self = [super initWithNibName:@"WXYRootViewController" bundle:nil];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fFirst = YES;
    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_background"] forBarMetrics:UIBarMetricsDefault];

}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (self.fFirst)
    {
        self.fFirst = NO;
        self.contentScrollView.contentSize = self.contentScrollView.frame.size;
        self.contentScrollView.frame = self.contentView.bounds;
        [self.contentView addSubview:self.contentScrollView];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

@end
