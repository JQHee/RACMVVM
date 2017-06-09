//
//  HomeView.m
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "HomeView.h"
#import "HomeCell.h"
#import "HomeViewModel.h"

@interface HomeView ()<UITableViewDelegate,UITableViewDataSource>


@end


@implementation HomeView


- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark: - getter and setter
- (void)setHomeViewModel:(HomeViewModel *)homeViewModel {
    _homeViewModel = homeViewModel;
}


#pragma mark: - private methods
- (void) setupUI {
    
    [self setupTableView];
}

- (void) setupTableView {
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 90;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.refreshCommand execute:self.tableView];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.homeViewModel.nextCommand execute:self.tableView];
    }];
    
}


#pragma mark - UITableViewDatasource Methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.imageSelectedSubject = [RACSubject subject];
    [cell.imageSelectedSubject subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

#pragma mark - UITableViewDelegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 选中后恢复颜色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.homeViewModel.cellClickSubject) {
        [self.homeViewModel.cellClickSubject sendNext:self.datas[indexPath.row]];
    }
}

@end
