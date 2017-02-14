//
//  AppDelegate.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Netinterface.h"
#import "PersonVC.h"
#import "MyHTTPRequest.h"

@interface AppDelegate ()<MyHTTPRequestDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    //判断网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChange:) name:kReachabilityChangedNotification object:nil];
    reach = [Reachability reachabilityWithHostName:@"https://www.baidu.com"];
    [reach startNotifier];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        NSLog(@"是第一次运行程序");
        [self animation];
        
    }else
    {
        NSLog(@"不是第一次登陆");
        //检查是否已经登录过
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *username = [userDefaults objectForKey:@"username"];
        if (username) {
            //组合密匙
            NSString *password = [userDefaults objectForKey:@"password"];
            NSURL *url = [NSURL URLWithString:LOGIN];
            
            NSString *string = [NSString stringWithFormat:@"email=%@&password=%@",username,password];
            NSString *textStr =[string stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
            PersonVC *pVC = [[PersonVC alloc] init];
            MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
            request.delegate = self;
            [request startPost:textStr];
            pVC.dic = dict;
            
        }
        
        [self initWithWindow];
        
        
    }
    
    
    // Override point for customization after application launch.
    return YES;
}

- (void)reachabilityChange:(NSNotification *)note
{
    NSString *connectionKind = nil;
    Reachability *curReach = note.object;
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    netstatus = [curReach currentReachabilityStatus];
    switch (netstatus) {
        case NotReachable:
            connectionKind = @"当前没有网络链接\n请检查你的网络设置";
            isConnected =NO;
            break;
            
        case ReachableViaWiFi:
            connectionKind = @"当前有连接，WIFI";
            isConnected =YES;
            break;
            
        case ReachableViaWWAN:
            connectionKind = @"当前没有连接，2G/3G网络";
            isConnected =YES;
            break;
            
        default:
            break;
    }
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:connectionKind delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
    [view show];

}

- (void)animation
{
    CGFloat screenWidth = self.window.frame.size.width;
    CGFloat screenHeight = self.window.frame.size.height;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    [self.window addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(4*screenWidth, 0);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.pagingEnabled = YES;
    for (NSInteger i = 1; i<5; i++) {
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(screenWidth*(i-1), 0, screenWidth, screenHeight)];
        imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        [_scrollView addSubview:imageView1];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth*3, screenHeight-100, screenWidth, 100)];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button];


}

- (void)requestFinsh:(NSDictionary *)dic
{

    dict = dic;
}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

- (void)buttonClick
{
    [UIView animateWithDuration:1 animations:^{
        _scrollView.alpha = 0;
    } completion:^(BOOL finished) {
        //核心动画无效果
//        CATransition *anim = [CATransition animation];
//        anim.type = @"cube";
//        anim.subtype = kCATransitionFromRight;
//        anim.duration = 2;
//        [self.scrollView.layer addAnimation:anim forKey:nil];
//        [_scrollView removeFromSuperview];
        [self initWithWindow];
    }];
    

}

- (void)initWithWindow
{
    HomeViewController *homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:homeVC];
    self.window.rootViewController = homeNC;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
