//
//  describeTripViewController.m
//  0707 蝉游记
//
//  Created by pangang on 15/7/16.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "describeTripViewController.h"
#import "Netinterface.h"
#import "MyHTTPRequest.h"
#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
#import "StatusFrame.h"
#import "CacheTool.h"
#import <Mantle.h>
#import "Amodel.h"
#import "Bmodel.h"
#import "Cmodel.h"
#import "Photo.h"

@interface describeTripViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate>
{
    NSArray *dataSourceArray;
    NSArray *bArray;
    NSArray *cArray;
    UIView *popView;
    UIView *assistPopView;
    UITableView *generalTableView;
    NSMutableArray *Arr;
}

@end

@implementation describeTripViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    dataSourceArray = [[NSArray alloc]init];
    bArray = [NSArray array];
    cArray = [NSArray array];
    [self getData:_URLString];
    _userTableView.dataSource = self;
    _userTableView.delegate = self;
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 232)];
    _userTableView.tableHeaderView = headerView;
    UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, headerView.frame.size.height)];
    [headerView addSubview:headImageView];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:_tableHeadURL]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 600, 50, 55);
    UIImage *image = [UIImage imageNamed:@"OutlineButtonHighlight@3x"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self setpop];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setpop
{
    popView = [[UIView alloc]initWithFrame:CGRectMake(-200, 108, 200, 559)];
    popView.backgroundColor = [UIColor blackColor];
    popView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.83];
    [self.view addSubview:popView];
    //在popview 设置单元格   label   button
    UILabel *generalLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 0, 64, 44)];
    generalLabel.text = @"行程概况";
    generalLabel.font = [UIFont systemFontOfSize:15];
    generalLabel.textColor = [UIColor whiteColor];
    [popView addSubview:generalLabel];
    //加一个tableview
    generalTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, popView.frame.size.width, popView.frame.size.height-44)];
    [generalTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    generalTableView.dataSource = self;
    generalTableView.delegate = self;
    [popView addSubview:generalTableView];
    
    UIButton *mapButton = [[UIButton alloc]initWithFrame:CGRectMake(136,0,64, 44)];
    [mapButton setTitle:@"地图模式" forState:UIControlStateNormal];
    [mapButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [mapButton setFont:[UIFont systemFontOfSize:15]];
    mapButton.selected = YES;
    [popView addSubview:mapButton];
    assistPopView = [[UIView alloc]initWithFrame:CGRectMake(550, 108, 175, 559)];
    assistPopView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clear)];
    [assistPopView addGestureRecognizer:tap];
    [self.view addSubview:assistPopView];
    

}
- (void)popButton
{
    popView.frame = CGRectMake(0, 108, 200, 559);
    assistPopView.frame = CGRectMake(200, 108, 175, 559);
    


}

- (void)clear
{
    popView.frame = CGRectMake(-200, 0, 200, 559);
    assistPopView.frame = CGRectMake(-175, 108, 175, 559);
    
    
}


- (void)getData:(NSString *)str
{
   NSDictionary *dict = [CacheTool putoutwithID:_URLString];
    if (dict) {
        NSArray *array = dict[@"trip_days"];
        dataSourceArray = [MTLJSONAdapter modelsOfClass:[Amodel class] fromJSONArray:array error:nil];
        
        [_userTableView reloadData];
    }else
    {
        NSURL *url = [NSURL URLWithString:_URLString];
        MyHTTPRequest *myRequest = [[MyHTTPRequest alloc]initWithURL:url];
        myRequest.delegate = self;
        [myRequest startAsynchronous];
    }

}


- (void)requestFinsh:(NSDictionary *)dic
{
    [CacheTool addTrip:dic andID:_URLString];
    NSArray *array = (NSArray *)dic[@"trip_days"];
    dataSourceArray = [MTLJSONAdapter modelsOfClass:[Amodel class] fromJSONArray:array error:nil];
    [_userTableView reloadData];
    
}


- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

