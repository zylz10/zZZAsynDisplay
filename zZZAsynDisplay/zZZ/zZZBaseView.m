//
//  zZZBaseView.m
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/29.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "zZZBaseView.h"

@implementation zZZBaseView

-(void)drawRadius:(CGContextRef)context
             size:(CGSize)size
           radius:(CGFloat)radius
        image:(UIImage *)oimage{
    if (!oimage) {
        return;
    }
    CGImageRef image;
    UIImage *img = oimage;
    image = CGImageRetain(img.CGImage);
    
    //图片frame
    CGRect imageRect;
    imageRect.origin = CGPointMake(0.0, 0.0);
    imageRect.size = size;
    
    if (radius) {
        //左上角
        CGContextMoveToPoint(context, imageRect.origin.x, imageRect.origin.y + radius);
        CGContextAddLineToPoint(context, imageRect.origin.x, imageRect.origin.y + imageRect.size.height - radius);
        CGContextAddArc(context, imageRect.origin.x + radius, imageRect.origin.y + imageRect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
        //右上角
        CGContextAddLineToPoint(context, imageRect.origin.x + imageRect.size.width - radius,
                                imageRect.origin.y + imageRect.size.height);
        CGContextAddArc(context, imageRect.origin.x + imageRect.size.width - radius,
                        imageRect.origin.y + imageRect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
        //左下角
        CGContextAddLineToPoint(context, imageRect.origin.x + imageRect.size.width, imageRect.origin.y + radius);
        CGContextAddArc(context, imageRect.origin.x + imageRect.size.width - radius, imageRect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
        //右下角
        CGContextAddLineToPoint(context, imageRect.origin.x + radius, imageRect.origin.y);
        CGContextAddArc(context, imageRect.origin.x + radius, imageRect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
        
        //全圆角
        //        CGContextMoveToPoint(context, imageRect.origin.x, imageRect.origin.y + self.radius);
        //        CGContextAddLineToPoint(context, imageRect.origin.x, imageRect.origin.y + imageRect.size.height - self.radius);
        //        CGContextAddArc(context, imageRect.origin.x + self.radius, imageRect.origin.y + imageRect.size.height - self.radius,
        //                        self.radius, M_PI, -M_PI, 1);
        CGContextClip(context);
    }
    
    CGContextDrawImage(context, imageRect, image);
    CFRelease(image);
}
@end
