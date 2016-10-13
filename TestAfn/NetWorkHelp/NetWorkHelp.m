//
//  NetWorkHelp.m
//  RebateMall
//
//  Created by ys on 16/5/11.
//  Copyright © 2016年 Liqu. All rights reserved.
//

#import "NetWorkHelp.h"
#import "AFNetworking.h"
//#import "GMDCircleLoader.h"

@implementation NetWorkHelp

// 初始化状态
static AFNetworkReachabilityStatus networkStatus = -2;

// 开始检测网络
+ (void)startMonitorNet
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%@", AFStringFromNetworkReachabilityStatus(status));
        networkStatus = status;
        
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 进行网络请求的方法
 @param urlString 接口
 @param method    POST/GET
 @param view   所在的视图
 @param view   处在视图中的顶部坐标
 @param success   成功回调
 @param error     失败回调
 */
+ (void)requestDataFromUrlString:(NSString *)urlString andMethod:(NSString *)method andParameters:(NSDictionary *)paramers toView:(UIView *)view andTop:(CGFloat)top andTopOrBottomRefresh:(BOOL)topOrBottomRefresh andSuccess:(void (^)(id))success andFail:(void (^)(NSError *))fail
{
    // 首先先检查网络
    if (networkStatus == -1 || networkStatus == 0) {
        // 没有网络
        if (fail) {
            fail(nil);
        } else {
            NSLog(@"没有网络");
        }
        
        return;
    }
    
    
    if (view && !topOrBottomRefresh) {
//        [GMDCircleLoader setOnView:view withTop:top animated:YES];
        //[GMDCircleLoader setOnView:view withTitle:nil animated:YES];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript",@"text/plain", nil]];
//    [self achiveSomeMassege:manager.requestSerializer];
    
    
    NSLog(@"%f", manager.requestSerializer.timeoutInterval);
    
    // 设置请求超时时间
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 10.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    if ([method isEqualToString:@"GET"] || method == nil) {
        [manager GET:urlString
          parameters:paramers
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                 [GMDCircleLoader hideFromView:view animated:YES];
                 if (responseObject != nil) {
                     NSDictionary *dic = [self changeType:responseObject];
                     if (success) {
                         success(dic);
                     }
                 }
             } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                 [GMDCircleLoader hideFromView:view animated:YES];
                 if (fail) {
                     fail(error);
                 } else {
                     NSLog(@"加载失败");
                 }
             }];
    } else {
        [manager POST:urlString
           parameters:paramers
             progress:nil
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                  [GMDCircleLoader hideFromView:view animated:YES];
                  if (responseObject != nil) {
                      success(responseObject);
                  }
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                  [GMDCircleLoader hideFromView:view animated:YES];
                  if (fail) {
                      fail(error);
                  } else {
                      NSLog(@"加载失败");
                  }
              }];
    }
}

//+ (void )achiveSomeMassege:(AFHTTPRequestSerializer *)serializer
//{
//    //个推设备编号
//    [serializer setValue:[Toolkit getUserInfoObjectForKey:LQ_ClientId] forHTTPHeaderField:user_gtCid];
//    //操作系统类型
//    [serializer setValue:@"iOS" forHTTPHeaderField:user_os];
//    //网络类型
//    [serializer setValue:[Toolkit getNetWorkType] forHTTPHeaderField:user_netType];
//    //用户身份标识
//    [serializer setValue:[Toolkit getUserkey] forHTTPHeaderField:user_usToken];
//    //设备唯一编号
//    [serializer setValue:[Toolkit getPhoneidUUID] forHTTPHeaderField:user_devid];
//    //操作系统版本
//    [serializer setValue:[Toolkit getOsVersion]  forHTTPHeaderField:user_osVersion];
//    //app当前版本
//    [serializer setValue:[Toolkit getUserAPPVersion] forHTTPHeaderField:user_appVersion];
//    //app包名
//    [serializer setValue:[Toolkit getUserAPPName] forHTTPHeaderField:user_appName];
//    //app类型
//    [serializer setValue:@"iOS" forHTTPHeaderField:user_appType];
//    
//}

#pragma mark - 公有方法
//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}
+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    NSArray *keyArr = [myDic allKeys];
    NSMutableDictionary *resDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i < keyArr.count; i ++)
    {
        id obj = [myDic objectForKey:keyArr[i]];
        
        obj = [self changeType:obj];
        if (obj) {
            [resDic setObject:obj forKey:keyArr[i]];
        }
    }
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    NSMutableArray *resArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < myArr.count; i ++)
    {
        id obj = myArr[i];
        
        obj = [self changeType:obj];
        
        [resArr addObject:obj];
    }
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成nil
+(NSString *)nullToString
{
    return nil;
}

//将nil类型的项目转化成@""防止字典参数崩溃
+ (NSString *)getParameterString:(NSString *)value;
{
    if (value == nil) {
        return @"";
    }
    return value;
}

//将nil类型的项目转化成0防止字典参数崩溃
+ (NSString *)getParameterZeroString:(NSString *)value
{
    if (value == nil) {
        return @"0";
    }
    return value;
}

@end
