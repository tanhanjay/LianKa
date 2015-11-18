//
//  FirstPageViewController.m
//  HereHairAPP
//
//  Created by tenghaojun on 15/10/28.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "FirstPageViewController.h"
#import "SDCycleScrollView.h"
@interface FirstPageViewController ()


@end

@implementation FirstPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:133.0/255 green:198.0/255.0 blue:166.0/255.0 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil]];

    UIView *locationbuttonview = [[[NSBundle mainBundle]loadNibNamed:@"locationbuttonview" owner:nil options:nil]lastObject];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:locationbuttonview];
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    NSMutableArray *imagesArray = [NSMutableArray array];
    [imagesArray addObject:[UIImage imageNamed:@"今日潮流合并1"]];
    [imagesArray addObject:[UIImage imageNamed:@"今日潮流合并2"]];
    [imagesArray addObject:[UIImage imageNamed:@"今日潮流合并3"]];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 44, [UIScreen mainScreen].bounds.size.width, 260) imagesGroup:imagesArray];
    cycleScrollView.autoScrollTimeInterval = 3;
    [self.view addSubview:cycleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
