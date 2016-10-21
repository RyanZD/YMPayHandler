//
//  YimaiPayManager.m
//  YMPayHandlerDemo
//
//  Created by 张锐 on 2016/10/21.
//  Copyright © 2016年 张锐. All rights reserved.
//

#import "YimaiPayManager.h"

@implementation YimaiPayManager

/** 单例 */
+ (instancetype)sharedManager{

    static YimaiPayManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[YimaiPayManager alloc]init];
    });
    return sharedInstance;
}

#pragma mark - 微信支付相关
/** 微信支付 */
- (void)wxPay{

    //测试数据 -- 假数据 来自wxDemo  一次性的
    /*
     {
     appid = wxb4ba3c02aa476ea1;
     noncestr = fead6f555e77e0cb0da72c0265c1d001;
     package = "Sign=WXPay";
     partnerid = 1305176001;
     prepayid = wx20161013155503a11ffea9bc0082940286;
     sign = 55DFD1A437FDCCE9D37979316DEE2ABF;
     timestamp = 1476345303;
     }
     */
    NSDictionary *dict = @{
                           @"appid":@"wxb4ba3c02aa476ea1",
                           @"noncestr":@"fead6f555e77e0cb0da72c0265c1d001",
                           @"package":@"Sign=WXPay",
                           @"partnerid":@"1305176001",
                           @"prepayid":@"wx20161013155503a11ffea9bc0082940286",
                           @"sign":@"55DFD1A437FDCCE9D37979316DEE2ABF",
                           @"timestamp":@"1476345303"
                           };
    NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = [dict objectForKey:@"partnerid"];
    req.prepayId            = [dict objectForKey:@"prepayid"];
    req.nonceStr            = [dict objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [dict objectForKey:@"package"];
    req.sign                = [dict objectForKey:@"sign"];
    [WXApi sendReq:req];
}

/** 微信支付回调 */
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}


@end