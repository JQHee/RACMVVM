

#import "JSCartViewController.h"
#import "JSCartUIService.h"
#import "JSCartViewModel.h"
#import "JSCartBar.h"

#define XNWindowWidth [UIScreen mainScreen].bounds.size.width
#define XNWindowHeight [UIScreen mainScreen].bounds.size.height

@interface JSCartViewController ()
{
    BOOL _isIdit;
    UIBarButtonItem *_editItem;
    UIBarButtonItem *_makeDataItem;
}
@property (nonatomic, strong) JSCartUIService *service;

@property (nonatomic, strong) JSCartViewModel *viewModel;

@property (nonatomic, strong) UITableView     *cartTableView;

@property (nonatomic, strong) JSCartBar       *cartBar;

@end

@implementation JSCartViewController

#pragma mark: - lift cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getNewData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    /*setting up*/
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"购物车";
    /*eidit button*/
    _isIdit = NO;
    [self setupUI];
    [self viewBindEvents];
}

#pragma mark: - private Methods
- (void)setupUI {

    [self setupNavBar];
    /*add view*/
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.cartBar];
}

- (void)setupNavBar {

    self.navigationItem.leftBarButtonItem = ({
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"新数据"
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(makeNewData:)];
        leftItem.tintColor = [UIColor redColor];
        _makeDataItem = leftItem;
        leftItem;
    });
    
    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑"
                                                     style:UIBarButtonItemStyleDone
                                                    target:self
                                                    action:@selector(editClick:)];
        rightItem.tintColor = [UIColor colorWithRed:170/255.0 green:170/255.0  blue:170/255.0  alpha:1];
        _editItem = rightItem;
        rightItem;
    });

}

- (void)viewBindEvents {
    
    /* RAC  */
    @weakify(self);
    //全选
    [[self.cartBar.selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        @strongify(self);
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    //删除
    [[self.cartBar.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        @strongify(self);
        [self.viewModel deleteGoodsBySelect];
    }];
    //结算
    [[self.cartBar.balanceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        //@strongify(self);
        
    }];
    /* 观察价格属性 */
    [RACObserve(self.viewModel, allPrices) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.cartBar.money = x.floatValue;
    }];
    
    /* 全选 状态 */
    RAC(self.cartBar.selectAllButton,selected) = RACObserve(self.viewModel, isSelectAll);
    
    /* 购物车数量 */
    [RACObserve(self.viewModel, cartGoodsCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        if(x.integerValue == 0){
            self.title = [NSString stringWithFormat:@"购物车"];
        } else {
            self.title = [NSString stringWithFormat:@"购物车(%@)",x];
        }
        
    }];

}


#pragma mark - lazy load

- (JSCartViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[JSCartViewModel alloc] init];
        _viewModel.cartVC = self;
        _viewModel.cartTableView  = self.cartTableView;
    }
    return _viewModel;
}


- (JSCartUIService *)service{
    
    if (!_service) {
        _service = [[JSCartUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}


- (UITableView *)cartTableView{
    
    if (!_cartTableView) {
        _cartTableView = [[UITableView alloc] initWithFrame:self.view.frame
                                                      style:UITableViewStyleGrouped];
        [_cartTableView registerNib:[UINib nibWithNibName:@"JSCartCell" bundle:nil]
             forCellReuseIdentifier:@"JSCartCell"];
        [_cartTableView registerClass:NSClassFromString(@"JSCartFooterView") forHeaderFooterViewReuseIdentifier:@"JSCartFooterView"];
        [_cartTableView registerClass:NSClassFromString(@"JSCartHeaderView") forHeaderFooterViewReuseIdentifier:@"JSCartHeaderView"];
        _cartTableView.dataSource = self.service;
        _cartTableView.delegate   = self.service;
        _cartTableView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XNWindowWidth, 50)];
    }
    return _cartTableView;
}

- (JSCartBar *)cartBar{
    
    if (!_cartBar) {
        _cartBar = [[JSCartBar alloc] initWithFrame:CGRectMake(0, XNWindowHeight-50, XNWindowWidth, 50)];
        _cartBar.isNormalState = YES;
    }
    return _cartBar;
}

#pragma mark - method

- (void)getNewData{
    /**
     *  获取数据
     */
    [self.viewModel getData];
    [self.cartTableView reloadData];
}

- (void)editClick:(UIBarButtonItem *)item{
    _isIdit = !_isIdit;
    NSString *itemTitle = _isIdit == YES?@"完成":@"编辑";
    _editItem.title = itemTitle;
    self.cartBar.isNormalState = !_isIdit;
}

- (void)makeNewData:(UIBarButtonItem *)item{
    
    [self getNewData];
}



@end
