//
//  YimaiPayManager.h
//  YMPayHandlerDemo
//
//  Created by 张锐 on 2016/10/21.
//  Copyright © 2016年 张锐. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WXApi.h>

/** 支付工具类 */
@interface YimaiPayManager : NSObject<WXApiDelegate>

/** 单例 */
+ (instancetype)sharedManager;

/** 微信支付 */
- (void)wxPay;

@end