#pragma mark    -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_userTableView]) {
        return dataSourceArray.count;
    }else
    {
        return dataSourceArray.count;
    }
        
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:_userTableView]) {
        Amodel *aModel = dataSourceArray[section];
        NSInteger j = 0;
        NSArray *array1 = aModel.nodes;
        for (int i = 0 ; i < array1.count; i++) {
            Bmodel *bModel = array1[i];
            NSArray *array2 = bModel.notes;
            j += array2.count;
        }
        return j;
    }else
    {
        Amodel *aModel = dataSourceArray[section];
        return aModel.nodes.count;
    
    }
    
    

    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_userTableView]) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"describeCell"];
        if (cell == nil) {
            cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"describeCell"];
        }
        StatusFrame *statusFrame = [[StatusFrame alloc]init];
        Amodel *aModel = dataSourceArray[indexPath.section];
        NSMutableArray *a2 = [NSMutableArray array];
        NSArray *array1 = aModel.nodes;
        for (int i = 0 ; i < array1.count; i++) {
            Bmodel *bModel = array1[i];
            NSArray *array2 = bModel.notes;
            for (int j = 0; j < array2.count; j++ ) {
                Cmodel *cModel = array2[j];
                
                [a2 addObject:cModel];
            }
        }
        Cmodel *cModel = a2[indexPath.row];
        statusFrame.cModel = cModel;
        cell.statusFrame = statusFrame;
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        Amodel *aModel = dataSourceArray[indexPath.section];
        Bmodel *bModel = aModel.nodes[indexPath.row];
        cell.textLabel.text = bModel.entry_name;
        NSLog(@"bModel.entry_name===========%@",bModel.entry_name);
        return cell;
        
        
    }

    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_userTableView]) {
        StatusFrame *statusFrame = [[StatusFrame alloc]init];
        Amodel *aModel = dataSourceArray[indexPath.section];
        NSMutableArray *a2 = [NSMutableArray array];
        NSArray *array1 = aModel.nodes;
        for (int i = 0 ; i < array1.count; i++) {
            Bmodel *bModel = array1[i];
            NSArray *array2 = bModel.notes;
            for (int j = 0; j < array2.count; j++ ) {
                Cmodel *cModel = array2[j];
                if (j == 0) {
                    cModel.upName = bModel.entry_name;
                    cModel.downName = nil;
                }else
                {
                    cModel.upName = nil;
                    cModel.downName = bModel.entry_name;
                    
                }
                [a2 addObject:cModel];
            }
        }
        Cmodel *cModel = a2[indexPath.row];
        statusFrame.totalHeight = 0;
        statusFrame.cModel = cModel;
        return statusFrame.cellHeight;
    }else
    {
        return 60;
    
    }
    
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_userTableView]) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
        UILabel *maxLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headView.frame.size.width/4, headView.frame.size.height)];
        UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(headView.frame.size.width/4, 0, headView.frame.size.width*3/4, headView.frame.size.height)];
        Amodel *aModel = dataSourceArray[section];
        maxLabel.text = [NSString stringWithFormat:@"DAY%@",aModel.day];
        minLabel.text = aModel.trip_date;
        minLabel.font = [UIFont systemFontOfSize:12];
        [headView addSubview:minLabel];
        [headView addSubview:maxLabel];
        return headView;
    }else
    {
        UIView *generalHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, popView.frame.size.width, 30)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, generalHeadView.frame.size.width/2, generalHeadView.frame.size.height)];
        Amodel *aModel = dataSourceArray[section];
        
        label.text = [NSString stringWithFormat:@"%ld",[aModel.day integerValue]];
        label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor blackColor];
        [generalHeadView addSubview:label];
        return generalHeadView;
        
        
    }
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //保存拖动的长度 下次加载到此处
    NSInteger chang = scrollView.contentOffset.y;
    NSLog(@"chang===================%ld",chang);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:chang forKey:@"offset"];
    [userDefaults synchronize];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:generalTableView]) {
        Amodel *aModel = dataSourceArray[indexPath.section];
        Bmodel *bModel = aModel.nodes[indexPath.row];
//        //使用kvo
//        StatusFrame *stafusF = [[StatusFrame alloc] init];
//        NSLog(@"%@",cel.heightArray);
        
    }
}







//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 44;
//}




- (IBAction)backButton:(UIButton *)sender {
    
    [popView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
