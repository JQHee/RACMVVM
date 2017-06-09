//
//  QFNetworking.h
//  LoveCar
//
//  Created by apple on 16/4/12.
//  Copyright © 2016年 aichezhonghua. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

// 服务器地址
static NSString *const mainDefaultAPI = @"http://www.baidu.com/";

typedef  NS_ENUM(NSUInteger,ServerAPIType) {
    defaultServerAPI
};


@interface QFNetworking : NSObject

+ (instancetype)sharedInstance;

- (void)POST:(NSString *)URLString
        type:(ServerAPIType)type
  parameters:(id)parameters
    progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error, NSString *errorMsg, NSString *errorCode))failure;
- (void)GET:(NSString *)URLString
       type:(ServerAPIType)type
 parameters:(id)parameters
   progress:(void (^)(NSProgress *progress))progress
    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
    failure:(void (^)(NSURLSessionDataTask *task, NSError *error, NSString *errorMsg, NSString *errorCode))failure;
- (void)POST:(NSString *)URLString
        type:(ServerAPIType)type
  parameters:(id)parameters
      images:(NSMutableArray *)images
    formData:(void (^)(id<AFMultipartFormData> formData))block
    progress:(void (^)(NSProgress *progress))progress
     success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
     failure:(void (^)(NSURLSessionDataTask *task, NSError *error, NSString *errorMsg, NSString *errorCode))failure;

- (void)cancelRequestWithURL:(NSString *)URL;
- (void)cancelAllRequest;

@end
