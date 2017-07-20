//
//  SQ_shareUI.m
//  MFU_Search
//
//  Created by Sundear on 16/11/1.
//  Copyright © 2016年 xiexin. All rights reserved.
//

#import "SQ_shareUI.h"
#import "WXApi.h"
#import "TencentOpenAPI/QQApiInterface.h"
#import "UIView+MJExtension.h"
@interface SQ_shareUI ()

@end

@implementation SQ_shareUI




-(void)showTitle:(NSString*)title describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url{
    
    _weakself=self;
    basicUI=nil;
//    [[UIApplication sharedApplication] setStatusBarStyle:0 animated:NO];//状态栏
    
    basicUI=[[NSBundle mainBundle] loadNibNamed:@"SQ_shareUI" owner:nil options:nil].firstObject;
    basicUI.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:basicUI];
    
    
    /* tag说明
     500 主界面
     501 动画主界面
     502 取消label
     
     100 微信
     101 朋友圈
     102 QQ
     
    */
    UIView *shareView =[basicUI viewWithTag:501];
    UILabel *cancelL   =[basicUI viewWithTag:502];
    UIButton *LightBC   =[basicUI viewWithTag:500];
    
    
    UIButton *weixin=[shareView viewWithTag:100];
    UIButton *pengyou=[shareView viewWithTag:101];
    UIButton *qq=[shareView viewWithTag:102];
   //商圈分享
    [weixin addAction:^(UIButton *B){
        [self weixinTitle:title describe:desc image:img Url:url Type:0];
        [self dismiss];
    }];
    [pengyou addAction:^(UIButton *B){
        [self weixinTitle:title describe:desc image:img Url:url Type:1];
        [self dismiss];
    }];
    [qq addAction:^(UIButton *B){
        [self QQTitle:title describe:desc image:img Url:url];
        [self dismiss];
    }];
    
    
    
    
    cancelL.touchesBeganBlock=^(NSSet *touches, UIEvent *event){
        [self dismiss];
    };
    [LightBC addAction:^(UIButton *B){
        [self dismiss];
    }];
    
    
    LightBC.alpha=0;
    shareView.mj_y=kScreenHeight-shareView.mj_h;
    [UIView animateWithDuration:.25 animations:^(void){
        shareView.superview.mj_y=0;
        LightBC.alpha=1;
    }];
    

    
    
    
}
-(void)weixinTitle:(NSString*)title describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url Type:(int)type{
    if (![WXApi isWXAppInstalled] && [[[UIDevice currentDevice] systemVersion] floatValue]< 9 ) {
        //[SVProgressHUD showString:@"当前微信版本过低!"];
        return;
    }
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    message.thumbData=UIImageJPEGRepresentation(img, 0.1);
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    if(type==0)req.scene = WXSceneSession;
    if(type==1)req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}
-(void)QQTitle:(NSString*)title describe:(NSString*)desc image:(UIImage*)img Url:(NSString*)url{
    NSData* data = [[NSData alloc]initWithData:UIImagePNGRepresentation(img)];
    QQApiNewsObject* image = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:desc previewImageData:data];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:image];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    if (sent!=0) {
        NSLog(@"分享失败！:%d",sent);
//        [SVProgressHUD showString:@"当前QQ版本过低!"];
    }
}



-(void)dismiss{
    UIView *LightBC   =[basicUI viewWithTag:500];
    UIView *shareView =[basicUI viewWithTag:501];
    
    [UIView animateWithDuration:.25 animations:^(void){
        LightBC.alpha=0;
        shareView.mj_y=kScreenHeight;
    }completion:^(BOOL Finish){
//        [[UIApplication sharedApplication] setStatusBarStyle:1 animated:NO];
        [basicUI removeFromSuperview];
    }];
    
}
@end
