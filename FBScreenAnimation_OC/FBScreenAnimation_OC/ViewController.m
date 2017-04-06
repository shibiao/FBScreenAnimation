//
//  ViewController.m
//  FBScreenAnimation_OC
//
//  Created by sycf_ios on 2017/4/6.
//  Copyright © 2017年 shibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每点击一次屏幕产生一组图片动画
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
    [self.view addGestureRecognizer:tapGesture];
}
-(void)handleTap{
    //循环10次
    for (NSInteger i = 0; i < 10; i++) {
        //生成动态视图
        [self gengerateAnimationViews];
    }
}
-(void)gengerateAnimationViews{
    UIImage *image = [UIImage imageNamed:drand48() > 0.5 ? @"thumbsUp" : @"heart"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    //drand48()的作用是产生[0,1]直接均匀分布的随机数
    //产生20到38之间的随机数
    NSInteger dimension = 20 + drand48() * 19;
    //定义图片frame
    imageView.frame = CGRectMake(0, 0, dimension, dimension);
    //添加关键帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = [self customPath].CGPath;
    animation.duration = 2 + drand48() * 3;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //把图片关键帧动画路径上
    [imageView.layer addAnimation:animation forKey:nil];
    //添加图片到视图
    [self.view addSubview:imageView];
}
-(UIBezierPath *)customPath {
    UIBezierPath *path = [[UIBezierPath alloc]init];
    //起始点
    [path moveToPoint:CGPointMake(0, 200)];
    //终点
    CGPoint endPoint = CGPointMake(500, 200);
    //随机值
    NSInteger randomYShift = 200 + drand48() * 250;
    //设置2个控制点
    CGPoint cp1 = CGPointMake(100, 100 - randomYShift);
    CGPoint cp2 = CGPointMake(200, 300 + randomYShift);
    //曲线路径
    [path addCurveToPoint:endPoint controlPoint1:cp1 controlPoint2:cp2];
    
    return path;
}


@end
