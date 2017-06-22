

#import "JSCartHeaderView.h"

#define XNWindowWidth [UIScreen mainScreen].bounds.size.width

@interface JSCartHeaderView()

@property (nonatomic, strong) UIButton *storeNameButton;

@end

@implementation JSCartHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setHeaderUI];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.selectStoreGoodsButton.frame = CGRectMake(0, 0, 36, 30);
    self.storeNameButton.frame = CGRectMake(40, 0, XNWindowWidth-40, 30);
    
}


#pragma mark: - private Methods
- (void)setHeaderUI{
    
     self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.selectStoreGoodsButton];
    [self addSubview:self.storeNameButton];

}


#pragma mark: - public methods
+ (CGFloat)getCartHeaderHeight{
    
    return 30;
}

#pragma mark: - lazy load
- (UIButton *)selectStoreGoodsButton {
    if (! _selectStoreGoodsButton) {
        _selectStoreGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectStoreGoodsButton.frame = CGRectZero;
        [_selectStoreGoodsButton setImage:[UIImage imageNamed:@"xn_circle_normal"]
                                 forState:UIControlStateNormal];
        [_selectStoreGoodsButton setImage:[UIImage imageNamed:@"xn_circle_select"]
                                 forState:UIControlStateSelected];
        _selectStoreGoodsButton.backgroundColor=[UIColor clearColor];
    }
    return _selectStoreGoodsButton;
}

- (UIButton *)storeNameButton {
    if (! _storeNameButton) {
        
        _storeNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _storeNameButton.frame = CGRectZero;
        [_storeNameButton setTitle:@"店铺名字_____"
                          forState:UIControlStateNormal];
        [_storeNameButton setTitleColor:[UIColor blackColor]
                               forState:UIControlStateNormal];
        _storeNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _storeNameButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        _storeNameButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _storeNameButton;
}

@end
