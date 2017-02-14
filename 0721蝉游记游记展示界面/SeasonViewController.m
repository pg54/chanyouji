//
//  SeasonViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/7/31.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "SeasonViewController.h"
#import "HomeModel.h"
#import "tripCell.h"
#import "MyHTTPRequest.h"
#import "CacheTool.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "describeTripViewController.h"
#import "Netinterface.h"
#import "describeTripViewController.h"

@interface SeasonViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *userTableView;
    NSMutableArray *dataSourceArray;
    MJRefreshBaseView *baseView;
    MJRefreshFooterView *footerView;
    MJRefreshHeaderView *headerView;
    NSInteger index;

}

@end

@implementation SeasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init
    index = 1;
    _descriLabel.text = _labelStr;
    dataSourceArray = [[NSMutableArray alloc] init];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height-64)];
    userTableView.delegate = self;
    userTableView.dataSource = self;
    [self.view addSubview:userTableView];
    [self initHeaderViewAndFootView:userTableView];
    [userTableView registerNib:[UINib nibWithNibName:@"tripCell" bundle:nil] forCellReuseIdentifier:@"tCell"];
    
    
    
    
    [self getData:_urlString];
    
    
    //
    // Do any additional setup after loading the view from its nib.
}
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{

    baseView = refreshView;
    if (dataSourceArray.count > 0) {
        [dataSourceArray removeAllObjects];
        index = 1;
    }else
    {
        index++;
    }
    [_urlString stringByReplacingOccurrencesOfString:@"=1" withString:@"%ld"];
    NSString *str = [NSString stringWithFormat:_urlString,index];
    [self getData:str];
    [userTableView reloadData];
    
}
- (void)initHeaderViewAndFootView:(UITableView *)tableView
{
    
    headerView = [[MJRefreshHeaderView alloc]initWithScrollView:tableView];
    headerView.delegate = self;
    footerView = [[MJRefreshFooterView alloc]initWithScrollView:tableView];
    footerView.delegate = self;
    
}
- (void)getData:(NSString *)str
{
    NSDictionary *dic = [CacheTool putoutwithID:_urlString];
    if (dic) {
        [self serializingWith:dic];
        
    }else
    {
        NSURL *url = [NSURL URLWithString:_urlString];
        MyHTTPRequest *myHTTPRequest = [[MyHTTPRequest alloc] initWithURL:url];
        myHTTPRequest.delegate = self;
        [myHTTPRequest startAsynchronous];
    
    }
    

}
- (void)requestFinsh:(NSDictionary *)dic
{

    NSLog(@"%@",dic);
    [self serializingWith:dic];
    [CacheTool addTrip:dic andID:_urlString];
    
}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

- (void)serializingWith:(NSDictionary *)dic
{
    for (NSDictionary *firstDic in dic) {
        HomeModel *model = [[HomeModel alloc]init];
        NSString *str1 = firstDic[@"front_cover_photo_url"];
        model.frontCoverPhotoUrl  = str1;
        model.name = firstDic[@"name"];
        model.startDate = firstDic[@"start_date"];
        
        model.days = firstDic[@"days"];
        model.photoCount = firstDic[@"photos_count"];
        NSString *str = firstDic[@"user"][@"image"];
        model.image = str;
        model.tripDescribeID = firstDic[@"id"];
        
        [dataSourceArray addObject:model];

        
    }
    if (headerView==baseView) {
        
        [headerView endRefreshing];
    }
    if (footerView==baseView) {
        
        [footerView endRefreshing];
    }
    [userTableView reloadData];

}
#pragma mark    -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSourceArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tripCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tCell"];
    HomeModel *model = dataSourceArray[indexPath.row];
    cell.nameLabel.text = model.name;
    
    NSString *str1 = model.startDate;
    NSString *str2 = model.days;
    NSString *str3 = model.photoCount;
    
    cell.detailLabel.text = [NSString stringWithFormat:@"%@/%@天, %@图",str1,str2,str3];
    [cell.frontImage sd_setImageWithURL:[NSURL URLWithString:model.frontCoverPhotoUrl]];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    describeTripViewController *desVC = [[describeTripViewController alloc] init];
    HomeModel *model = dataSourceArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:tripDescribe,model.tripDescribeID];
    desVC.tableHeadURL = model.frontCoverPhotoUrl;
    desVC.URLString = str;
    [self.navigationController pushViewController:desVC animated:YES];
}


#pragma mark    -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 232;
}

- (IBAction)backButton:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    [footerView free];
    [headerView free];
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
