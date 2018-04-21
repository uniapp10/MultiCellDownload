//
//  ZDTableViewCell.m
//  MultiDownload
//
//  Created by ZD on 2018/4/21.
//  Copyright © 2018年 朱冬冬. All rights reserved.
//

#import "ZDTableViewCell.h"
#import <SDWebImage/SDWebImageManager.h>
#import <Masonry.h>

@interface ZDTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (nonatomic, strong) UIButton *errorBtn;

@end
@implementation ZDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImage.userInteractionEnabled = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellModel:(ZDCellModel *)cellModel{
    _cellModel = cellModel;
    self.titleL.text = [NSString stringWithFormat:@"这是第%zd副图", cellModel.position];
    //清除重用时的缓存
    self.iconImage.image = nil;
    
    if (cellModel.image != nil) {
        self.iconImage.image = cellModel.image;
        return;
    }
    [self loadImage];
}

- (void)loadImage{
    NSURL *url = [NSURL URLWithString:_cellModel.imageUrl];
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] loadImageWithURL:url options:(SDWebImageRefreshCached) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (error) {
            weakSelf.errorBtn.hidden = false;
            [weakSelf.iconImage bringSubviewToFront:_errorBtn];
        }else{
            _errorBtn.hidden = true;
            __strong typeof(self) strongSelf = weakSelf;
            _cellModel.image = image;
            if(strongSelf.loadDelegate){
                strongSelf.loadDelegate(strongSelf);
            }
        }
        //        strongSelf.iconImage.image = image;
    }];
}


- (UIButton *)errorBtn{
    if (!_errorBtn) {
        _errorBtn = [[UIButton alloc] init];
        _errorBtn.backgroundColor = [UIColor lightGrayColor];
        [_errorBtn setTitle:@"重新下载" forState:(UIControlStateNormal)];
        [_iconImage addSubview:_errorBtn];
        [_errorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        _errorBtn.titleLabel.textColor = [UIColor redColor];
        [_errorBtn addTarget:self action:@selector(loadImage) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _errorBtn;
}
@end
