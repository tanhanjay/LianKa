//
//  RootViewTabBarController.m
//  HereHairAPP
//
//  Created by tenghaojun on 15/10/28.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "RootViewTabBarController.h"

@interface RootViewTabBarController ()

@end

@implementation RootViewTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bgcolor"];
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
