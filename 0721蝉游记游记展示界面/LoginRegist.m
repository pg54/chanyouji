//
//  LoginRegist.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/21.
//  Copyright (c) 2015年 pangang. All rights reserved.
//
/*
 图片上传准备
 PostInfo *postInfo = [[PostInfo alloc] init];
 NSString *urlString = @"https://chanyouji.com/api/upload.php";
 NSString *path = [[NSBundle mainBundle] pathForResource:@"头像1.jpg" ofType:nil];
 NSData *data = [NSData dataWithContentsOfFile:path];
 
 [postInfo uploadFileWithURL:[NSURL URLWithString:urlString] Data:data];
 email=1260424774%40qq.com&password=15972835728
 
 https://chanyouji.com/api/users.json
 email=794427277%40qq.com&name=&password=15972835728
 
 
 device_token=AlHbVpVuQQBZP4mpwzLI6xyKCyKBNgwcT2o0isZ7ife3
 
 //        if ([personDic[@"token"] isEqualToString:@"fTK3ZrHUXYzCHujpys86"]) {
 //            [UIView animateWithDuration:1 animations:^{
 //                [inc startAnimating];
 //
 //            } completion:^(BOOL finished) {
 //
 //            }];
 //        }
 
 */


#import "LoginRegist.h"
#import "Netinterface.h"
#import "PostInfo.h"
#import "Netinterface.h"
#import "PersonVC.h"
#import "MyHTTPRequest.h"




@interface LoginRegist ()<UIScrollViewDelegate,UITextFieldDelegate,MyHTTPRequestDelegate>
{
    NSInteger currentPage;
    UITextField *regTextField1;
    UITextField *regTextField2;
    UIButton *confirmButton;
    NSMutableData *_data;
    NSDictionary *personDic;
    CGFloat width;
    CGFloat height;

}


@end

@implementation LoginRegist

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [NSMutableData data];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.delegate = self;
    [_scrollView addSubview:_logView];
    UIView *regView = [[UIView alloc]initWithFrame:CGRectMake(375, 0, 375, 549)];
    [_loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    [_registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_registButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_scrollView addSubview:regView];
    [_logView addSubview:_weiboButton];
    [_logView addSubview:_qqButton];
    
    [_weiboButton setImage:[UIImage imageNamed:@"WeiboLoginButton@2x"] forState:UIControlStateNormal];
    [_weiboButton setImage:[UIImage imageNamed:@"WeiboLoginButtonHighlight@2x"] forState:UIControlStateSelected];
    [_qqButton setImage:[UIImage imageNamed:@"LoginButton@2x"] forState:UIControlStateNormal];
    [_qqButton setImage:[UIImage imageNamed:@"LoginButtonHighlight@2x"] forState:UIControlStateSelected];
    
    _loginButton.selected = YES;
    _registButton.selected = NO;
    regTextField1 = [[UITextField alloc]init];
    regTextField2 = [[UITextField alloc]init];
    
    regTextField2.delegate=self;
    regTextField1.delegate=self;
    regTextField1.borderStyle = UITextBorderStyleLine;
    regTextField2.borderStyle = UITextBorderStyleLine;
    regTextField1.placeholder = @"电子邮箱";
    regTextField2.placeholder = @"密码";
    [regView addSubview:regTextField1];
    [regView addSubview:regTextField2];
    regTextField1.frame = CGRectMake(27, 36, 321, 30);
    regTextField2.frame = CGRectMake(27, 81, 321, 30);
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(2*375, 0);
    NSNotificationCenter *center =[NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];//显示
    [center addObserver:self selector:@selector(keyboardWillHid:) name:UIKeyboardWillHideNotification object:nil];//隐藏
    
    // Do any additional setup after loading the view from its nib.
}
- (void)keyboardWillShow:(NSNotification *)info
{
 
    
    CGRect viewframe =self.view.frame;
    viewframe.origin.y =-10;
    
    [UIView animateWithDuration:1 animations:^{
        
        self.view.frame=viewframe;
    }];

}
- (void)keyboardWillHid:(NSNotification *)info
{
    [UIView animateWithDuration:1 animations:^{
        
        self.view.frame =CGRectMake(0, 0,CGRectGetWidth(self.view.frame) ,CGRectGetHeight(self.view.frame));
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
    
}
#pragma mark    -MyHTTPRequestDelegate
- (void)requestFinsh:(NSDictionary *)dic
{
    NSLog(@"######################%@",dic);
    personDic = dic;
    
}

- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}



- (void)regButtonClick
{
//    NSURL *url = [NSURL URLWithString:REG];
//    NSString *string = [NSString stringWithFormat:@"email=%@&name=&password=%@",_logTextFild1.text,_logTextFild2.text];
//    NSString *textStr =[string stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    
 

}

- (void)logButtonClick
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(165, 245,34,34)];
    UIActivityIndicatorView *inc = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    inc.center = CGPointMake(17, 17);
    imageView.backgroundColor = [UIColor cyanColor];
    [imageView addSubview:inc];
    [self.view addSubview:imageView];
    [inc startAnimating];
    NSString *username = _logTextFild1.text;
    NSString *password = _logTextFild2.text;
    
    NSURL *url = [NSURL URLWithString:LOGIN];
    
    NSString *string = [NSString stringWithFormat:@"email=%@&password=%@",username,password];
    NSString *textStr =[string stringByReplacingOccurrencesOfString:@"@" withString:@"%40"];
    PersonVC *pVC = [[PersonVC alloc] init];
    MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request startPost:textStr];
    pVC.dic = personDic;
    NSString *str = NSHomeDirectory();
    NSLog(@"%@",str);
    //将token和用户名密码字符串保存到userdefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:username forKey:@"username"];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
    
    [self.navigationController pushViewController:pVC animated:YES];
    
    
    /*
    [self performSelector:@selector(buttonClcik) withObject:self afterDelay:(NSTimeInterval)];
    
    NSDate *now = [NSDate date];
    NSTimeInterval interval = [now timeIntervalSince1970];
    interval = [now timeIntervalSinceNow];//到当前时间的一个差值
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
    NSString *strs = @"2013年12月14日 16:31:08";
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    date1 = [dateFormatter dateFromString:strs];
     */
    
    
    
    
}
- (void)buttonClcik
{

}
- (void)textFieldDidEndEditing:(UITextField *)textField

{
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(300, 30, 70, 70);
        [button setImage:[UIImage imageNamed:@"IconItemSelected@3x.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(logButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];


    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{

    NSLog(@"%@",textField.text);

}


- (IBAction)backButton:(id)sender {
    
    [confirmButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (IBAction)loginClick:(UIButton *)sender {
    
    _scrollView.contentOffset = CGPointMake(0, 0);
    _changeImageVIew.frame = CGRectMake(0, 108, 187, 10);
    _loginButton.selected = YES;
    _registButton.selected = NO;
}
- (IBAction)registClick:(UIButton *)sender {
    
    _scrollView.contentOffset = CGPointMake(375, 0);
    _changeImageVIew.frame = CGRectMake(187, 108, 187, 10);
    _loginButton.selected = NO;
    _registButton.selected = YES;
    
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    currentPage = (NSInteger)scrollView.contentOffset.x/_scrollView.frame.size.width;
    NSLog(@"%ld",currentPage);
    _changeImageVIew.frame = CGRectMake(currentPage*187, 108, 187, 10);
    if (currentPage == 0) {
        _loginButton.selected = YES;
        _registButton.selected = NO;
        
        
    }
    if (currentPage == 1) {
        _loginButton.selected = NO;
        _registButton.selected = YES;
        
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
