//
//  HomeCell.h
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface HomeCell : UITableViewCell

@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, strong) RACSubject *imageSelectedSubject;
@property (weak, nonatomic) IBOutlet UIImageView *tempimageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@end
