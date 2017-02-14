//
//  TacticViewController.m
//  0721蝉游记游记展示界面
//
//  Created by pangang on 15/8/2.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "TacticViewController.h"
#import "TacticCell.h"
#import "MyHTTPRequest.h"
#import "TacticModel.h"
#import "AtacticModel.h"


@interface TacticViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MyHTTPRequestDelegate>
{
    UICollectionView *userCollectionView;
    CGFloat width;
    CGFloat height;
    NSArray *datasourceArray;
    NSMutableArray *sectionHead;
}

@end

@implementation TacticViewController
- (IBAction)backButton:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height-64;
    sectionHead = [NSMutableArray array];
    for (NSInteger i = 1; i < 12; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",i]];
        [sectionHead addObject:image];
    }
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    userCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, width, height) collectionViewLayout:layout];
    userCollectionView.dataSource = self;
    userCollectionView.delegate = self;
    userCollectionView.backgroundColor = [UIColor whiteColor];
    //注册cell
    [userCollectionView registerNib:[UINib nibWithNibName:@"TacticCell" bundle:nil] forCellWithReuseIdentifier:@"tacCell"];
    //注册段头
    [userCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    [self.view addSubview:userCollectionView];
    [self getData:_URLString];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)getData:(NSString *)string
{
    NSURL *url =[NSURL URLWithString:string];
    MyHTTPRequest *request = [[MyHTTPRequest alloc] initWithURL:url];
    request.delegate = self;
    [request startAsynchronous];
    
    

}
- (void)requestFinsh:(NSDictionary *)dic
{
    NSArray *array = (NSArray *)dic;
    datasourceArray = [MTLJSONAdapter modelsOfClass:[AtacticModel class] fromJSONArray:array error:nil];
    [userCollectionView reloadData];
}
- (void)requestFailed:(NSString *)str
{
    NSLog(@"%@",str);
    
    
}
#pragma mark    -UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(width/2-10, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 0, 0);

}

#pragma mark    -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return datasourceArray.count;
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    AtacticModel *model = datasourceArray[section];
    return model.tacticModel.count;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TacticCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tacCell" forIndexPath:indexPath];
    [cell sizeToFit];
    AtacticModel *Amodel = datasourceArray[indexPath.section];
    TacticModel *model = Amodel.tacticModel[indexPath.row];
    cell.tacLabel.text = model.title;
    return cell;
    

    
}
#pragma mark    -UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(width, 55);
   
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, 55)];
    imageView.image = sectionHead[indexPath.section];
    [head addSubview:imageView];
    return head;

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
