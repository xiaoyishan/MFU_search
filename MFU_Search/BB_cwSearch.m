//
//  BB_cwSearch.m
//  YunBu
//
//  Created by Sundear on 16/10/13.
//  Copyright © 2016年 谢鑫. All rights reserved.
//

#import "BB_cwSearch.h"



@implementation BB_cwSearch

+(void)UI_Search:(NSString*)str warn:(NSString*)warn back:(void(^)(NSString*str))click{
    BB_cwSearch *view=[[BB_cwSearch alloc]init];
    view.Click_Search=^(NSString *str){
        click(str);
//        NSLog(@"block 接收的内容:%@",str);
    };[view show:str placeholder:warn];
}

-(void)show:(NSString*)bar_str placeholder:(NSString*)bar_warn{
    _weakSelf=self;Search=nil;
    [[UIApplication sharedApplication] setStatusBarStyle:0 animated:NO];//状态栏
    
    Search=[[NSBundle mainBundle] loadNibNamed:@"BB_cwSearch" owner:nil options:nil].firstObject;
    Search.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:Search];

    UISearchBar *Bar=[Search viewWithTag:100];
    Bar.delegate=self;
    [Bar becomeFirstResponder];
    Bar.text=bar_str;
    Bar.placeholder=bar_warn;
    
    Bar.superview.mj_y=-64;
    Search.alpha=0;
    [UIView animateWithDuration:.25 animations:^(void){
        Bar.superview.mj_y=0;
        Search.alpha=1;
    }];
    
    //浅灰背景
    UIButton *litebc=[Search viewWithTag:500];
    [litebc addAction:^(UIButton*B){[self dismiss];}];

    

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self dismiss];
    if(_Click_Search)_Click_Search(searchBar.text);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismiss];
}



-(void)dismiss{
    UISearchBar *Bar=[Search viewWithTag:100];
    UIButton *litebc=[Search viewWithTag:500];
    
    [UIView animateWithDuration:.25 animations:^(void){
        Bar.superview.mj_y=-64;
        litebc.alpha=0;
    }completion:^(BOOL Finish){
        [[UIApplication sharedApplication] setStatusBarStyle:1 animated:NO];
        [Search removeFromSuperview];
    }];
    
}


@end
