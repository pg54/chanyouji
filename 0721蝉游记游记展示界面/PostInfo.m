//
//  PostInfo.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/29.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "PostInfo.h"

@implementation PostInfo
// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self) {
        randomIDStr = @"pangang";
        uploadID = @"uplaodFile";
    }
    return self;
    
}

#pragma mark    -私有方法

- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (void)uploadFileWithURL:(NSURL *)url Data:(NSData *)data;
{
    
    
    //数据体
    NSString *topStr = [self topStringWithMimeType:@"image/jpg" uploadFile:@"uploadFile"];
    NSString *bottomStr = [self bottomString];
    
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    //设置request的头属性
    request.HTTPBody = dataM;
    request.HTTPMethod = @"POST";
    
    NSString *strLength = [NSString stringWithFormat:@"%ld",(long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    
    //连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
    }];
    
    
    
}


@end
