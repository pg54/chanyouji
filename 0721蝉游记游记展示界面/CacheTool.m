//
//  CacheTool.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/28.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "CacheTool.h"
#import "FMDB.h"

@implementation CacheTool

static FMDatabaseQueue *_queue;
+ (void)initialize
{
    //获取沙盒中的数据库文件名
    NSString *path = NSHomeDirectory();
    NSLog(@"路径###################%@",path);
    NSString *filename = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"student.sqlite"];
    
    // 1.创建数据库队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:filename];
    
    // 2.创表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_student (id integer primary key autoincrement, idstr text, dict blob);"];
        
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }];

}

//+ (void)addTrips:(NSArray *)dictArray;
//{
//
//}

+ (void)addTrip:(NSDictionary *)dict andID:(NSString *)idstr
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_student (idstr,dict) values(?,?)",idstr,data];
    }];

}

+ (NSDictionary *)putoutwithID:(NSString *)idstr
{
    __block NSDictionary *dict = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_student where idstr = ?;",idstr];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"dict"];
            dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }];
    return dict;
    
    
    
}

@end
