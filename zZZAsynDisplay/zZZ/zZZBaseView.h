//
//  zZZBaseView.h
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/29.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zZZBaseView : UIView

-(void)drawRadius:(CGContextRef)context
             size:(CGSize)size
           radius:(CGFloat)radius
            image:(UIImage *)oimage;

@end
