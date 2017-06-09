//
//  StoreListViewModel.h
//  RACMVVM
//
//  Created by HJQ on 2017/6/9.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreListViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong) RACCommand *rightNavBtnCommand;

@property (nonatomic, strong) RACCommand *refreshCommand;

@property (nonatomic, strong) RACCommand *nextPageComand;

// 刷新完毕
@property (nonatomic, strong) RACSubject *refreshEndSubject;

@end
