//
//  SQ_shareUI.h
//  MFU_Search
//
//  Created by Sundear on 16/11/1.
//  Copyright © 2016年 xiexin. All rights reserved.
//
#define  kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define  kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#import <UIKit/UIKit.h>
#import "UIButton+Block.h"
#import "UIView+TouchEventBlock.h"
@interface SQ_shareUI : UIView{
    UIView *basicUI;
}

@property (nonatomic,copy) void (^Click_Search)(NSString *str);
@property __strong SQ_shareUI *weakself;

-(void)showTitle:(NSString*)ttile describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url;


-(void)weixinTitle:(NSString*)title describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url Type:(int)type;
-(void)QQTitle:(NSString*)title describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url;

@end