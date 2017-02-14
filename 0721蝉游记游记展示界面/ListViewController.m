//
//  ListViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/1.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "ListViewController.h"
#import "MyHTTPRequest.h"
#import "RowModel.h"
#import "SectionModel.h"
#import "HomeViewController.h"
#import "Netinterface.h"



@interface ListViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate>
{
    NSMutableArray *overstateArray;
    NSMutableArray *demosticstateArray;
    UIScrollView *userScrollView;
    CGFloat width;
    CGFloat height;
    UITableView *overseaTableView;
    UITableView *demosticTableView;
    NSMutableArray *overSeaArray;
    NSMutableArray *demosticArray;
    NSInteger currentPage;
    NSArray *filterArry;
    NSInteger xNumber;
}

@end

@implementation ListViewController
- (IBAction)backButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    xNumber = 10;
    _changImage.frame = CGRectMake(0, 118, 187, 10);
    //初始化
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    overstateArray = [[NSMutableArray alloc] init];
    demosticstateArray = [[NSMutableArray alloc] init];
    userScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 118, width, height-118)];
    
    userScrollView.delegate = self;
    userScrollView.pagingEnabled = YES;
    userScrollView.contentSize = CGSizeMake(2*width, 0);
    userScrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:userScrollView];
    
    
    overseaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, userScrollView.frame.size.height)];
    overseaTableView.delegate = self;
    overseaTableView.dataSource = self;
    overseaTableView.showsVerticalScrollIndicator = NO;
    [overseaTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    overseaTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [userScrollView addSubview:overseaTableView];
    
    demosticTableView = [[UITableView alloc] initWithFrame:CGRectMake(width, 0, width, userScrollView.frame.size.height)];
    demosticTableView.dataSource = self;
    demosticTableView.delegate = self;
    demosticTableView.showsVerticalScrollIndicator = NO;
    [demosticTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    demosticTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [userScrollView addSubview:demosticTableView];
    
    [self getData:DESLIST];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}


- (void)getData:(NSString *)string
{
    NSLog(@"URL=================%@",string);
    NSURL *url = [NSURL URLWithString:string];
    MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
    
}

- (void)requestFinsh:(NSDictionary *)dic
{
    if (xNumber == 100) {
        xNumber = 10;
        HomeViewController *homeVC = [[HomeViewController alloc] init];
        homeVC.scrollView.contentOffset = CGPointMake(2*width, 0);
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else
    {
        NSArray *array = (NSArray *)dic;
        NSLog(@"array.count=============%ld",array.count);
        overSeaArray = [NSMutableArray array];
        for (NSDictionary *dic in array[0][@"destinations"]) {
            SectionModel *Smodel = [[SectionModel alloc] init];
            Smodel.ID = dic[@"id"];
            Smodel.name_zh_cn = dic[@"name_zh_cn"];
            Smodel.array = [NSMutableArray array];
            for (NSDictionary *dic1 in dic[@"children"]) {
                RowModel *model = [[RowModel alloc] init];
                model.ID = dic1[@"id"];
                model.name_zh_cn = dic1[@"name_zh_cn"];
                [Smodel.array addObject:model];
                NSLog(@"Smodel.array.count===========%ld",Smodel.array.count);
            }
            [overSeaArray addObject:Smodel];
            
        }
        for (NSDictionary *dic in array[1][@"destinations"]) {
            SectionModel *Smodel = [[SectionModel alloc] init];
            Smodel.ID = dic[@"id"];
            Smodel.name_zh_cn = dic[@"name_zh_cn"];
            Smodel.array = [NSMutableArray array];
            for (NSDictionary *dic1 in dic[@"children"]) {
                RowModel *model = [[RowModel alloc] init];
                model.ID = dic1[@"id"];
                model.name_zh_cn = dic1[@"name_zh_cn"];
                [Smodel.array addObject:model];
            }
            [overSeaArray addObject:Smodel];
        }
        for (int i=0; i<overSeaArray.count; i++) {
            //存储状态 全部展开
            [overstateArray addObject:[NSString stringWithFormat:@"0"]];
            
        }
        [overseaTableView reloadData];
        
        demosticArray = [NSMutableArray array];
        for (NSDictionary *dic in array[2][@"destinations"]) {
            SectionModel *Smodel = [[SectionModel alloc] init];
            Smodel.ID = dic[@"id"];
            Smodel.name_zh_cn = dic[@"name_zh_cn"];
            Smodel.array = [NSMutableArray array];
            for (NSDictionary *dic1 in dic[@"children"]) {
                RowModel *model = [[RowModel alloc] init];
                model.ID = dic1[@"id"];
                model.name_zh_cn = dic1[@"name_zh_cn"];
                [Smodel.array addObject:model];
            }
            [demosticArray addObject:Smodel];
        }
        for (NSDictionary *dic in array[3][@"destinations"]) {
            SectionModel *Smodel = [[SectionModel alloc] init];
            Smodel.ID = dic[@"id"];
            Smodel.name_zh_cn = dic[@"name_zh_cn"];
            Smodel.array = [NSMutableArray array];
            for (NSDictionary *dic1 in dic[@"children"]) {
                RowModel *model = [[RowModel alloc] init];
                model.ID = dic1[@"id"];
                model.name_zh_cn = dic1[@"name_zh_cn"];
                [Smodel.array addObject:model];
            }
            [demosticArray addObject:Smodel];
        }
        for (int i=0; i<demosticArray.count; i++) {
            //存储状态 全部展开
            [demosticstateArray addObject:[NSString stringWithFormat:@"0"]];
            
        }
        
        [demosticTableView reloadData];
    }
    
    
}

- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentPage = scrollView.contentOffset.x/width;
    _changImage.frame = CGRectMake(currentPage*187, 118, 187, 10);
    if (currentPage == 0) {
    }
    if (currentPage == 1) {
    }
}

#pragma mark    -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:overseaTableView]) {
        
        
        NSLog(@"overSeaArray.count================%ld",overSeaArray.count);
        return overSeaArray.count;
        
    }else
    {
        NSLog(@"demosticArray.count================%ld",demosticArray.count);
        return demosticArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:overseaTableView]) {
        if ([overstateArray[section] isEqualToString:@"1"]) {
            SectionModel *Smodel = overSeaArray[section];
            return Smodel.array.count;
        }else
        {
            return 0;
        }
        
    }else
    {
        if ([demosticstateArray[section] isEqualToString:@"1"]) {
            SectionModel *Smodel = demosticArray[section];
            return Smodel.array.count;
        }else
        {
            return 0;
        }
        
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:overseaTableView]) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        SectionModel *model = overSeaArray[section];
        label.text = model.name_zh_cn;
        [view addSubview:label];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000+section;
        [view addSubview:button];
        return view;
    }else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
        SectionModel *model = demosticArray[section];
        label.text = model.name_zh_cn;
        [view addSubview:label];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 2000+section;
        [view addSubview:button];
        return view;
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:overseaTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        //if ([overstateArray[indexPath.section] isEqualToString:@"1"]) {
        SectionModel *Smodel = overSeaArray[indexPath.section];
        RowModel *model = Smodel.array[indexPath.row];
        cell.textLabel.text = model.name_zh_cn;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        //}
        
        return cell;
    }
    if ([tableView isEqual:demosticTableView]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        NSLog(@"%ld",indexPath.section);
        //if ([demosticstateArray[indexPath.section] isEqualToString:@"1"]) {
        SectionModel *Smodel = demosticArray[indexPath.section];
        RowModel *model = Smodel.array[indexPath.row];
        cell.textLabel.text = model.name_zh_cn;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        //}
        
        return cell;
        
    }
    return nil;
    
    
}

