//
//  ViewController.m
//  UIViewAnimationEncapsulation
//
//  Created by 王斌 on 16/1/13.
//  Copyright © 2016年 Changhong electric Co., Ltd. All rights reserved.
//

#define IMAGE_COUNT 5

#import "ViewController.h"
@interface ViewController (){
    UIImageView *_imageView;
    int _currentIndex;

}


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    self.view.backgroundColor=[UIColor whiteColor];
    
    /**
     1. 图片移动动画
     */
//    //创建图像显示控件
//    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon"]];
//    _imageView.frame = CGRectMake(0, 0, 40, 40);
//    _imageView.layer.cornerRadius = 5;
//    _imageView.center = CGPointMake(50, 150);
//    [self.view addSubview:_imageView];
    
    /**
     2. 图片浏览，请注释touchbegin方法
     */
    //定义图片控件
    _imageView=[[UIImageView alloc]init];
    _imageView.frame=[UIScreen mainScreen].bounds;
    _imageView.contentMode=UIViewContentModeScaleAspectFit;
    _imageView.image=[UIImage imageNamed:@"0.jpg"];//默认图片
    [self.view addSubview:_imageView];
    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];
}

#pragma mark 点击事件
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch=touches.anyObject;
//    CGPoint location= [touch locationInView:self.view];
//    //方法1：block方式
//    /*开始动画，UIView的动画方法执行完后动画会停留在重点位置，而不需要进行任何特殊处理
//     duration:执行时间
//     delay:延迟时间
//     options:动画设置，例如自动恢复、匀速运动等
//     completion:动画完成回调方法
//     */
//    //    [UIView animateWithDuration:5.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
//    //        _imageView.center=location;
//    //    } completion:^(BOOL finished) {
//    //        NSLog(@"Animation end.");
//    //    }];
//    
////    //方法2：静态方法
////    //开始动画
////    [UIView beginAnimations:@"KCBasicAnimation" context:nil];
////    [UIView setAnimationDuration:1.0];
////    //[UIView setAnimationDelay:1.0];//设置延迟
//////    [UIView setAnimationRepeatAutoreverses:NO];//是否回复
////    //[UIView setAnimationRepeatCount:10];//重复次数
////    //[UIView setAnimationStartDate:(NSDate *)];//设置动画开始运行的时间
////    //[UIView setAnimationDelegate:self];//设置代理
////    //[UIView setAnimationWillStartSelector:(SEL)];//设置动画开始运动的执行方法
////    //[UIView setAnimationDidStopSelector:(SEL)];//设置动画运行结束后的执行方法
////    
////    _imageView.center=location;
////
////    //开始动画
////    [UIView commitAnimations];
//    
//    /**
//     * 创建弹性动画
//     * damping:阻尼，范围0-1，阻尼越接近于0，弹性效果越明显
//     * velocity:弹性复位的速度
//     */
//    [UIView animateWithDuration:5.0 delay:0 usingSpringWithDamping:0.1 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
//        _imageView.center = location;//CGPointMake(160, 284);
//    } completion:nil];
//    
//    /**
//     *  关键帧动画
//     *  options:
//     */
//    [UIView animateKeyframesWithDuration:5.0 delay:0 options: UIViewAnimationOptionCurveLinear| UIViewAnimationOptionCurveLinear animations:^{
//        //第二个关键帧（准确的说第一个关键帧是开始位置）:从0秒开始持续50%的时间，也就是5.0*0.5=2.5秒
//        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
//            _imageView.center=CGPointMake(80.0, 220.0);
//        }];
//        //第三个关键帧，从0.5*5.0秒开始，持续5.0*0.25=1.25秒
//        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.25 animations:^{
//            _imageView.center=CGPointMake(45.0, 300.0);
//        }];
//        //第四个关键帧：从0.75*5.0秒开始，持所需5.0*0.25=1.25秒
//        [UIView addKeyframeWithRelativeStartTime:0.75 relativeDuration:0.25 animations:^{
//            _imageView.center=CGPointMake(55.0, 400.0);
//        }];
//    } completion:^(BOOL finished) {
//        NSLog(@"Animation end.");
//    }];
//}
//
#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}

#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    UIViewAnimationOptions option;
    if (isNext) {
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromRight;
    }else{
        option=UIViewAnimationOptionCurveLinear|UIViewAnimationOptionTransitionFlipFromLeft;
    }
    
    [UIView transitionWithView:_imageView duration:1.0 options:option animations:^{
        _imageView.image=[self getImage:isNext];
    } completion:nil];
}

#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"%d.jpg",_currentIndex];
    return [UIImage imageNamed:imageName];
}


@end
