

#import "JSCartFooterView.h"
#import "JSCartModel.h"

#define XNWindowWidth [UIScreen mainScreen].bounds.size.width

@interface JSCartFooterView ()

@property (nonatomic, retain) UILabel *priceLabel;

@end

@implementation JSCartFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self initCartFooterView];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.priceLabel.frame = CGRectMake(10, 0.5, XNWindowWidth - 20, 30);
    
}

#pragma mark: - private methods
- (void)initCartFooterView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.priceLabel];
}


#pragma mark: - setter and getter
- (void)setShopGoodsArray:(NSMutableArray *)shopGoodsArray{
    
    _shopGoodsArray = shopGoodsArray;
    
    NSArray *pricesArray = [[[_shopGoodsArray rac_sequence] map:^id(JSCartModel *model) {
        
        return @(model.p_quantity*model.p_price);
        
    }] array];
    
    float shopPrice = 0;
    for (NSNumber *prices in pricesArray) {
        shopPrice += prices.floatValue;
    }
    self.priceLabel.text = [NSString stringWithFormat:@"小记:￥%.2f",shopPrice];
}


#pragma mark: - lazy load
- (UILabel *)priceLabel {
    if (! _priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.text = @"小记:￥0.0";
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

#pragma mark: - public methods
+ (CGFloat)getCartFooterHeight{
    
    return 30;
}

@end
