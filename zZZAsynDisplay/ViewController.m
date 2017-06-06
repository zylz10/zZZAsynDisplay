//
//  ViewController.m
//  zZZAsynDisplay
//
//  Created by zhangyiling on 17/6/6.
//  Copyright © 2017年 zhangyiling. All rights reserved.
//

#import "ViewController.h"
#import "zZZCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"zZZCell";
    zZZCell *cell = (zZZCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell) {
        cell = [[zZZCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] ;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
@end
