//
//  BB_cwSearch.h
//  YunBu
//
//  Created by Sundear on 16/10/13.
//  Copyright © 2016年 谢鑫. All rights reserved.
//
#define  kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define  kScreenHeight  [[UIScreen mainScreen] bounds].size.height

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIView+MJExtension.h"
#import "UIButton+Block.h"

@interface BB_cwSearch : UIView<UISearchBarDelegate>{
    UIView *Search;
}

@property (nonatomic,copy) void (^Click_Search)(NSString *str);
@property __strong BB_cwSearch *weakSelf;


-(void)show:(NSString*)bar_str placeholder:(NSString*)bar_warn;

//Factory

+(void)UI_Search:(NSString*)str warn:(NSString*)warn back:(void(^)(NSString*str))click;


@end
