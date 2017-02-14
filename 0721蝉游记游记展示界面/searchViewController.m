//
//  searchViewController.m
//  0707 蝉游记
//
//  Created by pangang on 15/7/13.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "searchViewController.h"
#import "Netinterface.h"
#import "searchListViewController.h"
#import "SeasonViewController.h"
#import "MJWheel.h"
#import "MJWheelButton.h"

@interface searchViewController ()<UIScrollViewDelegate,jumpdelegate>
{
    UIScrollView *scrollView;
    int width;
    int height;
    UIView *seasonView;
    UIView *countryView;
    MJWheel *frogeinView;
    NSInteger currentPage;
    NSMutableArray *countryidArray;
    NSMutableArray *countrysiteArray;
    
    
    
}

@end

@implementation searchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countryidArray = [[NSMutableArray alloc]initWithObjects:
                               @"12",@"13",@"14",
                               @"16",@"25",@"20",
                               @"35",@"23",@"32",
                               @"31",@"22",@"26",
                               @"17" ,@"11" ,@"28",
                               @"21",@"33", @"37",
                               @"27" ,@"24" ,@"18",
                               @"19", @"36" ,@"38",
                               @"34", @"10", @"40",
                               @"30" ,@"44" ,@"42",
                               @" 29",@"41", @"39",
                               @"43",nil];
    
    countrysiteArray = [[NSMutableArray alloc]initWithObjects:
                                 @"台湾", @"香港", @"澳门",
                                 @"云南",   @"上海",   @"四川",
                                 @"浙江",   @"北京",   @"广东",
                                  @"江苏",    @"福建",  @"西藏",
                                 @"陕西" ,  @"青海" ,   @"甘肃",
                                 @"广西",   @"山东",    @"重庆",
                                 @"湖南" ,  @"海南" ,  @"内蒙古",
                                @"湖北",   @"黑龙江" ,  @"辽宁",
                                @"安徽",   @"新疆",    @"河南",
                                @"山西" ,  @"贵州" ,   @"河北",
                                @"江西",  @"天津",    @"吉林",
                                @"宁夏", nil];
    
    
    
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 118, self.view.frame.size.width, self.view.frame.size.height-118)];
    
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    width = self.view.frame.size.width;
    height = scrollView.frame.size.height;
    [_frogeinButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_countryButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_seasonButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    //默认第二个页面
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.contentSize = CGSizeMake(3*width, 0);
    scrollView.delegate = self;
    _frogeinButton.selected = YES;
    _countryButton.selected = NO;
    _seasonButton.selected = NO;
    
    [self initView];
    
    
    
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)clickBackButton:(UIButton *)sender {
    
    NSLog(@"返回主界面");
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)initView
{

    frogeinView = [MJWheel wheel];
    frogeinView.delegate = self;
//    [frogeinView addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    frogeinView.center = CGPointMake(width * 0.5, height * 0.5);
    [scrollView addSubview:frogeinView];
    
    countryView = [[UIView alloc]initWithFrame:CGRectMake(width, 0, width, height)];
    [scrollView addSubview:countryView];
    for (int j = 0; j < 12; j++) {
        for (int i = 0; i < 3; i++) {
            if ((j*3+i) <= 33) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+120*i, 5+46*j, 115, 42)];
                [button setTitle:countrysiteArray[j*3+i] forState:UIControlStateNormal];
                button.layer.borderWidth = 5;
                button.layer.borderColor = [UIColor blackColor].CGColor;
                
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                NSString *str = countryidArray[j*3+i];
                button.tag = [str intValue];
                [button addTarget:self action:@selector(clickDestination:) forControlEvents:UIControlEventTouchUpInside];
                [button.layer setBorderWidth:1];
                [countryView addSubview:button];
            }
            
            
        }
    }
    
    seasonView = [[UIView alloc]initWithFrame:CGRectMake(2*width, 0, width, height)];
    [scrollView addSubview:seasonView];
    for (int j = 0; j < 4; j++)
    {
        for (int i = 0; i < 3; i++) {
            if ((j*3+i) <= 11) {
                UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+120*i, 5+46*j, 115, 42)];
                [button setTitle:[NSString stringWithFormat:@"%d月",j*3+i+1] forState:UIControlStateNormal];
                button.layer.borderWidth = 5;
                button.layer.borderColor = [UIColor blackColor].CGColor;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                button.tag = j*3+i+1;
                NSLog(@"%ld",button.tag);
                [button addTarget:self action:@selector(clickSeason:) forControlEvents:UIControlEventTouchUpInside];
                [button.layer setBorderWidth:1];
                [seasonView addSubview:button];
            }
        }
    }
    

}

- (void)sendNUM:(NSInteger)num
{
    NSString *string = [NSString stringWithFormat:search,(int)num];
    searchListViewController *listVC =[[searchListViewController alloc] init];
    listVC.URLString = string;
    [self.navigationController pushViewController:listVC animated:YES];
    
    

}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"num"]) {
//        NSInteger a = [frogeinView valueForKey:@"num"];
//            NSString *string = [NSString stringWithFormat:search,(int)a];
//            searchListViewController *listVC = [[searchListViewController alloc] init];
//            listVC.URLString = string;
//        [self.navigationController pushViewController:listVC animated:YES];
//        
//        
//    }
//}
- (void)clickDestination:(UIButton *)sender
{
    
    searchListViewController *listVC = [[searchListViewController alloc]init];
    int index = (int)sender.tag;
    NSString *string = [NSString stringWithFormat:search,index];
    listVC.URLString = string;
    [self.navigationController pushViewController:listVC animated:YES];
}
- (void)clickSeason:(UIButton *)sender
{
    SeasonViewController *seasonVC = [[SeasonViewController alloc]init];
    NSInteger index = (NSInteger)sender.tag;
    NSString *string = [NSString stringWithFormat:MOUTHSEARCH,index];
    seasonVC.urlString = string;
    seasonVC.labelStr = [NSString stringWithFormat:@"%ld月游记",sender.tag];
    [self.navigationController pushViewController:seasonVC animated:YES];

}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    currentPage = (NSInteger)scrollView.contentOffset.x/width;
    _changeImage.frame = CGRectMake(currentPage*125, 108, 125, 10);
    if (currentPage == 0) {
        _frogeinButton.selected = YES;
        _countryButton.selected = NO;
        _seasonButton.selected = NO;
    }
    if (currentPage == 1) {
        _frogeinButton.selected = NO;
        _countryButton.selected = YES;
        _seasonButton.selected = NO;
    }
    if (currentPage == 2) {
        _frogeinButton.selected = NO;
        _countryButton.selected = NO;
        _seasonButton.selected = YES;
        
        
    }
    
    
}

- (IBAction)clickButton:(UIButton *)sender {
    
    for (int j = 0; j < 3; j++) {
        UIButton *button = (UIButton *)[_buttonView viewWithTag:j+1];
        button.selected = NO;
    }
    sender.selected = YES;
    _changeImage.frame = CGRectMake(125*(sender.tag-1), 108, 125, 10);
    scrollView.contentOffset = CGPointMake(width*(sender.tag-1), 0);
    

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
