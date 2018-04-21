//
//  ViewController.m
//  MultiDownload
//
//  Created by ZD on 2018/4/21.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ViewController.h"
#import "ZDTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick:(id)sender {
    ZDTableViewController *tableVC = [[ZDTableViewController alloc] init];
    [self.navigationController pushViewController:tableVC animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
