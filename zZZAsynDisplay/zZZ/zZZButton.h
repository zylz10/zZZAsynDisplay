//
//  zZZButton.h
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/16.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "zZZBaseView.h"

typedef NS_OPTIONS(NSUInteger, zZZEnventType) {
    zZZEnventTypeTitleColor       = 0,
    zZZEnventTypeBackground  = 1 << 0,
    zZZEnventTypeBackImage   = 1 << 1,
};

typedef NS_OPTIONS(NSUInteger, zZZControlState) {
    zZZControlStateNormal       = 0,
    zZZControlStateHighlighted  = 1 << 0,
};

@interface zZZButtonDispalyObj : NSObject
@property (nonatomic,strong)UIColor *color;
@property (nonatomic,assign)zZZControlState state;
@property (nonatomic,assign)zZZEnventType event;
@property (nonatomic,strong)UIImage *image;
@end

@interface zZZButton : zZZBaseView

@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)UIFont *titleFont;
@property (nonatomic,copy)NSMutableAttributedString *attributedContent;
@property (nonatomic,assign)NSTextAlignment textAlignment;
@property (nonatomic,assign)CGFloat radius;     //圆角

-(void)addTarget:(id)target action:(SEL)action;
-(void)setTitleColor:(UIColor *)color forState:(zZZControlState)state;
-(void)setBackgroundColor:(UIColor *)color forState:(zZZControlState)state;
-(void)setImage:(UIImage *)image forState:(zZZControlState)state;

@end
