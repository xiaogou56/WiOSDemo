//
//  QQSDKCall.m
//  WiOSDemo
//
//  Created by Wayne on 16/2/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "QQSDKCall.h"
#import "QQSDKDef.h"

static QQSDKCall *g_instance = nil;
@interface QQSDKCall ()
@property (nonatomic, retain)NSArray* permissons;
@end

@implementation QQSDKCall
- (id)init
{
    NSString *strAppId = @"222222";
    self.oauth = [[TencentOAuth alloc] initWithAppId:strAppId andDelegate:self];
    return self;
}

+ (QQSDKCall *)getInstance
{
    @synchronized(self)
    {
        if(nil == g_instance)
        {
            g_instance = [[super allocWithZone:nil] init];
        }
    }
    return g_instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getInstance];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)resetSDK
{
    g_instance = nil;
}

+ (void)showInvalidTokenOrOpenIDMessage
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"api调用失败"
                                                   message:@"可能授权已过期，请重新获取"
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
}

#pragma mark - TencentLoginDelegate(授权登录回调协议)
- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCancelled object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

#pragma mark - TencentSessionDelegate(开放接口回调协议)
- (void)tencentDidLogout
{
    
}


- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    return YES;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}


- (void)getUserInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getListPhotoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetListPhotoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)checkPageFansResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kCheckPageFansResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addShareResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddShareResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)addAlbumResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddAlbumResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)uploadPicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kUploadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addOneBlogResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddOneBlogResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)addTopicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddTopicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)setUserHeadpicResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSetUserHeadPicResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}


- (void)getVipRichInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetVipRichInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)sendStoryResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kSendStoryResponse object:self userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

- (void)tencentOAuth:(TencentOAuth *)tencentOAuth didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite userData:(id)userData
{
    
}


- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:tencentOAuth, kTencentOAuth,
                              viewController, kUIViewController, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kCloseWnd object:self  userInfo:userInfo];
}
@end
