//
//  MyViewController.m
//  LianKa
//
//  Created by tenghaojun on 15/11/27.
//  Copyright © 2015年 tenghaojun. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (strong,nonatomic) NSArray *myTableArray;
@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myTableArray = @[@"我的预约",@"我的交易",@"我的钱包",@"积分商城"];
    self.myTableView.dataSource = self;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"mytablecell";
    UITableViewCell *myTableViewCell = [self.myTableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    myTableViewCell.textLabel.text = self.myTableArray[indexPath.row];
    return myTableViewCell;
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
