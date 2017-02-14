//
//  HomeViewController.m
//  0707 蝉游记
//
//  Created by pangang on 15/7/10.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "HomeViewController.h"
#import "Netinterface.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"
#import "tripCell.h"
#import "MyHTTPRequest.h"
#import "searchViewController.h"
#import "MJRefresh.h"
#import "destinationModel.h"
#import "CollectionViewCell.h"
#import "describeTripViewController.h"
#import "LoginRegist.h"
#import "UIImageView+WebCache.h"
#import "PlanViewController.h"
#import "CacheTool.h"
#import "PersonVC.h"
#import "ListViewController.h"
#import <Mantle.h>
#import "SiteModel.h"
#import "NoralSetViewController.h"
#import "ReadViewController.h"
#import "ProposalViewController.h"
#import "BoxView.h"







@interface HomeViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate,MJRefreshBaseViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,jumpDelegate>
{
    UITableView *tripTableView;
    UICollectionView *destinationCollectionView;
    UIView *toolBoxView;
    NSMutableArray *dataSourceArray;
    NSArray *desArray;
    NSMutableArray *destinationDataSourceArray;
    NSInteger currentPage;
    int width ;
    int height;
    int index;
    int artIndex;
    int xNumber;
    MJRefreshBaseView *baseView;
    MJRefreshHeaderView *headerView;
    MJRefreshFooterView *footView;
    BOOL more;
    UIView *popView;
    UIView *assistPopView;
    NSArray *moreButtonArray;
    UIView *siteView;
    NSString *tripURL;
    NSString *desURL;
    NSMutableArray *identifierArray;
    NSDictionary *boxDic;
    
    
}

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    xNumber = 10;
    more = NO;
    index = 1;
    moreButtonArray = [NSArray arrayWithObjects:@"离线浏览",@"反馈",@"设置", nil];
    desArray = [NSMutableArray arrayWithObjects:@"国外-亚洲",@"国外-欧洲",@"美洲、大洋洲、非洲与南极洲",@"国内-港澳台",@"国内-大陆", nil];
    identifierArray = [NSMutableArray arrayWithObjects:@"head1",@"head2",@"head3",@"head4",@"head5", nil];
    destinationDataSourceArray = [[NSMutableArray alloc]init];
    dataSourceArray = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.hidden = YES;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, self.view.frame.size.height-118)];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = YES;
    [self.view addSubview:_scrollView];
    
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = _scrollView.frame.size.height;
    [_tripButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_articlesButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_distinationButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    
    _scrollView.contentOffset = CGPointMake(0, 0);
    _scrollView.contentSize = CGSizeMake(3*width, 0);
    _scrollView.delegate = self;
    //
    popView = [[UIView alloc]initWithFrame:CGRectMake(width*3/2, 64, width/2 , 132)];
    popView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:popView];
    UITableView *moreTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, popView.frame.size.width, popView.frame.size.height)];
    moreTabelView.delegate = self;
    moreTabelView.dataSource = self;
    [moreTabelView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"cell"];
    [popView addSubview:moreTabelView];
    
    assistPopView = [[UIView alloc]initWithFrame:CGRectMake(width/2, height, width/2 , height-196)];
    assistPopView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clear)];
    [assistPopView addGestureRecognizer:tap];
    [self.view addSubview:assistPopView];
    
    
    //1 获取数据
    [self tripGetData];
    [self desGetData];
    [self initThreeView];
    
    //2 创建界面
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)moreClick:(UIButton *)sender {
    if (more == NO) {
        //设置弹出区域，和触摸区域
        popView.frame = CGRectMake(width/2, 64, width/2 , 132);
        assistPopView.frame = CGRectMake(width/2, 196, width/2 , height-196);
        more = !more;
    }else
    {
        popView.frame = CGRectMake(width*3/2, 64, width/2 , 132);
        assistPopView.frame = CGRectMake(width/2, height, width/2 , height-196);
        more = !more;
        
    }
}

- (void)clear
{
    popView.frame = CGRectMake(width*3/2, 64, width/2 , 132);
    assistPopView.frame = CGRectMake(width/2, height, width/2 , height-196);
    more = !more;
}

-(void)tripGetData
{
    tripURL = [NSString stringWithFormat:trip,index];
    NSDictionary *dict = [CacheTool putoutwithID:tripURL];
    if (dict) {
        [self serializingWith:dict];
    }else
    {
        NSURL *url = [NSURL URLWithString:tripURL];
        MyHTTPRequest *myHTTPRequest = [[MyHTTPRequest alloc]initWithURL:url];
        myHTTPRequest.delegate = self;
        [myHTTPRequest startAsynchronous];
        
    }
    
}

