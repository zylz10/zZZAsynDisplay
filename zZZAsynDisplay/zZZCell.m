//
//  zZZCell.m
//  zZZAsynDisplay
//
//  Created by zhangyiling on 17/6/6.
//  Copyright © 2017年 zhangyiling. All rights reserved.
//

#import "zZZCell.h"
#import "zZZButton.h"
#import "zZZImageView.h"

@implementation zZZCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self initView];
    
    return self;
}
-(void)initView{

    float y = 10;
    float x = 10;
    zZZButton *btn = [[zZZButton alloc]initWithFrame:CGRectMake(x, y, 80, 80)];
    [btn setImage:[UIImage imageNamed:@"icon2"] forState:zZZControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon1"] forState:zZZControlStateHighlighted];
    [btn setTitle:@"你好"];
    btn.titleFont = [UIFont systemFontOfSize:26];
    [self.contentView addSubview:btn];
    x += btn.frame.size.width + 10;
    
    zZZImageView *img =[[zZZImageView alloc]initWithFrame:CGRectMake(x, y, 80, 80)];
    [img setImage:[UIImage imageNamed:@"icon2"]];
    [self.contentView addSubview:img];
    
    
//    zZZButton *btn = [[zZZButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    btn.textAlignment = NSTextAlignmentCenter;
//    btn.titleFont = [UIFont systemFontOfSize:16];
//    btn.title = @"标题标题标题标题";
//    btn.radius = 50;
//    [btn addTarget:self action:@selector(shijian:)];
//    //        [btn setBackgroundColor:[UIColor redColor] forState:zZZControlStateHighlighted];
//    //        [btn setBackgroundColor:[UIColor grayColor] forState:zZZControlStateNormal];
//    [btn setTitleColor:[UIColor greenColor] forState:zZZControlStateHighlighted];
//    [btn setTitleColor:[UIColor orangeColor] forState:zZZControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"icon1"] forState:zZZControlStateHighlighted];
//    [btn setImage:[UIImage imageNamed:@"icon2"] forState:zZZControlStateNormal];
//    [self.contentView addSubview:btn];
//
//    zZZImageView *imageView =[[zZZImageView alloc]initWithFrame:CGRectMake(100, 0, 100, 100)];
//    imageView.image = [UIImage imageNamed:@"icon2"];
//    imageView.radius = 30;
//    [self.contentView addSubview:imageView];
}
-(void)shijian:(zZZButton *)btn{
    NSLog(@"点击事件 = %@",btn);
}
@end
