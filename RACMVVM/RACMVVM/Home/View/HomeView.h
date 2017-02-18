//
//  HomeView.h
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewModel;
@interface HomeView : UIView

@property (nonatomic, strong) HomeViewModel *homeViewModel;
@property (nonatomic, strong) NSMutableArray *datas;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