- (void)desGetData
{
    desURL = destination;
    NSDictionary *dict = [CacheTool putoutwithID:desURL];
    if (dict) {
        [self serializingWith:dict];
        
    }else
    {
        NSURL *url = [NSURL URLWithString:desURL];
        MyHTTPRequest *myHTTPRequest = [[MyHTTPRequest alloc]initWithURL:url];
        myHTTPRequest.delegate = self;
        [myHTTPRequest startAsynchronous];
        
    }
    
    
}
- (void)requestFinsh:(NSDictionary *)dic
{
    if (xNumber == 100) {
        NSLog(@"dic=========%@",dic);
        _boxView.dict = dic;
        xNumber = 10;
        
    }
    if (dic.count == 10) {
        [CacheTool addTrip:dic andID:tripURL];
        [self serializingWith:dic];
    }
    if (dic.count == 5) {
        [CacheTool addTrip:dic andID:desURL];
        [self serializingWith:dic];
    }
    
}

- (void)serializingWith:(NSDictionary *)dic
{
    if (dic.count == 10) {
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
            NSLog(@"%@",firstDic[@"id"]);
            
            [dataSourceArray addObject:model];
            
        }
        
        if (headerView==baseView) {
            
            [headerView endRefreshing];
        }
        if (footView==baseView) {
            
            [footView endRefreshing];
        }
        
        [tripTableView reloadData];
        
    }
    if (dic.count == 5) {
        for (NSDictionary *thridDic in dic)
        {
            NSMutableArray *modelArray = [NSMutableArray array];
            for (NSDictionary *minDic in thridDic[@"destinations"]) {
                destinationModel *model = [[destinationModel alloc]init];
                model.ID = minDic[@"id"];
                model.countryStr = minDic[@"name_zh_cn"];
                model.englishStr = minDic[@"name_en"];
                model.countStr = minDic[@"poi_count"];
                model.imageStr = minDic[@"image_url"];
                [modelArray addObject:model];
            }
            [destinationDataSourceArray addObject:modelArray];
            
        }
        [destinationCollectionView reloadData];
        
    }
    
    
}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
}

- (void)initThreeView
{
    //游记界面
    tripTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    
    tripTableView.rowHeight = 232;
    [tripTableView registerNib:[UINib nibWithNibName:@"tripCell" bundle:nil] forCellReuseIdentifier:@"tCell"];
    tripTableView.dataSource = self;
    tripTableView.delegate = self;
    [_scrollView addSubview:tripTableView];
    [self initHeaderViewAndFootView:tripTableView];
    
    //目的地界面
    UICollectionViewFlowLayout *gird = [[UICollectionViewFlowLayout alloc]init];
    gird.itemSize = CGSizeMake(170, 220);
    gird.minimumInteritemSpacing = 5;
    gird.minimumLineSpacing = 10;
    gird.sectionInset = UIEdgeInsetsMake(5, 15, 0, 15);
    
    destinationCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(width,0,width,height)
                                                  collectionViewLayout:gird];
    destinationCollectionView.backgroundColor = [UIColor whiteColor];
    
    destinationCollectionView.delegate = self;
    destinationCollectionView.dataSource = self;
    [destinationCollectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil]forCellWithReuseIdentifier:@"desCell"];
    for (int i = 0; i<5; i++) {
        [destinationCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierArray[i]];
    }
    
    [_scrollView addSubview:destinationCollectionView];
    //工具箱页面
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self boxReload];
    
}

- (void)boxReload
{
    NSString *siteURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"haveSite"];
    NSLog(@"###########################%@",siteURL);
    if (siteURL != nil) {
        _boxView = [BoxView appear];
        _boxView.delegate = self;
        NSString *str = [NSString stringWithFormat:SITE,[[NSUserDefaults standardUserDefaults] objectForKey:@"haveSite"]];
        NSLog(@"site界面的URL%@",str);
        NSURL *url = [NSURL URLWithString:str];
        MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
        request.delegate = self;
        xNumber = 100;
        [request startAsynchronous];
        NSLog(@"boxDic===========%@",boxDic);
        
        [_boxView show];
        _boxView.frame = CGRectMake(2*width, 0, width, height-118);
        [self.scrollView addSubview:_boxView];
        
    }else
    {
        toolBoxView  = [[UIView alloc] initWithFrame:CGRectMake(2*width, 118, width, height-118)];
        [_scrollView addSubview:toolBoxView];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(120, 280, 125, 44)];
        button.backgroundColor = [UIColor blueColor];
        [button setTitle:@"开启工具箱" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(toolBox) forControlEvents:UIControlEventTouchUpInside];
        [toolBoxView addSubview:button];
        
    }
    
    
}
- (void)jumpToListVC
{
    ListViewController *listVC = [[ListViewController alloc] init];
    [self.navigationController pushViewController:listVC animated:YES];
}

- (void)toolBox
{
    ListViewController *listVC = [[ListViewController alloc] init];
    listVC.URLStr = DESLIST;
    [self.navigationController pushViewController:listVC animated:YES];
}


- (void)siteClick
{
    ListViewController *listVC = [[ListViewController alloc] init];
    listVC.URLStr = DESLIST;
    [self.navigationController pushViewController:listVC animated:YES];
    
}



- (void)initHeaderViewAndFootView:(UITableView *)tableView
{
    
    headerView = [[MJRefreshHeaderView alloc]initWithScrollView:tableView];
    headerView.delegate = self;
    footView = [[MJRefreshFooterView alloc]initWithScrollView:tableView];
    footView.delegate = self;
    
}



