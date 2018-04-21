//
//  ZDCellModel.h
//  MultiDownload
//
//  Created by ZD on 2018/4/21.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZDCellModel : NSObject
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) UIImage *image;
@end
