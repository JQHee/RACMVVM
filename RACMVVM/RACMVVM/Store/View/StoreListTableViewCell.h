//
//  StoreListTableViewCell.h
//  RACMVVM
//
//  Created by HJQ on 2017/6/9.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreListModel.h"

@interface StoreListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (nonatomic, strong) StoreListModel *storeListModel;

@end
