//
//  HomeViewModel.m
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "HomeViewModel.h"

@interface HomeViewModel ()

@property (nonatomic, assign) NSInteger pageIndex;

@end


@implementation HomeViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWithModel];
    }
    return self;
}

- (void) initWithModel {
    @weakify(self);
    // 下拉刷新
    self.refreshCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(UITableView * input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if(input.mj_header.isRefreshing) {
                [input.mj_header endRefreshing];
            }
            @strongify(self);
            self.pageIndex = 1;
            self.datasArray = [NSMutableArray arrayWithObjects:@(self.pageIndex), nil];
            [input reloadData];
            [subscriber sendNext:@"登录完毕"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"信号被销毁了");
            }];
        }];
    }];
    
    // 下一页
    self.nextCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(UITableView * input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            if(input.mj_footer.isRefreshing) {
                [input.mj_footer endRefreshing];
            }
            @strongify(self);
            [self.datasArray addObject:@(++self.pageIndex)];
            [input reloadData];
            [subscriber sendNext:@"登录完毕"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"信号被销毁了");
            }];
        }];
    }];
    
    // 左边的按钮
    self.leftBtnCommon = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [subscriber sendNext:self.datasArray.firstObject];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
            }];
        }];
        return [RACSignal empty];
    }];
    
    // cell点击Subject
    self.cellClickSubject = [RACSubject subject];
    
}

@end
