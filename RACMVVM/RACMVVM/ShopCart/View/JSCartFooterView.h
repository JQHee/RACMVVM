

#import <UIKit/UIKit.h>

@interface JSCartFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSMutableArray *shopGoodsArray;

+ (CGFloat)getCartFooterHeight;

@end
