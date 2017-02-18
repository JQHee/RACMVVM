//
//  HomeCell.m
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    [self setupUI];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self viewBindEvents];
}

- (void) viewBindEvents {
    self.tempimageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc]init];
    [self.tempimageView addGestureRecognizer:Ges];
    [[Ges rac_gestureSignal] subscribeNext:^(id x) {
        if (self.imageSelectedSubject) {
            [self.imageSelectedSubject sendNext:@"图片被点击了"];
        }
    }];
}

- (void) setupUI {
    self.imageView.image = [UIImage imageNamed:_homeModel.picUrl];
    self.textLabel.text = _homeModel.title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
