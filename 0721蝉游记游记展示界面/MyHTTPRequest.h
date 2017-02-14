//
//  MyHTTPRequest.h
//  MyHTTPRequest
//
//  Created by Mouse on 15/6/25.
//  Copyright (c) 2015年 新果教育. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyHTTPRequest;
@protocol MyHTTPRequestDelegate <NSObject>


-(void)requestFinsh:(NSDictionary *)dic;

-(void)requestFailed:(NSString*)str;

@end
@interface MyHTTPRequest : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,weak)id<MyHTTPRequestDelegate>delegate;

@property(nonatomic,assign)NSInteger tag;

+(id)requestWithURL:(NSURL *)URL;
-(id)initWithURL:(NSURL*)URL;
-(void)startAsynchronous;
- (void)startPost:(NSString *)textStr;

-(NSMutableData *)responseData;



@end
