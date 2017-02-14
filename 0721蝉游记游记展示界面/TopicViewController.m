//
//  TopicViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/2.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicModel.h"
#import "TopicCell.h"
#import "MyHTTPRequest.h"
#import "UIImageView+WebCache.h"
#import "CacheTool.h"

@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate,MyHTTPRequestDelegate>
{
    UITableView *userTableView;
    CGFloat width;
    CGFloat height;
    NSArray  *Arr;
}

@end

@implementation TopicViewController
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Arr = [[NSArray alloc] init];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height-64;
    userTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, width, height)];
    userTableView.dataSource = self;
    userTableView.delegate = self;
    [userTableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"tpCell"];
    [self.view addSubview:userTableView];
    //
    [self getData:_URLString];
    
    
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)getData:(NSString *)string
{
    NSDictionary *dict = [CacheTool putoutwithID:string];
    if (dict) {
        [self serializingWith:dict];
    }else
    {
        NSURL *url = [NSURL URLWithString:string];
        MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
        request.delegate = self;
        [request startAsynchronous];
    }
}

- (void)requestFinsh:(NSDictionary *)dic
{
    [CacheTool addTrip:dic andID:_URLString];
    [self serializingWith:dic];
}

- (void)serializingWith:(NSDictionary *)dic
{
    NSArray *array = (NSArray *)dic;
    Arr = [MTLJSONAdapter modelsOfClass:[TopicModel class] fromJSONArray:array error:nil];
    [userTableView reloadData];

}

- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);

}

#pragma mark    -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Arr.count;
    

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tpCell"];
    TopicModel *model = Arr[indexPath.row];
    [cell.frontImageView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    NSLog(@"%@",model.image_url);
    cell.nameLabel.text = model.name;
    NSLog(@"%@",model.name);
    cell.titleLabel.text = model.title;
    return cell;
}

#pragma mark    -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 232;
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
