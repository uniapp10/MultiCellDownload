//
//  ZDTableViewCell.h
//  MultiDownload
//
//  Created by ZD on 2018/4/21.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZDCellModel.h"

@interface ZDTableViewCell : UITableViewCell
@property (nonatomic, strong) ZDCellModel *cellModel;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) void (^loadDelegate) (ZDTableViewCell *cell);
@end
