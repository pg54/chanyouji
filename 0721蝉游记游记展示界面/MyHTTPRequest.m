//
//  MyHTTPRequest.m
//  MyHTTPRequest
//
//  Created by Mouse on 15/6/25.
//  Copyright (c) 2015年 新果教育. All rights reserved.
//

#import "MyHTTPRequest.h"




@implementation MyHTTPRequest
{
    NSURL *_url;
    NSMutableData *_data;
}


-(NSMutableData *)responseData
{
    return _data;

}

//发出网络请求
+(id)requestWithURL:(NSURL *)URL
{
    
    MyHTTPRequest *request =[[MyHTTPRequest alloc]initWithURL:URL];

    return request;
}



-(id)initWithURL:(NSURL*)URL
{
    self =[super init];
    if (self) {
        _url =URL;
        
        _data =[[NSMutableData alloc]init];
        
    }
    return self;
}

-(void)startAsynchronous
{
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:_url];
    [request setHTTPMethod:@"GET"];
    

    [NSURLConnection connectionWithRequest:request delegate:self];


}

- (void)startPost:(NSString *)textStr
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:_url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [textStr dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection connectionWithRequest:request delegate:self];
}


#pragma mark - NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response

{
    
    
}


- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection{
    
    return NO;
    
}

//要服务器端单项HTTPS 验证，iOS 客户端忽略证书验证。

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    NSLog(@"didReceiveAuthenticationChallenge %@ %zd", [[challenge protectionSpace] authenticationMethod], (ssize_t) [challenge previousFailureCount]);
    
    
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        
        [[challenge sender]  useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        
        [[challenge sender]  continueWithoutCredentialForAuthenticationChallenge: challenge];
        
    }
    NSLog(@"get the whole response");
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableLeaves error:nil];    
    if (_delegate && [_delegate respondsToSelector:@selector(requestFinsh:)]) {
        
        [_delegate requestFinsh:dic];
        
    }

}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error
{
    
    NSString *str = @"出错了";
    if (_delegate &&[_delegate respondsToSelector:@selector(requestFailed:)]) {
        
        [_delegate requestFailed:str];
        
    }
    

}


@end
