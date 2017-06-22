

#import "JSCartCell.h"
#import "JSNummberCount.h"
#import "JSCartModel.h"

@interface JSCartCell ()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;

@end

@implementation JSCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

}

#pragma mark: - setter and getter
- (void)setModel:(JSCartModel *)model{
    
    _model = model;
    self.goodsImageView.image            = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.p_imageUrl]]];
    self.goodsNameLabel.text             = model.p_name;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%.2f",model.p_price];
    self.nummberCount.totalNum           = model.p_stock;
    self.nummberCount.currentCountNumber = model.p_quantity;
    self.selectShopGoodsButton.selected  = model.isSelect;
}

#pragma mark: - public methods
+ (CGFloat)getCartCellHeight{
    
    return 100;
}

@end
