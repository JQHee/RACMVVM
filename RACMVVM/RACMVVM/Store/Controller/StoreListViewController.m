//
//  StoreListViewController.m
//  RACMVVM
//
//  Created by HJQ on 2017/6/9.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "StoreListViewController.h"
#import "StoreListTableViewCell.h"
#import "StoreListViewModel.h"
#import "BaseViewModel.h"


@interface StoreListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) StoreListViewModel *storeListViewModel;
@property (nonatomic, strong) UIButton *rightNavButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoreListViewController

#pragma mark: - getter and setter
- (StoreListViewModel *)storeListViewModel {
    if (! _storeListViewModel) {
        _storeListViewModel = [[StoreListViewModel alloc]init];
    }
    return _storeListViewModel;
}

#pragma mark: - lift Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺";
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self bindViewModel];
    [self viewBindEvents];
}

#pragma mark: - private Methods
- (void)setupUI {
    [self setupNavBar];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    // 首次进入刷新
    [self.tableView.mj_header beginRefreshing];
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.storeListViewModel.refreshCommand execute:@""];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self.storeListViewModel.nextPageComand execute:@""];
    }];
    
}

- (void)setupNavBar {
    
    self.navigationItem.rightBarButtonItem = ({
        UIButton *rightNavItem = [UIButton buttonWithType:UIButtonTypeCustom];
        rightNavItem.backgroundColor = [UIColor redColor];
        rightNavItem.frame = CGRectMake(0, 0, 40, 40);
        _rightNavButton = rightNavItem;
        UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNavItem];
        rightButtonItem;
    });
}

- (void)bindViewModel {
    // 数据绑定
//    RAC(self.loginVM.account, account) = self.loginTF.rac_textSignal;
//    RAC(self.loginVM.account, psw) = self.pswTF.rac_textSignal;
//    RAC(self.loginBTN, enabled) = self.loginVM.loginEnableSignal;
    //RAC(self,rightNavButton.rac_command) = RACObserve(self.storeListViewModel, rightNavBtnCommand);
}

- (void)viewBindEvents {
    @weakify(self);
    [[self.rightNavButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self.storeListViewModel.rightNavBtnCommand execute:@""];
    }];
    
    
    [self.storeListViewModel.refreshEndSubject subscribeNext:^(NSNumber* x) {
        @strongify(self);
        [self.tableView reloadData];
        
        switch ([x integerValue]) {
            case JQHeaderRefresh_HasMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                break;
                
            }
            case JQHeaderRefresh_HasNoMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                break;
            }
                
            case JQFooterRefresh_HasMoreData: {
                
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                break;
            }
                
            case JQFooterRefresh_HasNoMoreData: {
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                break;
            }
                
            case JQRefreshError: {
                
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                break;
            }
        }
        
        
    }];

}

#pragma mark: - UITableViewDatasoure Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.storeListViewModel.datas.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoreListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StoreListTableViewCell"];
    cell.storeListModel = self.storeListViewModel.datas[indexPath.row];
    return cell;
}


#pragma mark: - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)dealloc {
    NSLog(@"VCdealloc");
}

@end
