//
//  AppDelegate.h
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Reachability.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability * reach;//网络状态
    NetworkStatus netstatus;
    BOOL isConnected;//判断是否已经连接
    NSDictionary *dict;
    
}


@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UIScrollView *scrollView;




@end

