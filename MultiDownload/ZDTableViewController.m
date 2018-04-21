//
//  ZDTableViewController.m
//  MultiDownload
//
//  Created by ZD on 2018/4/21.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ZDTableViewController.h"
#import "ZDTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

@interface ZDTableViewController ()
@property (nonatomic, strong) NSArray *urlArray;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, assign) NSInteger count;
@end

@implementation ZDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZDTableViewCell" bundle:nil] forCellReuseIdentifier:@"ZDTableViewCell"];
    self.tableView.rowHeight = 120;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadHeader)];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFooter)];
    
    _count = 30;
}

- (void)loadHeader{
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.modelArray removeAllObjects];
        [self addModel:30];
        [self.tableView reloadData];
    });
}



- (void)loadFooter{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self addModel:20];
        [self.tableView reloadData];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZDTableViewCell *zdCell = [tableView dequeueReusableCellWithIdentifier:@"ZDTableViewCell" forIndexPath:indexPath];
    NSLog(@"aaaaaa%zd", indexPath.row);
    ZDCellModel *cellModel = self.modelArray[indexPath.row];
    zdCell.cellModel = cellModel;
    NSLog(@"********%zd",cellModel.position);
    zdCell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    
    zdCell.loadDelegate = ^(ZDTableViewCell *cell) {
        //回到主线程更新,不然有可能会崩溃
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadRowsAtIndexPaths:@[cell.indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        });
    };
    zdCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return zdCell;
}

- (NSArray *)urlArray{
    if (!_urlArray) {
        _urlArray = @[@"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=27e41b0d80cb39dbd5cd6f04b17f6241/7acb0a46f21fbe099143bcf36a600c338744ad3c.jpg",
                       @"https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike272%2C5%2C5%2C272%2C90/sign=e31d7a55dba20cf4529df68d17602053/91ef76c6a7efce1b27893518a451f3deb58f6546.jpg",
                       @"https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=8816325c4036acaf4ded9eae1db0e675/fcfaaf51f3deb48fcfadd0bbfb1f3a292cf5788a.jpg",
                       @"https://gss1.bdstatic.com/-vo3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike180%2C5%2C5%2C180%2C60/sign=f3b1c04a23381f308a1485fbc868276d/08f790529822720e616d108870cb0a46f21fab25.jpg",
                       @"https://gss0.bdstatic.com/-4o3dSag_xI4khGkpoWK1HF6hhy/baike/c0%3Dbaike116%2C5%2C5%2C116%2C38/sign=ee9bedd9b8de9c82b268f1dd0de8eb6f/3ac79f3df8dcd100c662f1c1798b4710b8122f57.jpg",];
    }
    return _urlArray;
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
        [self addModel:30];
    }
    return _modelArray;
}

- (void)addModel:(NSInteger)count{
    for (int i = 0; i<count; i++) {
        ZDCellModel *cellM = [[ZDCellModel alloc] init];
        cellM.position = i%2;
        NSLog(@"%zd\n", cellM.position);
        cellM.imageUrl = self.urlArray[i%2];
        [_modelArray addObject:cellM];
        _count = self.modelArray.count;
    }
}
@end
