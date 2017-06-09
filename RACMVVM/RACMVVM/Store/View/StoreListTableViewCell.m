//
//  StoreListTableViewCell.m
//  RACMVVM
//
//  Created by HJQ on 2017/6/9.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "StoreListTableViewCell.h"

@implementation StoreListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark: - getter  and setter
- (void)setStoreListModel:(StoreListModel *)storeListModel {
    _storeListModel = storeListModel;
    [self setupUI];
}

#pragma mark: - private Methods
- (void)setupUI {
    self.storeNameLabel.text = _storeListModel.store_name;
    self.storeDescLabel.text = _storeListModel.store_desc;
}

@end