- (void)buttonClick:(UIButton *)sender
{
    if (sender.tag >= 2000) {
        if ([demosticstateArray[sender.tag-2000]isEqualToString:@"0"]) {
            [demosticstateArray replaceObjectAtIndex:sender.tag -2000 withObject:@"1"];
            
        }else
        {
            [demosticstateArray replaceObjectAtIndex:sender.tag -2000 withObject:@"0"];
            
        }
        [demosticTableView reloadData];
        
    }else
    {
        if ([overstateArray[sender.tag-1000]isEqualToString:@"0"]) {
            [overstateArray replaceObjectAtIndex:sender.tag -1000 withObject:@"1"];
            
        }else
        {
            [overstateArray replaceObjectAtIndex:sender.tag -1000 withObject:@"0"];
            
        }
        [overseaTableView reloadData];
        //        [overseaTableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1000] withRowAnimation:YES];
        
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:overseaTableView]) {
        SectionModel *sModel = overSeaArray[indexPath.section];
        RowModel *model = sModel.array[indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"haveSite"];
        [userDefaults setObject:model.ID forKey:@"haveSite"];
        [userDefaults synchronize];
    }else
    {
        SectionModel *sModel = demosticArray[indexPath.section];
        RowModel *model = sModel.array[indexPath.row];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults removeObjectForKey:@"haveSite"];
        
        [userDefaults setObject:model.ID forKey:@"haveSite"];
        
        
        
        [userDefaults synchronize];
        
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