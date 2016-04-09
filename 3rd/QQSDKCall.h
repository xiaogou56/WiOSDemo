//
//  QQSDKCall.h
//  WiOSDemo
//
//  Created by Wayne on 16/2/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>

@interface QQSDKCall : NSObject<TencentSessionDelegate, TCAPIRequestDelegate>
+ (QQSDKCall *)getInstance;
+ (void)resetSDK;
+ (void)showInvalidTokenOrOpenIDMessage;

@property (nonatomic, retain)TencentOAuth *oauth;
@end
