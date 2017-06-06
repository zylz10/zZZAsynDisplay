//
//  zZZImageView.h
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/27.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "zZZBaseView.h"

typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3
} UIImageRoundedCorner;

@interface zZZImageView : zZZBaseView
@property (nonatomic,strong)UIImage *image;     //图片
@property (nonatomic,assign)CGFloat radius;     //圆角
@end
