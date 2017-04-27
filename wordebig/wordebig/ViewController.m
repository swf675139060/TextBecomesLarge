//
//  ViewController.m
//  wordebig
//
//  Created by 申文峰 on 2017/4/11.
//  Copyright © 2017年 申文峰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
{
    UILabel *lable;
   
    UIView *vview;
}

@property (strong,nonatomic) UIButton *button;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0, 100, 40);
    _button.backgroundColor = [UIColor redColor];
    [_button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    vview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    vview.backgroundColor = [UIColor greenColor];
    vview.center = self.view.center;
    vview.layer.cornerRadius = vview.frame.size.height/2;
    [self.view addSubview:vview];
    
    lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
    lable.text = @"动画已经准备好";
    lable.font = [UIFont systemFontOfSize:30];
    lable.layer.borderWidth = 3;
    lable.layer.borderColor = [UIColor whiteColor].CGColor;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.layer.cornerRadius = lable.frame.size.height/2;
    [vview addSubview:lable];
}

- (void)buttonClick
{
    [UIView animateWithDuration:10 animations:^{
        //self.button.frame = CGRectMake(100, 100, 100, 40);
        
        CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        aniScale.fromValue = [NSNumber numberWithFloat:1.0];
        aniScale.toValue = [NSNumber numberWithFloat:0.5];
        aniScale.duration = 10;
        aniScale.delegate = self;
        aniScale.removedOnCompletion = NO;
        aniScale.repeatCount = 10;
        [vview.layer addAnimation:aniScale forKey:@"babyCoin_scale"];
         
        
    } completion:^(BOOL finished) {
        [self babyCoinFadeAway];
    }];
}

-(void)babyCoinFadeAway
{
    
    //相当与两个动画  合成
    //位置改变
    CABasicAnimation * aniMove = [CABasicAnimation animationWithKeyPath:@"position"];
    aniMove.fromValue = [NSValue valueWithCGPoint:vview.layer.position];
    aniMove.toValue = [NSValue valueWithCGPoint:CGPointMake(500, 300)];
    //大小改变
    CABasicAnimation * aniScale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    aniScale.fromValue = [NSNumber numberWithFloat:3.0];
    aniScale.toValue = [NSNumber numberWithFloat:0.5];
    
    CAAnimationGroup * aniGroup = [CAAnimationGroup animation];
    aniGroup.duration = 3.0;//设置动画持续时间
    aniGroup.repeatCount = 1;//设置动画执行次数
    aniGroup.delegate = self;
    aniGroup.animations = @[aniMove,aniScale];
    aniGroup.removedOnCompletion = NO;
    aniGroup.fillMode = kCAFillModeForwards;  //防止动画结束后回到原位
    //    [lable.layer removeAllAnimations];
    [vview.layer addAnimation:aniGroup forKey:@"aniMove_aniScale_groupAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
