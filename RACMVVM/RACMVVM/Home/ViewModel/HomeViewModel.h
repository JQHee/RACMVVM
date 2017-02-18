//
//  HomeViewModel.h
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeViewModel : NSObject

// Cell点击的回调
@property (nonatomic, strong) RACSubject *cellClickSubject;
// 下拉刷新
@property (nonatomic, strong) RACCommand *refreshCommand;
// 上拉刷新
@property (nonatomic, strong) RACCommand *nextCommand;
// 按钮事件
@property (nonatomic, strong) RACCommand *leftBtnCommon;

// 数据源
@property (nonatomic, strong) NSMutableArray *datasArray;

@end
