//
//  searchListViewController.m
//  0707 蝉游记
//
//  Created by pangang on 15/7/18.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "searchListViewController.h"
#import "Netinterface.h"
#import "MyHTTPRequest.h"
#import "tripCell.h"
#import "HomeModel.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "describeTripViewController.h"
#import "CacheTool.h"


@interface searchListViewController ()<MyHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,MJRefreshBaseViewDelegate>
{
    UITableView *userTableView;
    NSMutableArray *dataSourceArray;
    MJRefreshBaseView *baseView;
    MJRefreshHeaderView *headerView;
    MJRefreshFooterView *footView;
    NSInteger index;
    NSMutableString *pageStr;
    UITableView *seasonTabelView;
    UITableView *popularTabelView;
    NSArray *seasonArray;
    NSArray *popularArray;
    BOOL seasonclcik;
    BOOL popularclcik;
}


@end

@implementation searchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    seasonclcik = NO;
    popularclcik = NO;
    seasonArray = [NSArray arrayWithObjects:@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月", nil];
    popularArray = [NSArray arrayWithObjects:@"人气",@"最新", nil];
    dataSourceArray = [NSMutableArray array];
    _titleLabel.text = _labelStr;
    userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-108)];
    [userTableView registerNib:[UINib nibWithNibName:@"tripCell" bundle:nil] forCellReuseIdentifier:@"tCell"];
    userTableView.dataSource = self;
    userTableView.delegate = self;
    userTableView.rowHeight = 232;
    [self.view addSubview:userTableView];
    [self getData:_URLString];
    [self initHeaderViewAndFootView:userTableView];
    index = 1;
    
    
    // Do any additional setup after loading the view from its nib.
}
#pragma mark    -MJRefreshBaseViewDelegate
- (void)initHeaderViewAndFootView:(UITableView *)tableView
{
    
    headerView = [[MJRefreshHeaderView alloc]initWithScrollView:tableView];
    headerView.delegate = self;
    footView = [[MJRefreshFooterView alloc]initWithScrollView:tableView];
    footView.delegate = self;
}
-(void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    baseView = refreshView;
    if (refreshView == headerView) {
        [dataSourceArray removeAllObjects];
        index = 1;
        
    }
    
    if (refreshView == footView) {
        index++;
    }
    pageStr = [[NSMutableString alloc]init];
    pageStr = [NSMutableString stringWithString:_URLString];
    
    [pageStr replaceCharactersInRange:NSMakeRange(58, 1) withString:@"%ld"];
    [self getData:[NSString stringWithFormat:pageStr,index]];
    [userTableView reloadData];
    
    
}

- (IBAction)seasonClick:(UIButton *)sender {
    if (seasonclcik == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            
        } completion:^(BOOL finished) {
            seasonTabelView = [[UITableView alloc] initWithFrame:CGRectMake(235, 110, 60, 350)];
            seasonTabelView.delegate = self;
            seasonTabelView.dataSource = self;
            [self.view addSubview:seasonTabelView];
            seasonclcik = YES;
        }];
    }
    if (seasonclcik == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            
        } completion:^(BOOL finished) {
            [seasonTabelView removeFromSuperview];
            seasonclcik = NO;
        }];
    }
    
    
}
- (IBAction)popularClick:(UIButton *)sender {
    if (popularclcik == NO) {
        [UIView animateWithDuration:0.5 animations:^{
            
        } completion:^(BOOL finished) {
            popularTabelView = [[UITableView alloc] initWithFrame:CGRectMake(301, 110, 60, 80)];
            seasonTabelView.delegate = self;
            seasonTabelView.dataSource = self;
            [self.view addSubview:popularTabelView];
            popularclcik = YES;
        }];
    }
    if (popularclcik == YES) {
        [UIView animateWithDuration:0.5 animations:^{
            
        } completion:^(BOOL finished) {
            [popularTabelView removeFromSuperview];
            popularclcik = NO;
        }];
    }
}

- (IBAction)backClick:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)getData:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    MyHTTPRequest *myHTTPRequest = [[MyHTTPRequest alloc]initWithURL:url];
    myHTTPRequest.delegate = self;
    [myHTTPRequest startAsynchronous];
    
}

- (void)requestFinsh:(NSDictionary *)dic
{
    for (NSDictionary *firstDic in dic)
    {
        HomeModel *model = [[HomeModel alloc]init];
        NSString *str1 = firstDic[@"front_cover_photo_url"];
        model.frontCoverPhotoUrl  = str1;
        model.name = firstDic[@"name"];
        model.startDate = firstDic[@"start_date"];
        
        model.days = firstDic[@"days"];
        model.photoCount = firstDic[@"photos_count"];
        NSString *str = firstDic[@"user"][@"image"];
        model.image = str;
        //NSLog(@"%@",str);
        model.tripDescribeID = firstDic[@"id"];
        
        [dataSourceArray addObject:model];
        
    }
    if (headerView == baseView) {
        [headerView endRefreshing];
    }
    if (footView == baseView) {
        [footView endRefreshing];
    }
    [userTableView reloadData];
    

}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

#pragma mark    -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:seasonTabelView]) {
        return seasonArray.count;
    }
    if ([tableView isEqual:popularTabelView]) {
        return popularArray.count;
    }
    if ([tableView isEqual:userTableView]) {
        return dataSourceArray.count;
    }
    return 0;
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:seasonTabelView]) {
        
        UITableViewCell *tableviewCell = [[UITableViewCell alloc] init];
        tableviewCell.textLabel.text = seasonArray[indexPath.row];
        tableviewCell.textLabel.font = [UIFont systemFontOfSize:12];
        return tableviewCell;
    }
    if ([tableView isEqual:userTableView]) {
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
    if ([tableView isEqual:popularTabelView]) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = popularArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        return cell;
    }
    return nil;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:userTableView]) {
        describeTripViewController *describeVC = [[describeTripViewController alloc]init];
        HomeModel *model = dataSourceArray[indexPath.row];
        
        describeVC.URLString = [NSString stringWithFormat:tripDescribe,model.tripDescribeID];
        describeVC.tableHeadURL = model.frontCoverPhotoUrl;
        
        [self.navigationController pushViewController:describeVC animated:YES];
    }
    if ([tableView isEqual:seasonTabelView]) {
        for (HomeModel *model in dataSourceArray) {
            NSInteger num = [self getInteger:model.startDate];
            if (num != indexPath.row) {
                [dataSourceArray removeObject:model];
            }
        }
        [userTableView reloadData];
        
        
        
    }
    
    
}

- (NSInteger)getInteger:(NSString *)str
{
    NSRange r1 = {5,2};
    NSString *str1 = [str substringWithRange:r1];
    NSLog(@"%ld",[str1 integerValue]);
   return [str1 integerValue];

}

- (void)dealloc
{
    [headerView free];
    [footView free];
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
