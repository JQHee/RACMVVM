

static const  NSInteger  BalanceButtonTag = 120;
static const NSInteger  DeleteButtonTag = 121;
static const NSInteger  SelectButtonTag = 122;

#define XNWindowWidth [UIScreen mainScreen].bounds.size.width

#import "JSCartBar.h"

@interface UIImage (JS)

+ (UIImage *)imageWithColor:(UIColor *)color ;

@end

@implementation UIImage (JS)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end

@interface JSCartBar ()

@end

@implementation JSCartBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self viewBindEvents];
    }
    return self;
}



#pragma mark: - private methods
- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    /* 背景 */
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effectView.userInteractionEnabled = NO;
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XNWindowWidth, 0.5)];
    lineView.backgroundColor  = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1];
    [self addSubview:lineView];
    
    [self addSubview:self.balanceButton];
    [self addSubview:self.deleteButton];
    [self addSubview:self.selectAllButton];
    [self addSubview:self.allMoneyLabel];
    
}

#pragma mark: - event response
- (void)viewBindEvents {
    /* assign value */
    @weakify(self);
    [RACObserve(self, money) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.allMoneyLabel.text = [NSString stringWithFormat:@"总计￥:%.2f",x.floatValue];
    }];
    
    /*  RAC BLIND  */
    RACSignal *comBineSignal = [RACSignal combineLatest:@[RACObserve(self, money)]
                                                 reduce:^id(NSNumber *moeny){
                                                     if (moeny.floatValue == 0) {
                                                         self.selectAllButton.selected = NO;
                                                     }
                                                     return @(moeny.floatValue>0);
                                                 }];
    
    RAC(self.balanceButton,enabled) = comBineSignal;
    RAC(self.deleteButton,enabled) = comBineSignal;
    
    [RACObserve(self, isNormalState) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        BOOL isNormal =  x.boolValue;
        self.balanceButton.hidden = !isNormal;
        self.allMoneyLabel.hidden = !isNormal;
        self.deleteButton.hidden = isNormal;
    }];

}

#pragma mark: - lazy load 
- (UIButton *)balanceButton {
    if (! _balanceButton) {
        
        /* 结算 */
        CGFloat wd = XNWindowWidth*2/7;
        _balanceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_balanceButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_balanceButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        [_balanceButton setTitle:@"结算" forState:UIControlStateNormal];
        [_balanceButton setFrame:CGRectMake(XNWindowWidth-wd, 0, wd, self.frame.size.height)];
        [_balanceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_balanceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _balanceButton.enabled = NO;
        _balanceButton.tag = BalanceButtonTag;
        
    }
    return _balanceButton;
}

- (UIButton *)deleteButton {
    if (! _deleteButton) {
        /* 删除 */
        CGFloat wd = XNWindowWidth*2/7;
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
        [_deleteButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [_deleteButton setFrame:CGRectMake(XNWindowWidth-wd, 0, wd, self.frame.size.height)];
        _deleteButton.enabled = NO;
        _deleteButton.hidden = YES;
        _deleteButton.tag = DeleteButtonTag;
    }
    return _deleteButton;
}

- (UIButton *)selectAllButton {
    if (! _selectAllButton) {
        /* 全选 */
        _selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllButton setTitle:@"全选"
                 forState:UIControlStateNormal];
        [_selectAllButton setTitleColor:[UIColor blackColor]
                      forState:UIControlStateNormal];
        [_selectAllButton setImage:[UIImage imageNamed:@"xn_circle_normal"]
                 forState:UIControlStateNormal];
        [_selectAllButton setImage:[UIImage imageNamed:@"xn_circle_select"]
                 forState:UIControlStateSelected];
        [_selectAllButton setFrame:CGRectMake(0, 0, 78, self.frame.size.height)];
        [_selectAllButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        _selectAllButton.tag = SelectButtonTag;
    }
    return _selectAllButton;
}

- (UILabel *)allMoneyLabel {
    if (! _allMoneyLabel) {
        /* 价格 */
        CGFloat wd = XNWindowWidth*2/7;
        _allMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(wd, 0, XNWindowWidth-wd*2-5, self.frame.size.height)];
        _allMoneyLabel.text = [NSString stringWithFormat:@"总计￥:%@",@(00.00)];
        _allMoneyLabel.textColor = [UIColor blackColor];
        _allMoneyLabel.font = [UIFont systemFontOfSize:15];
        _allMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _allMoneyLabel;
}


@end
