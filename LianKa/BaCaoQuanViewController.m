//
//  BaCaoQuanViewController.m
//  LianKa
//
//  Created by tenghaojun on 15/11/27.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "BaCaoQuanViewController.h"

@interface BaCaoQuanViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *remenScrollView;

@end

@implementation BaCaoQuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.remenScrollView.contentSize = CGSizeMake(409, 87);
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:133.0/255 green:198.0/255.0 blue:166.0/255.0 alpha:1]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor, nil]];
    
    UIView *locationbuttonview = [[[NSBundle mainBundle]loadNibNamed:@"locationbuttonview" owner:nil options:nil]lastObject];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:locationbuttonview];
    self.navigationItem.leftBarButtonItem =leftBarButtonItem;

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
