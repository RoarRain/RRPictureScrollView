//
//  RRPushViewController.m
//  RRScrollViewImage
//
//  Created by roarrain on 16/1/22.
//  Copyright © 2016年 roarrain. All rights reserved.
//  
//

#import "RRPushViewController.h"

@interface RRPushViewController ()

@end

@implementation RRPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    UILabel *le = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 100)];
    [self.view addSubview:le];
    le.numberOfLines = 0;
    le.text = @"菜鸟 RoarRain \n邮箱 RoarRain@163.com \n博客 blog.52hzy.cn";
    
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
