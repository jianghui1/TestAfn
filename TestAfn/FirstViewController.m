//
//  FirstViewController.m
//  TestAfn
//
//  Created by ys on 16/7/13.
//  Copyright © 2016年 jzh. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

@end

@implementation FirstViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    self.name = @"miniThree";
    self.age = 18;
}

- (void)setAge:(int)age
{
    _age = age;
    NSLog(@"age");
}

- (void)setName:(NSString *)name
{
    _name = name;
    NSLog(@"name");
}

@end
