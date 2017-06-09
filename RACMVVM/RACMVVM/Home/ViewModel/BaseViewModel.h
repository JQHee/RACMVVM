//
//  BaseViewModel.h
//  RACMVVM
//
//  Created by MAC on 2017/2/18.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, JQRefreshDataStatus) {
    JQHeaderRefresh_HasMoreData = 1,
    JQHeaderRefresh_HasNoMoreData,
    JQFooterRefresh_HasMoreData,
    JQFooterRefresh_HasNoMoreData,
    JQRefreshError,
    JQRefreshUI,
} ;

@protocol BaseViewModel <NSObject>

@end
