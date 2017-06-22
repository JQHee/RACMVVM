

#import <Foundation/Foundation.h>

@class JSCartViewModel;

@interface JSCartUIService : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) JSCartViewModel *viewModel;

@end
