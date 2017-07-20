//
//  ViewController.m
//  MFU_Search
//
//  Created by Sundear on 16/10/31.
//  Copyright © 2016年 xiexin. All rights reserved.
//

#import "ViewController.h"


#import "BB_cwSearch.h"
#import "SQ_shareUI.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SQ_shareUI *ui=[SQ_shareUI new];
    [ui showTitle:@"gg" describe:@"123" image:[UIImage imageNamed:@""] Url:@"www.baidu.com"];
    /*[BB_cwSearch UI_Search:@"nice" warn:@"请输入查询的手机号" back:^(NSString*str){
        NSLog(@"%@",str);
    }];*/
}

@end
