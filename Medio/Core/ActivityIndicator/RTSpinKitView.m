//
//  RTSpinKitView.m
//  SpinKit
//
//  Created by Ramon Torres on 1/1/14.
//  Copyright (c) 2014 Ramon Torres. All rights reserved.
//

#import "RTSpinKitView.h"

#include <tgmath.h>

static CGFloat kRTSpinKitDegToRad = 0.0174532925;

static CATransform3D RTSpinKit3DRotationWithPerspective(CGFloat perspective,
                                                        CGFloat angle,
                                                        CGFloat x,
                                                        CGFloat y,
                                                        CGFloat z)
{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = perspective;
    return CATransform3DRotate(transform, angle, x, y, z);
}

@interface RTSpinKitView ()
@property (nonatomic, assign) RTSpinKitViewStyle style;
@property (nonatomic, assign, getter = isStopped) BOOL stopped;
@end

@implementation RTSpinKitView

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style {
    return [self initWithStyle:style color:[UIColor grayColor]];
}

-(instancetype)initWithStyle:(RTSpinKitViewStyle)style color:(UIColor*)color {
    self = [super init];
    if (self) {
        _style = style;
        _color = color;
        _hidesWhenStopped = YES;

        [self sizeToFit];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        if (style == RTSpinKitViewStylePlane) {
            CALayer *plane = [CALayer layer];
            plane.frame = CGRectInset(self.bounds, 2.0, 2.0);
            plane.backgroundColor = color.CGColor;
            plane.anchorPoint = CGPointMake(0.5, 0.5);
            plane.anchorPointZ = 0.5;
            plane.shouldRasterize = YES;
            plane.rasterizationScale = [[UIScreen mainScreen] scale];
            [self.layer addSublayer:plane];

            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            anim.removedOnCompletion = NO;
            anim.repeatCount = HUGE_VALF;
            anim.duration = 1.2;
            anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];

            anim.timingFunctions = @[
                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
            ];

            anim.values = @[
                [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, 0, 0, 0, 0)],
                [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 1.0,0.0)],
                [NSValue valueWithCATransform3D:RTSpinKit3DRotationWithPerspective(1.0/120.0, M_PI, 0.0, 0.0,1.0)]
            ];

            [plane addAnimation:anim forKey:@"spinkit-anim"];
        }
        else if (style == RTSpinKitViewStyleBounce) {
            NSTimeInterval beginTime = CACurrentMediaTime();

            for (NSInteger i=0; i < 2; i+=1) {
                CALayer *circle = [CALayer layer];
                circle.frame = CGRectInset(self.bounds, 2.0, 2.0);
                circle.backgroundColor = color.CGColor;
                circle.anchorPoint = CGPointMake(0.5, 0.5);
                circle.opacity = 0.6;
                circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
                circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);

                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                anim.removedOnCompletion = NO;
                anim.repeatCount = HUGE_VALF;
                anim.duration = 2.0;
                anim.beginTime = beginTime - (1.0 * i);
                anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];

                anim.timingFunctions = @[
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                ];

                anim.values = @[
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                ];

                [self.layer addSublayer:circle];
                [circle addAnimation:anim forKey:@"spinkit-anim"];
            }
        }
        else if (style == RTSpinKitViewStyleWave) {
            NSTimeInterval beginTime = CACurrentMediaTime() + 1.2;
            CGFloat barWidth = CGRectGetWidth(self.bounds) / 5.0;
    
            for (NSInteger i=0; i < 5; i+=1) {
                CALayer *layer = [CALayer layer];
                layer.backgroundColor = color.CGColor;
                layer.frame = CGRectMake(barWidth * i, 0.0, barWidth - 3.0, CGRectGetHeight(self.bounds));
                layer.transform = CATransform3DMakeScale(1.0, 0.3, 0.0);

                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                anim.removedOnCompletion = NO;
                anim.beginTime = beginTime - (1.2 - (0.1 * i));
                anim.duration = 1.2;
                anim.repeatCount = HUGE_VALF;

                anim.keyTimes = @[@(0.0), @(0.2), @(0.4), @(1.0)];

                anim.timingFunctions = @[
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                ];

                anim.values = @[
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)],
                    [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 0.4, 0.0)]
                ];

                [self.layer addSublayer:layer];
                [layer addAnimation:anim forKey:@"spinkit-anim"];
            }
        }
        
        else if (style == RTSpinKitViewStyleWanderingCubes) {
            NSTimeInterval beginTime = CACurrentMediaTime();
            CGFloat cubeSize = floor(CGRectGetWidth(self.bounds) / 3.0);
            CGFloat widthMinusCubeSize = CGRectGetWidth(self.bounds) - cubeSize;
            
            for (NSInteger i=0; i<2; i+=1) {
                CALayer *cube = [CALayer layer];
                cube.backgroundColor = color.CGColor;
                cube.frame = CGRectMake(0.0, 0.0, cubeSize, cubeSize);
                cube.anchorPoint = CGPointMake(0.5, 0.5);
                cube.shouldRasterize = YES;
                cube.rasterizationScale = [[UIScreen mainScreen] scale];
                
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                anim.removedOnCompletion = NO;
                anim.beginTime = beginTime - (i * 0.9);
                anim.duration = 1.8;
                anim.repeatCount = HUGE_VALF;
                
                anim.keyTimes = @[@(0.0), @(0.25), @(0.50), @(0.75), @(1.0)];
                
                anim.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                         ];
                
                CATransform3D t0 = CATransform3DIdentity;
                
                CATransform3D t1 = CATransform3DMakeTranslation(widthMinusCubeSize, 0.0, 0.0);
                t1 = CATransform3DRotate(t1, -90.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
                t1 = CATransform3DScale(t1, 0.5, 0.5, 1.0);
                
                CATransform3D t2 = CATransform3DMakeTranslation(widthMinusCubeSize, widthMinusCubeSize, 0.0);
                t2 = CATransform3DRotate(t2, -180.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
                t2 = CATransform3DScale(t2, 1.0, 1.0, 1.0);
                
                CATransform3D t3 = CATransform3DMakeTranslation(0.0, widthMinusCubeSize, 0.0);
                t3 = CATransform3DRotate(t3, -270.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
                t3 = CATransform3DScale(t3, 0.5, 0.5, 1.0);
                
                CATransform3D t4 = CATransform3DMakeTranslation(0.0, 0.0, 0.0);
                t4 = CATransform3DRotate(t4, -360.0 * kRTSpinKitDegToRad, 0.0, 0.0, 1.0);
                t4 = CATransform3DScale(t4, 1.0, 1.0, 1.0);
                
                
                anim.values = @[[NSValue valueWithCATransform3D:t0],
                                [NSValue valueWithCATransform3D:t1],
                                [NSValue valueWithCATransform3D:t2],
                                [NSValue valueWithCATransform3D:t3],
                                [NSValue valueWithCATransform3D:t4]];
                
                [self.layer addSublayer:cube];
                [cube addAnimation:anim forKey:@"spinkit-anim"];
            }
        }
        else if (style == RTSpinKitViewStylePulse) {
            NSTimeInterval beginTime = CACurrentMediaTime();
            
            CALayer *circle = [CALayer layer];
            circle.frame = CGRectInset(self.bounds, 2.0, 2.0);
            circle.backgroundColor = color.CGColor;
            circle.anchorPoint = CGPointMake(0.5, 0.5);
            circle.opacity = 1.0;
            circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
            circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
            
            CAKeyframeAnimation *scaleAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            scaleAnim.values = @[
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                                 [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)]
                                 ];
            
            CAKeyframeAnimation *opacityAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
            opacityAnim.values = @[@(1.0), @(0.0)];
            
            CAAnimationGroup *animGroup = [CAAnimationGroup animation];
            animGroup.removedOnCompletion = NO;
            animGroup.beginTime = beginTime;
            animGroup.repeatCount = HUGE_VALF;
            animGroup.duration = 1.0;
            animGroup.animations = @[scaleAnim, opacityAnim];
            animGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            
            [self.layer addSublayer:circle];
            [circle addAnimation:animGroup forKey:@"spinkit-anim"];
        }
        else if (style==RTSpinKitViewStyleFadingCircleAlt){
            NSTimeInterval beginTime = CACurrentMediaTime() ;
            
            CGFloat radius =  floor(CGRectGetWidth(self.bounds) / 3.0);
            for (NSInteger i=0; i < 12;  i+=1) {
                CALayer *circle = [CALayer layer];
                circle.backgroundColor = color.CGColor;
                circle.anchorPoint = CGPointMake(0.5, 0.5);
                circle.frame = CGRectMake(radius + cosf(kRTSpinKitDegToRad * (30.0 * i)) * radius , radius + sinf(kRTSpinKitDegToRad * (30.0 * i)) * radius, radius / 2, radius / 2);
                circle.shouldRasterize = YES;
                circle.rasterizationScale = [[UIScreen mainScreen] scale];
                circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
                
                CAKeyframeAnimation* transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                
                transformAnimation.values = @[
                                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                                              ];
                
                CAKeyframeAnimation* opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
                
                opacityAnimation.values = @[
                                            @(1.0),
                                            @(0.0)
                                            ];
                
                CAAnimationGroup* animationGroup = [[CAAnimationGroup alloc] init];
                animationGroup.removedOnCompletion = NO;
                animationGroup.repeatCount = HUGE_VALF;
                animationGroup.duration = 1.2;
                animationGroup.beginTime = beginTime - (1.2 - (0.1 * i));
                animationGroup.animations = @[transformAnimation, opacityAnimation];
                [circle addAnimation:animationGroup forKey:@"spinkit-anim"];
                [self.layer addSublayer:circle];
            }
        }
        else if (style==RTSpinKitViewStyleFadingCircle){
            
            NSTimeInterval beginTime = CACurrentMediaTime();
            
            CGFloat radius = 18.500000;
            CGFloat squareSize = 6.166667;
            for (NSInteger i=0; i < 12; i+=1) {
                CALayer *square = [CALayer layer];
                
                CGFloat angle = i * (M_PI_2/3.0);
                CGFloat x = radius + sinf(angle) * radius;
                CGFloat y = radius - cosf(angle) * radius;
                square.frame = CGRectMake(x, y, squareSize, squareSize);
                square.backgroundColor = color.CGColor;
                square.anchorPoint = CGPointMake(0.5, 0.5);
                square.opacity = 0.0;
                
                CATransform3D transform = CATransform3DIdentity;
                transform = CATransform3DRotate(transform, angle, 0, 0, 1.0);
                square.transform = transform;
                
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
                anim.removedOnCompletion = NO;
                anim.repeatCount = HUGE_VALF;
                anim.duration = 1.0;
                anim.beginTime = beginTime + (0.084 * i);
                anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
                
                anim.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                         ];
                
                anim.values = @[@(1.0), @(0.0), @(0.0)];
                
                [square addAnimation:anim forKey:@"spinkit-anim"];
            }

        }
        else if (style==RTSpinKitViewStyle9CubeGrid){
            NSTimeInterval beginTime = CACurrentMediaTime();
            
            CGFloat squareSize = floor(CGRectGetWidth(self.bounds) / 3.0);
            
            for (NSInteger sum = 0; sum < 5; sum++)
            {
                for (NSInteger x = 0; x < 3; x++)
                {
                    for (NSInteger y = 0; y < 3; y++)
                    {
                        if (x + y == sum)
                        {
                            CALayer *square = [CALayer layer];
                            square.frame = CGRectMake(x * squareSize, y * squareSize, squareSize, squareSize);
                            square.backgroundColor = color.CGColor;
                            square.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
                            
                            CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                            anim.removedOnCompletion = NO;
                            anim.repeatCount = HUGE_VALF;
                            anim.duration = 1.5;
                            anim.beginTime = beginTime + (0.1 * sum);
                            anim.keyTimes = @[@(0.0), @(0.4), @(0.6), @(1.0)];
                            
                            anim.timingFunctions = @[
                                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                                     ];
                            
                            anim.values = @[
                                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                                            ];
                            
                            [square addAnimation:anim forKey:@"spinkit-anim"];
                        }
                    }
                }
            }

        }
        else if (style==RTSpinKitViewStyleThreeBounce){
            NSTimeInterval beginTime = CACurrentMediaTime();
            CGFloat offset = 37.000 / 8;
            CGFloat circleSize = offset * 2;
            for (NSInteger i=0; i < 3; i+=1) {
                CALayer *circle = [CALayer layer];
                circle.frame = CGRectMake(i * 3 * offset, 37.000, circleSize, circleSize);
                circle.backgroundColor = color.CGColor;
                circle.anchorPoint = CGPointMake(0.5, 0.5);
                circle.cornerRadius = CGRectGetHeight(circle.bounds) * 0.5;
                circle.transform = CATransform3DMakeScale(0.0, 0.0, 0.0);
                
                CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
                anim.removedOnCompletion = NO;
                anim.repeatCount = HUGE_VALF;
                anim.duration = 1.5;
                anim.beginTime = beginTime + (0.25 * i);
                anim.keyTimes = @[@(0.0), @(0.5), @(1.0)];
                
                anim.timingFunctions = @[
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                         [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                         ];
                
                anim.values = @[
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 0.0)],
                                [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 0.0)]
                                ];
                
                [circle addAnimation:anim forKey:@"spinkit-anim"];
            }

        }

        [self stopAnimating];
    }
    return self;
}

-(void)applicationWillEnterForeground {
    if (self.stopped) {
        [self pauseLayers];
    } else {
        [self resumeLayers];
    }
}

-(void)applicationDidEnterBackground {
    [self pauseLayers];
}

-(BOOL)isAnimating {
	return !self.isStopped;
}

-(void)startAnimating {
	if (self.isStopped) {
		self.hidden = NO;
		self.stopped = NO;
		[self resumeLayers];
	}
}

-(void)stopAnimating {
	if ([self isAnimating]) {
		if (self.hidesWhenStopped) {
			self.hidden = YES;
		}
		
		self.stopped = YES;
		[self pauseLayers];
	}
}

-(void)pauseLayers {
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;
    self.layer.timeOffset = pausedTime;
}

-(void)resumeLayers {
    CFTimeInterval pausedTime = [self.layer timeOffset];
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.layer.beginTime = timeSincePause;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(37.0, 37.0);
}

-(void)setColor:(UIColor *)color {
    _color = color;

    for (CALayer *l in self.layer.sublayers) {
        l.backgroundColor = color.CGColor;
    }
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
