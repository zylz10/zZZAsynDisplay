//
//  zZZButton.m
//  GCAsyncDisplayDemo
//
//  Created by zhangyiling on 17/3/16.
//  Copyright © 2017年 宫城. All rights reserved.
//

#import "zZZButton.h"
#import "YYAsyncLayer.h"
#import <CoreText/CoreText.h>

#define defultbackGroundColor [UIColor clearColor]
#define defultTitleColor [UIColor backColor]


@interface zZZButton()
@property (nonatomic,assign)BOOL pressed;
@property (nonatomic,weak)id target;
@property (nonatomic)SEL action;
@property (nonatomic,strong)NSMutableSet *eventSet;
@property (nonatomic,assign)zZZControlState currentState;
@end

@implementation zZZButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = defultbackGroundColor;
        self.currentState = zZZControlStateNormal;
        self.eventSet = [NSMutableSet set];
    }
    return self;
}
#pragma mark - GCAsyncLayerDelegate
+ (Class)layerClass {
    return YYAsyncLayer.class;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    [self contentNeedUpdate];
}
-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    [self contentNeedUpdate];
}
-(void)setAttributedContent:(NSMutableAttributedString *)attributedContent{
    _attributedContent = attributedContent;
    [self contentNeedUpdate];
}
-(void)setTextAlignment:(NSTextAlignment)textAlignment{
    _textAlignment = textAlignment;
    [self contentNeedUpdate];
}
-(void)setTitleColor:(UIColor *)color forState:(zZZControlState)state{
    zZZButtonDispalyObj *obj = [[zZZButtonDispalyObj alloc]init];
    obj.color = color;
    obj.state = state;
    obj.event = zZZEnventTypeTitleColor;
    [self.eventSet addObject:obj];
}
-(void)setBackgroundColor:(UIColor *)color forState:(zZZControlState)state{
    zZZButtonDispalyObj *obj= [[zZZButtonDispalyObj alloc]init];
    obj.color = color;
    obj.state = state;
    obj.event = zZZEnventTypeBackground;
    [self.eventSet addObject:obj];
    if (state == zZZControlStateNormal) {
        self.backgroundColor = color;
    }
}
-(void)setImage:(UIImage *)image forState:(zZZControlState)state{
    zZZButtonDispalyObj *obj= [[zZZButtonDispalyObj alloc]init];
    obj.image = image;
    obj.state = state;
    obj.event = zZZEnventTypeBackImage;
    [self.eventSet addObject:obj];
}
-(void)addTarget:(nullable id)target action:(SEL)action{
    self.target = target;
    self.action = action;
}
-(void)click{
    if ([self.target respondsToSelector:self.action]) {
        [self.target performSelector:self.action withObject:self afterDelay:0.0];
    }
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
        if (!self.title.length) {
            return;
        }
        [weakSelf drawInContext:context withSize:size];
    }];
    
    [displayTask setDidDisplay:^(CALayer * _Nonnull layer, BOOL isFinish) {
        
    }];
    
    return displayTask;
}

- (void)drawInContext:(CGContextRef)context withSize:(CGSize)size {
    //设置context的ctm，用于适应core text的坐标体系
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //计算属性
    if (!self.title) {
        self.title = @"";
    }
    NSMutableAttributedString *attstring;
    if (self.attributedContent) {
        attstring = self.attributedContent;
    }else{
        attstring =[[NSMutableAttributedString alloc]initWithString:self.title];
    }
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    if (self.textAlignment) {
        paragraphStyle.alignment=self.textAlignment;//文字居中
    }else{
        paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    }
    [attstring addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.title.length)];

    if (self.titleFont) {
        [attstring addAttribute:NSFontAttributeName value:self.titleFont range:NSMakeRange(0, self.title.length)];
    }else{
        [attstring addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, self.title.length)];
    }

    for (zZZButtonDispalyObj *obj in self.eventSet) {
        if (obj.state == self.currentState) {
            switch (obj.event) {
                case zZZEnventTypeTitleColor:{
                    [attstring addAttribute:(id)kCTForegroundColorAttributeName
                                                              value:(id)obj.color.CGColor
                                                              range:NSMakeRange(0, self.title.length)];
                }
                    break;
                case zZZEnventTypeBackground:{
                }
                    break;
                case zZZEnventTypeBackImage:{
                    [self drawRadius:context size:size radius:self.radius image:obj.image];
                }
                    break;
                default:
                    break;
            }
        }
    }
    CGFloat t = [self titleHeight:self.title fontSize:self.titleFont constrainWidth:size.width];
    if (t < size.height) {
        t = (size.height - t)/2;
    }else{
        t = 0;
    }
    //设置CTFramesetter
    CTFramesetterRef framesetter =  CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attstring);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, -t, size.width, size.height));
    //创建CTFrame
    CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    
    CTFrameDraw(ctFrame, context);

    CGContextRestoreGState(context);
    CFRelease(framesetter);
    if (path) {
        CGPathRelease(path);
    }
    if (ctFrame) {
        CFRelease(ctFrame);
    }
}

-(CGFloat)titleHeight:(NSString *)text fontSize:(UIFont *)font constrainWidth:(CGFloat)width{
    if ([text isEqualToString:@""] || text == nil){return 0.f;}
    if (font == nil) {
        font = [UIFont systemFontOfSize:14];
    }
    CGFloat height = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size.height ;
    return ceilf(height) ;
}

- (void) setPressed:(BOOL)pressed
{
    _pressed = pressed;
    if (pressed) {
        self.currentState = zZZControlStateHighlighted;
    } else {
        self.currentState = zZZControlStateNormal;
    }
    if (self.eventSet.count > 0){
        [self contentNeedUpdate];
        [self DispalyBackgroundColor];
    }
}
-(void)DispalyBackgroundColor{
    BOOL isDisplayDefultBackGround = YES;
    for (zZZButtonDispalyObj *obj in self.eventSet) {
        if (obj.event == zZZEnventTypeBackground && obj.state == zZZControlStateNormal) {
            isDisplayDefultBackGround = NO;
        }
        if (obj.state == self.currentState) {
            switch (obj.event) {
                case zZZEnventTypeTitleColor:{
                }
                    break;
                case zZZEnventTypeBackground:{
                    self.backgroundColor = obj.color;
                }
                    break;
                default:
                    break;
            }
        }
    }
    if (isDisplayDefultBackGround) {
        self.backgroundColor = defultbackGroundColor;
    }
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.pressed = YES;
}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.pressed = NO;
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.pressed = NO;
    [self click];
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 计算滑动区域,超过限定额度则取消
    CGPoint p = [[[event allTouches] anyObject] locationInView:self];
    CGSize size = self.frame.size;
    if (p.x < 0 || p.x > size.width || p.y < 0 || p.y > size.height) {
        self.pressed = NO;
    }
}
@end
@implementation zZZButtonDispalyObj

@end
