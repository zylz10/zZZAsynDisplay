//
//  zZZImageView.m
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/27.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "zZZImageView.h"
#import "YYAsyncLayer.h"

@implementation zZZImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
#pragma mark - GCAsyncLayerDelegate
+ (Class)layerClass {
    return YYAsyncLayer.class;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    [self contentNeedUpdate];
}
-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self contentNeedUpdate];
}
- (void)contentNeedUpdate {
    [self.layer setNeedsDisplay];
}
- (YYAsyncLayerDisplayTask *)newAsyncDisplayTask {
    YYAsyncLayerDisplayTask *displayTask = [YYAsyncLayerDisplayTask new];
    
    __weak __typeof(&*self)weakSelf = self;
    [displayTask setWillDisplay:^(CALayer * _Nonnull layer) {
        layer.contentsScale = 2;
    }];
    
    [displayTask setDisplay:^(CGContextRef _Nonnull context, CGSize size, BOOL (^ _Nonnull isCancelled)(void)) {
        if (isCancelled()) {
            return;
        }
        if (!self.image) {
            return;
        }
        [weakSelf drawInContext:context withSize:size];
    }];
    
    [displayTask setDidDisplay:^(CALayer * _Nonnull layer, BOOL isFinish) {
        
    }];
    
    return displayTask;
}
- (void)drawInContext:(CGContextRef)context withSize:(CGSize)size {
    
    [self drawRadius:context size:size radius:self.radius image:self.image];
}

@end
