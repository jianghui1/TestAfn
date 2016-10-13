//
//  ViewController.m
//  TestAfn
//
//  Created by ys on 16/7/8.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "ViewController.h"

#import <UIWebView+AFNetworking.h>

#import <AFNetworkReachabilityManager.h>

#import "NetWorkHelp.h"
#import <AFNetworking.h>

#define http_Services  @"http://app.liqu.com"

#define Get_HomeMenu_URL        @"/services/homeinit"

//用户身份标识
#define user_usToken          @"usToken"
//设备唯一编号
#define user_devid            @"devid"
//网络类型
#define user_netType          @"netType"
//操作系统类型
#define user_os               @"os"
//操作系统版本
#define user_osVersion        @"osVersion"
//app类型
#define user_appType          @"appType"
//app当前版本
#define user_appVersion       @"appVersion"
//个推设备编号
#define user_gtCid            @"gtCid"
//项目名称
#define user_appName          @"package"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


//    NSString *urlString = @"http://app.liqu.com/h5/searchnew";
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:webView];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [webView loadRequest:request progress:nil success:^NSString * _Nonnull(NSHTTPURLResponse * _Nonnull response, NSString * _Nonnull HTML) {
////        NSLog(@"%@----%@", response, HTML);
//        return nil;
//    } failure:^(NSError * _Nonnull error) {
////        NSLog(@"%@", error);
//    }];
    
    // 对应的系统当前版本
//    NSLog(@"%f", NSFoundationVersionNumber);

//    [NetWorkHelp startMonitorNet];
//    
//    [NetWorkHelp requestDataFromUrlString:nil andMethod:nil andParameters:nil toView:nil andTop:0 andTopOrBottomRefresh:NO andSuccess:^(id response) {
//        NSLog(@"%@", response);
//    } andFail:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:http_Services]];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *paramers = @{@"stamp" : @"0"};
    NSDictionary *paramers1 = @{@"stamp" : @"0"};
    NSDictionary *paramers2 = @{@"stamp" : @"0"};

//    NSString *urlString1 = [http_Services stringByAppendingString:Get_HomeMenu_URL];
//    
//    [manager GET:urlString1
//      parameters:paramers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          NSLog(@"成功1");
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          NSLog(@"失败1");
//      }];
//    [manager GET:Get_HomeMenu_URL
//      parameters:paramers1 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          NSLog(@"成功2");
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          NSLog(@"失败2");
//      }];
//    [manager GET:Get_HomeMenu_URL
//      parameters:paramers2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//          NSLog(@"成功3");
//      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//          NSLog(@"失败3");
//      }];
//    
//    NSURL *baseUrl = [NSURL URLWithString:http_Services];
//    NSLog(@"%@", baseUrl);
//    NSURL *url1 = [NSURL URLWithString:Get_HomeMenu_URL relativeToURL:baseUrl];
//    NSLog(@"%@", url1);
//    NSLog(@"%@", [url1 absoluteString]);
//    
//    NSString *s1 = [http_Services stringByAppendingString:Get_HomeMenu_URL];
//    NSLog(@"%@", s1);
//    NSURL *url2 = [NSURL URLWithString:s1 relativeToURL:baseUrl];
//    NSLog(@"%@", url2);
//    NSLog(@"%@", [url2 absoluteString]);
    
    [manager GET:Get_HomeMenu_URL parameters:paramers1 progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@", [NSThread currentThread]);
        NSLog(@"%@", downloadProgress);
        NSLog(@"%f", downloadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@", error);
    }];
    
}

@end
