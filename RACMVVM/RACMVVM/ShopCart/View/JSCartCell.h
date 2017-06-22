

#import <UIKit/UIKit.h>

@class JSCartModel,JSNummberCount;

@interface JSCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selectShopGoodsButton;

@property (weak, nonatomic) IBOutlet JSNummberCount *nummberCount;

@property (nonatomic, strong) JSCartModel *model;

+ (CGFloat)getCartCellHeight;

@end
