//
//  searchViewController.h
//  0707 蝉游记
//
//  Created by pangang on 15/7/13.
//  Copyright (c) 2015年 pangang. All rights reserved.
//

#import "MJWheel.h"
#import "MJWheelButton.h"
#import "searchListViewController.h"
#import "Netinterface.h"

@interface MJWheel()
- (IBAction)startChoose;
@property (weak, nonatomic) IBOutlet UIImageView *centerWheel;
@property (nonatomic, weak) MJWheelButton *selectedBtn;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, assign) NSInteger num;

@end

@implementation MJWheel
{
    NSMutableArray *frogeinsiteArray;
    NSMutableArray *frogeinIDArray;
}

+ (instancetype)wheel
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MJWheel" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    frogeinsiteArray = [[NSMutableArray alloc] initWithObjects:
                        @"日本", @"韩国",@"泰国",@"美国",@"新西兰",@"法国",
                        @"瑞士",@"俄罗斯",@"土耳其",@"巴西",@"阿根廷",@"希腊",nil];
    frogeinIDArray = [[NSMutableArray alloc] initWithObjects:
                        @"55", @"47",@"45",@"57",@"68",@"62",
                        @"90",@"96",@"69",@"78",@"86",@"83",nil];
    self.centerWheel.userInteractionEnabled = YES;
    for (int index = 0; index < 12; index++) {
        MJWheelButton *btn = [[MJWheelButton alloc] init];
        
        [btn setTitle:frogeinsiteArray[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.bounds = CGRectMake(0, 0, 68, 143);
        btn.tag = index+1;
        
        // 设置锚点和位置
        btn.layer.anchorPoint = CGPointMake(1, 1);
        btn.layer.position = CGPointMake(self.centerWheel.frame.size.width * 0.5, self.centerWheel.frame.size.height * 0.5);
        
        // 设置旋转角度(绕着锚点进行旋转)
        CGFloat angle = (30 * index) / 180.0 * M_PI;
        btn.transform = CGAffineTransformMakeRotation(angle);
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self.centerWheel addSubview:btn];
        
//        if (index == 0) {
//            [self btnClick:btn];
//        }
    }
}

- (void)btnClick:(MJWheelButton *)btn
{
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    NSString *str = frogeinIDArray[btn.tag-1];
    NSInteger index = [str integerValue];
    _num = index;
    if (_delegate && [_delegate respondsToSelector:@selector(sendNUM:)]) {
        [_delegate sendNUM:_num];
    }

}

- (void)startRotating
{
    if (self.link) return;
    
    // 1秒内刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopRotating
{
    [self.link invalidate];
    self.link = nil;
}

- (void)update
{
    self.centerWheel.transform = CGAffineTransformRotate(self.centerWheel.transform, M_PI / 500);
}

- (IBAction)startChoose {
    [self stopRotating];
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.rotation";
    anim.toValue = @(2 * M_PI * 3);
    anim.duration = 1.5;
    // 开头和结尾比较慢,中间快
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.delegate = self;
    [self.centerWheel.layer addAnimation:anim forKey:nil];
    
    self.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startRotating];
    });
}
@end
