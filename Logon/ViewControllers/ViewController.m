//
//  ViewController.m
//  Logon
//
//  Created by 王垒 on 2017/2/5.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "ViewController.h"
#import "LogonViewController.h"
@interface ViewController ()

@end

@implementation ViewController

+ (void)initialize {
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor redColor]];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName:[UIColor whiteColor],
                                            NSFontAttributeName:[UIFont systemFontOfSize:17.f],
                                            }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(showLogonVC)];
    self.navigationItem.title = @"登录";
}

- (void)showLogonVC{
    
    LogonViewController *vc = [[LogonViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
