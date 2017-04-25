//
//  ViewController.m
//  LiveGift-Demo
//
//  Created by 张建 on 2017/4/20.
//  Copyright © 2017年 JuZiShu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //点赞动画
    [self praiseAnimation];
}

//点赞动画
- (void)praiseAnimation{
    
    UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self randomImageName]]];
    imgView.alpha = .8;
    imgView.backgroundColor = [UIColor clearColor];
    imgView.frame = CGRectMake(250 -15, 300 - 15, 30, 30);
    [self.view addSubview:imgView];
    
    //giftAnimation
    [self giftAnimation:imgView];
}
//giftAnimation
- (void)giftAnimation:(UIImageView *)imgView{
    
    //position
    CAKeyframeAnimation * positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = [self threeCurvePath].CGPath;
    positionAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    positionAnimation.removedOnCompletion = NO;//yes的话，返回原位置
    positionAnimation.duration = 2.0;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//线性
    positionAnimation.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态
    
    //scale
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 0.5;//动画持续的时长
    scaleAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    scaleAnimation.removedOnCompletion = NO;//yes的话，返回原位置
    scaleAnimation.fromValue = @(0.1);//开始的倍率
    scaleAnimation.toValue = @(1.0);//结束的倍率
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//线性
    scaleAnimation.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态
    
    //opacity
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];// 动画选项设定
    opacityAnimation.duration = 0.5; // 动画持续时间
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.autoreverses = NO;//动画结束时是否执行逆动画
    opacityAnimation.beginTime = 1.5f;
    opacityAnimation.fromValue = @(0.8);
    opacityAnimation.toValue = @(0.0);
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//线性
    opacityAnimation.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态
    
    //group
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 2.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.animations = @[positionAnimation,scaleAnimation,opacityAnimation];
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];//线性
    animationGroup.fillMode = kCAFillModeForwards;//当动画结束后,layer会一直保持着动画最后的状态

    //layer
    [imgView.layer addAnimation:animationGroup forKey:@"animationGroup"];
    
}
//positionPath
//三级贝塞尔曲线
- (UIBezierPath *)threeCurvePath{
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(250, 300)];
    [bezierPath addCurveToPoint:CGPointMake(150 + arc4random()%200, 0) controlPoint1:CGPointMake(150 + arc4random()%200, 100) controlPoint2:CGPointMake(150 + arc4random()%200, 200)];
    bezierPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    bezierPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    bezierPath.lineWidth = 2.0f;
    [bezierPath stroke];
    
    return bezierPath;
}


//随机图片
- (NSString *)randomImageName{
    
    NSInteger number = arc4random()%(4 + 1);
    NSString * randomImageName;
    switch (number) {
        case 1:
        {
            randomImageName = @"bHeart";
        }
            break;
        case 2:
        {
            randomImageName = @"gHeart";
        }
            break;
        case 3:
        {
            randomImageName = @"rHeart";
        }
            break;
        case 4:
        {
            randomImageName = @"yHeart";
        }
            break;
        default:
        {
            randomImageName = @"bHeart";
        }
            break;
    }
    
    return randomImageName;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
