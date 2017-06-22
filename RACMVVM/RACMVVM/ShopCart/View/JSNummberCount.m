

#import "JSNummberCount.h"

static CGFloat const Wd = 28;

@interface JSNummberCount()
//加
@property (nonatomic, strong) UIButton    *addButton;
//减
@property (nonatomic, strong) UIButton    *subButton;
//数字按钮
@property (nonatomic, strong) UITextField *numberTT;

@end

@implementation JSNummberCount

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark -  private methods
- (void)setupUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.currentCountNumber = 0;
    self.totalNum = 0;
    
    [self addSubview:self.subButton];
    [self addSubview:self.numberTT];
    [self addSubview:self.addButton];
    
    [self viewBindEvents];
    
}

- (void)viewBindEvents {
    
    @weakify(self);
    [[self.subButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        self.currentCountNumber--;
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(self.currentCountNumber);
        }
        
    }];
    
    
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self);
        self.currentCountNumber++;
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(self.currentCountNumber);
        }
    }];
    
    /************************** 内容改变 ****************************/
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UITextFieldTextDidEndEditingNotification" object:self.numberTT] subscribeNext:^(NSNotification *x) {
        @strongify(self);
        UITextField *t1 = [x object];
        NSString *text = t1.text;
        NSInteger changeNum = 0;
        if (text.integerValue>self.totalNum&&self.totalNum!=0) {
            
            self.currentCountNumber = self.totalNum;
            self.numberTT.text = [NSString stringWithFormat:@"%@",@(self.totalNum)];
            changeNum = self.totalNum;
            
        } else if (text.integerValue<1){
            
            self.numberTT.text = @"1";
            changeNum = 1;
            
        } else {
            
            self.currentCountNumber = text.integerValue;
            changeNum = self.currentCountNumber;
            
        }
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(changeNum);
        }
        
    }];
    
    /* 捆绑加减的enable */
    RACSignal *subSignal =  [RACObserve(self, currentCountNumber) map:^id(NSNumber *subValue) {
        return @(subValue.integerValue>1);
    }];
    RACSignal *addSignal =  [RACObserve(self, currentCountNumber) map:^id(NSNumber *addValue) {
        return @(addValue.integerValue<self.totalNum);
    }];
    RAC(self.subButton,enabled)  = subSignal;
    RAC(self.addButton,enabled)  = addSignal;
    /* 内容颜色显示 */
    RACSignal *numColorSignal = [RACObserve(self, totalNum) map:^id(NSNumber *totalValue) {
        return totalValue.integerValue==0?[UIColor redColor]:[UIColor blackColor];
    }];
    RAC(self.numberTT,textColor) = numColorSignal;
    /*  */
    RACSignal *textSigal = [RACObserve(self, currentCountNumber) map:^id(NSNumber *Value) {
        return [NSString stringWithFormat:@"%@",Value];
    }];
    RAC(self.numberTT,text) = textSigal;

}

#pragma mark: - lazy load
- (UIButton *)subButton {
    if (! _subButton) {
        /************************** 加 ****************************/
        _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _subButton.frame = CGRectMake(0, 0, Wd,Wd);
        [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"]
                              forState:UIControlStateNormal];
        [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"]
                              forState:UIControlStateDisabled];
        _subButton.tag = 0;
        
    }
    return _subButton;
}

- (UITextField *)numberTT {
    if (! _numberTT) {
        /************************** 内容 ****************************/
        _numberTT = [[UITextField alloc]init];
        _numberTT.frame = CGRectMake(CGRectGetMaxX(_subButton.frame), 0, Wd*1.5, _subButton.frame.size.height);
        _numberTT.keyboardType=UIKeyboardTypeNumberPad;
        _numberTT.text=[NSString stringWithFormat:@"%@",@(0)];
        _numberTT.backgroundColor = [UIColor whiteColor];
        _numberTT.textColor = [UIColor blackColor];
        _numberTT.adjustsFontSizeToFitWidth = YES;
        _numberTT.textAlignment=NSTextAlignmentCenter;
        _numberTT.layer.borderColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1].CGColor;
        _numberTT.layer.borderWidth = 1.3;
        _numberTT.font= [UIFont systemFontOfSize:17];
    }
    return _numberTT;
}

- (UIButton *)addButton {
    if (! _addButton) {
        /************************** 加 ****************************/
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(CGRectGetMaxX(_numberTT.frame), 0, Wd,Wd);
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"]
                              forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"]
                              forState:UIControlStateDisabled];
        _addButton.tag = 1;
    }
    return _addButton;
}




@end
