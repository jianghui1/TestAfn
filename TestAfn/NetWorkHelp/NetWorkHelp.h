//
//  NetWorkHelp.h
//  RebateMall
//
//  Created by ys on 16/5/11.
//  Copyright © 2016年 Liqu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NetWorkHelp : NSObject

// 开始检测网络
+ (void)startMonitorNet;

/**
 进行网络请求的方法
 @param urlString 接口
 @param method    POST/GET
 @param view   所在的视图
 @param view   处在视图中的顶部坐标
 @param success   成功回调
 @param error     失败回调
 */
+ (void)requestDataFromUrlString:(NSString *)urlString andMethod:(NSString *)method andParameters:(NSDictionary *)paramers toView:(UIView *)view andTop:(CGFloat)top andTopOrBottomRefresh:(BOOL)topOrBottomRefresh andSuccess:(void (^)(id))success andFail:(void (^)(NSError *))fail;

//将nil类型的项目转化成@""防止字典参数崩溃
+ (NSString *)getParameterString:(NSString *)value;
//将nil类型的项目转化成@""防止字典参数崩溃
+ (NSString *)getParameterZeroString:(NSString *)value;

@end