#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    baseView = refreshView;
    if (refreshView == headerView) {
        [dataSourceArray removeAllObjects];
        index = 1;
    }
    if (refreshView == footView) {
        index++;
    }
    [self tripGetData];
    [tripTableView reloadData];
    
}


- (IBAction)searchButton:(id)sender {
    
    searchViewController *searchVC = [[searchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    for (int j = 0; j < 3; j++) {
        UIButton *button = (UIButton *)[_buttonView viewWithTag:j+1];
        button.selected = NO;
    }
    sender.selected = YES;
    _scrollView.contentOffset = CGPointMake(width*(sender.tag-1), 0);
    NSInteger j = sender.tag - 1;
    _changeImage.frame = CGRectMake(j*125, 108, 125, 5);
    
}



#pragma mark    -UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentPage = (NSInteger)scrollView.contentOffset.x/width;
    _changeImage.frame = CGRectMake(currentPage*125, 108, 125, 5);
    if (currentPage == 0) {
        _tripButton.selected = YES;
        _distinationButton.selected = NO;
        _articlesButton.selected = NO;
    }
    if (currentPage == 1) {
        _tripButton.selected = NO;
        _distinationButton.selected = YES;
        _articlesButton.selected = NO;
        
    }
    if (currentPage == 2) {
        _tripButton.selected = NO;
        _distinationButton.selected = NO;
        _articlesButton.selected = YES;
        
    }
    
    
}
#pragma mark    -UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"有多少个section%ld",destinationDataSourceArray.count);
    return destinationDataSourceArray.count;
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *array = destinationDataSourceArray[section];
    return array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"desCell" forIndexPath:indexPath];
    NSMutableArray *array = (NSMutableArray *)destinationDataSourceArray[indexPath.section];
    destinationModel *model = array[indexPath.row];
    
    [cell.frontImageView sd_setImageWithURL:[NSURL URLWithString:model.imageStr]];
    cell.chineseLabel.text = model.countryStr;
    cell.englishLabel.text = model.englishStr;
    NSString *str = [NSString stringWithFormat:@"%@旅行地",model.countStr];
    cell.destinationCountLabel.text = str;
    return cell;
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlanViewController *planVC = [[PlanViewController alloc] init];
    NSMutableArray *array = (NSMutableArray *)destinationDataSourceArray[indexPath.section];
    destinationModel *model = array[indexPath.row];
    NSString *str = [NSString stringWithFormat:DESID,model.ID];
    planVC.URLString = str;
    NSString *labelStr = model.countryStr;
    planVC.labelString = [NSString stringWithFormat:@"%@攻略",labelStr];
    [self.navigationController pushViewController:planVC animated:YES];
}


#pragma mark    -section header

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(width, 80);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifierArray[indexPath.section] forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 80)];
    label.text = desArray[indexPath.section];
    [header addSubview:label];
    return header;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




#pragma mark    -UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:tripTableView]) {
        return dataSourceArray.count;
    }else
    {
        return moreButtonArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tripTableView]) {
        tripCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tCell"];
        HomeModel *model = dataSourceArray[indexPath.row];
        cell.nameLabel.text = model.name;
        
        NSString *str1 = model.startDate;
        NSString *str2 = model.days;
        NSString *str3 = model.photoCount;
        
        cell.detailLabel.text = [NSString stringWithFormat:@"%@/%@天, %@图",str1,str2,str3];
        NSLog(@"%@",cell.detailLabel.text);
        [cell.frontImage sd_setImageWithURL:[NSURL URLWithString:model.frontCoverPhotoUrl]];
        [cell.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
        return cell;
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.textLabel.text = moreButtonArray[indexPath.row];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:tripTableView]) {
        describeTripViewController *describeVC = [[describeTripViewController alloc]init];
        HomeModel *model = dataSourceArray[indexPath.row];
        NSString *string = [NSString stringWithFormat:tripDescribe,model.tripDescribeID];
        describeVC.URLString = string;
        describeVC.tableHeadURL = model.frontCoverPhotoUrl;
        [self.navigationController pushViewController:describeVC animated:YES];
    }else
    {
        if (indexPath.row == 0) {
            ReadViewController *readVC = [[ReadViewController alloc]init];
            [self clear];
            [self.navigationController pushViewController:readVC animated:YES];
        }
        if (indexPath.row == 1) {
            ProposalViewController *proposalVC = [[ProposalViewController alloc] init];
            [self clear];
            [self.navigationController pushViewController:proposalVC animated:YES];
        }
        if (indexPath.row == 2) {
            NoralSetViewController *noralVC = [[NoralSetViewController alloc] init];
            [self clear];
            [self.navigationController pushViewController:noralVC animated:YES];
        }
        
    }
    
    
}

- (IBAction)customButton:(UIButton *)sender {
    //加判断是否已经是登陆状态
    LoginRegist *lrVC = [[LoginRegist alloc]init];
    [self.navigationController pushViewController:lrVC animated:YES];
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