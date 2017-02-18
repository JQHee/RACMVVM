//
//  ViewController.m
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewModel.h"
#import "HomeView.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet HomeView *homeView;
@property (nonatomic, strong) HomeViewModel *homeViewModel;
@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 这个属性一般是在SB上才会用设置，不然页面会显示不正常
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self bindViewModel];
    [self viewBindEvents];
    
}

- (void) setupUI {
    [self setupNavBar];
}

- (void) setupNavBar {
    
    self.title = @"首页";
    // 左边的NavbarItem
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.backgroundColor = [UIColor redColor];
    _leftBtn = button;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void) bindViewModel {
    
    // 数据绑定
    RAC(self.homeView,datas) = RACObserve(self.homeViewModel, datasArray);
    RAC(self.homeView,homeViewModel) = RACObserve(self, homeViewModel);
    RAC(self,leftBtn.rac_command) = RACObserve(self.homeViewModel,leftBtnCommon);
    
    // 第一次获取数据
    [self.homeViewModel.refreshCommand execute:self.homeView.tableView];
    
}

- (void) viewBindEvents {
    
    // Cell的点击事件
    @weakify(self);
    [[self.homeViewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"%@", x);
        UIViewController *VC = [UIViewController new];
        VC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:VC animated:YES];
        
    }];
    
    // 按钮的事件处理
    [[self.homeViewModel.leftBtnCommon.executionSignals.switchToLatest takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"按钮被点击了%@%@",x,self);
    }];
    
    [[[self.leftBtn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"第二种实现方式%@",self);
    }];
}

#pragma mark - Lazy Load
-(HomeViewModel *) homeViewModel {
    if (! _homeViewModel) {
        _homeViewModel = [[HomeViewModel alloc]init];
    }
    return _homeViewModel;
}

@end
