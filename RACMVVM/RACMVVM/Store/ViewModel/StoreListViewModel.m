//
//  StoreListViewModel.m
//  RACMVVM
//
//  Created by HJQ on 2017/6/9.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "StoreListViewModel.h"
#import "QFNetworking.h"
#import "BaseViewModel.h"
#import "StoreListModel.h"

@interface StoreListViewModel ()

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation StoreListViewModel


- (instancetype)init {
    self = [super init];
    if (self) {
        [self initWithModel];
    }
    return self;
}

#pragma mark: - private Methods
- (void)initWithModel {
    
    @weakify(self);
    
    // 按钮点击状态是否能点击
//    self.loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self.account, account), RACObserve(self.account, psw)] reduce:^id(NSString *v1, NSString *v2){
//        return @(v1.length && v2.length);
//    }];
    
    // 下拉刷新
    [self.refreshCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        if ([x isEqualToString:@"下拉刷新"]) {
            NSLog(@"%@", x);
        }
        [self.refreshEndSubject sendNext:@(JQHeaderRefresh_HasNoMoreData)];
    }];
    
    
    // 上拉刷新
    [self.nextPageComand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        if ([x isEqualToString:@"上拉刷新"]) {
            NSLog(@"%@", x);
        }
        [self.refreshEndSubject sendNext:@(JQFooterRefresh_HasNoMoreData)];
    }];
    
    // 按钮事件
    [self.rightNavBtnCommand.executionSignals.switchToLatest subscribeNext:^(NSString *x) {
        @strongify(self);
        if ([x isEqualToString:@"登录完毕"]) {
            NSLog(@"%@", x);
        }
        [self.refreshEndSubject sendNext:@(JQRefreshUI)];
    }];
}

#pragma mark: - setter and getter 
- (RACCommand *)refreshCommand {
    if (! _refreshCommand) {
        _refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@"下拉刷新"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _refreshCommand;
}

- (RACCommand *)nextPageComand {
    if (! _nextPageComand) {
        _nextPageComand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"按钮点击");
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                // 获取数据
                [subscriber sendNext:@"上拉刷新"];
                [subscriber sendCompleted];
                
                
                return nil;
            }];
        }];
    }
    return _nextPageComand;
}

- (RACCommand *)rightNavBtnCommand {
    if (! _rightNavBtnCommand) {
        _rightNavBtnCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            NSLog(@"按钮点击");
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                [subscriber sendNext:@"登录完毕"];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _rightNavBtnCommand;
}

- (RACSubject *)refreshEndSubject {
    if (! _refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}


@end
