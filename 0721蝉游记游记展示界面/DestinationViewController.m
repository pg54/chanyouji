//
//  DestinationViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/2.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "DestinationViewController.h"
#import "MyHTTPRequest.h"
#import "DESCell.h"
#import <Mantle.h>
#import "DESModel.h"
#import "UIImageView+WebCache.h"
#import "describeTripViewController.h"
#import "Netinterface.h"
#import "MJRefresh.h"




@interface DestinationViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *userTableView;
    CGFloat width;
    CGFloat height;
    NSInteger index;
    NSArray *dataSourceArray;
    NSMutableArray *maxArray;
    MJRefreshBaseView *baseView;
    MJRefreshFooterView *footerView;
    MJRefreshHeaderView *headerView;
    

}

@end

@implementation DestinationViewController
- (IBAction)backButton:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    index = 1;
    maxArray = [NSMutableArray array];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height-64)];
    userTableView.delegate = self;
    userTableView.dataSource = self;
    [self.view addSubview:userTableView];
    [userTableView registerNib:[UINib nibWithNibName:@"DESCell" bundle:nil] forCellReuseIdentifier:@"ddCell"];
    headerView = [[MJRefreshHeaderView alloc] initWithScrollView:userTableView];
    headerView.delegate = self;
    footerView = [[MJRefreshFooterView alloc] initWithScrollView:userTableView];
    footerView.delegate = self;
    [self getData];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    baseView = refreshView;
    if (baseView == headerView) {
        if (maxArray.count > 0) {
            [maxArray removeAllObjects];
            index = 1;
            
        }
    }else
    {
        index++;
    
    }
    [self getData];
    [userTableView reloadData];
    

}

- (void)getData
{
    
    NSString *str1 = [NSString stringWithFormat:@"%ld",index];
    NSString *str = [_URLString stringByAppendingString:str1];
    NSURL *url = [NSURL URLWithString:str];
    MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request startAsynchronous];

}

- (void)requestFinsh:(NSDictionary *)dic
{
    [self serializingWith:dic];
    
}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);

}

- (void)serializingWith:(NSDictionary *)dic
{
    NSArray *array = (NSArray *)dic;
    dataSourceArray = [MTLJSONAdapter modelsOfClass:[DESModel class] fromJSONArray:array error:nil];
    NSMutableArray *arr = [dataSourceArray mutableCopy];
    for (int i = 0; i < arr.count; i++) {
        [maxArray addObject:arr[i]];
    }
    if (headerView == baseView) {
        [headerView endRefreshing];
    }
    if (footerView == baseView) {
        [footerView endRefreshing];
    }
    
    [userTableView reloadData];

}

#pragma mark    -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"maxArray.count===========%ld",maxArray.count);
    return maxArray.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DESCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ddCell"];
    DESModel *model = maxArray[indexPath.row];
    [cell.frontImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    NSInteger num = [model.attraction_trips_count integerValue];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:14]];
    cell.desCountLabel.text = [NSString stringWithFormat:@"%ld篇游记",num];
    cell.titleLabel.text = model.name;
    cell.describeLabel.text = model.description_summary;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DESModel *model = maxArray[indexPath.row];
    describeTripViewController *describeVC = [[describeTripViewController alloc] init];
    NSString *str = [NSString stringWithFormat:tripDescribe,model.ID];
    describeVC.URLString = str;
    [self.navigationController pushViewController:describeVC animated:YES];
    
}

#pragma mark    -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [headerView free];
    [footerView free];
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
