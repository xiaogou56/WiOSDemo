//
//  WThirdVC.m
//  WiOSDemo
//
//  Created by xiaowei.li on 16/2/20.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "WThirdVC.h"
#import "WDemoCellInfo.h"
#import "WBookActivity.h"
#import <Social/Social.h>
#import "QQSDKDef.h"
#import "QQSDKCall.h"
#import "TencentOpenAPI/QQApiInterface.h"

@interface WThirdVC()
@property(nonatomic, strong)NSMutableArray *imarrDataSource;
@property(nonatomic, assign)BOOL            isLogined;
@end

@implementation WThirdVC
- (void)viewDidLoad
{
    self.title = @"Navi Title";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TeleplayPlayTableCell"];
    self.imarrDataSource = [[NSMutableArray alloc] init];
    [self.imarrDataSource addObjectsFromArray:@[
                                                WDemoCellMapSelector(@"UIActivityViewController", doShare),
                                                WDemoCellMapSelector(@"WBookActivity", doBookActivity),
                                                WDemoCellMapSelector(@"SLComposeViewController", doSLComposeVC),
                                                WDemoCellMapSelector(@"QQSDK_OpenAPI", doQQSDK_OpenAPI),
                                                WDemoCellMapSelector(@"QQSDK_getUserInfo", doQQGetUserInfo),
                                                WDemoCellMapSelector(@"QQSDK_Share", doQQShare),
                                                WDemoCellMapSelector(@"QQSDK_Send", doQQSend),
                                                WDemoCellMapSelector(@"CFNetwork_HTTP", doCFHTTPRequest)
                                                ]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessed) name:kLoginSuccessed object:[QQSDKCall getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailed) name:kLoginFailed object:[QQSDKCall getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCancelled) name:kLoginCancelled object:[QQSDKCall getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kGetUserInfoResponse object:[QQSDKCall getInstance]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(analysisResponse:) name:kAddTopicResponse object:[QQSDKCall getInstance]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imarrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCellIdentifier = @"TeleplayPlayTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellIdentifier forIndexPath:indexPath];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCellIdentifier];
    }
    cell.textLabel.text = WDemoGetCellTitle(self.imarrDataSource[indexPath.row]);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WDemoDoCell([self.imarrDataSource objectAtIndex:indexPath.row]);
}

- (void)doShare
{
    NSString *strText = @"title";
    UIImage *img = [UIImage imageNamed:@"img-test.png"];
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *arr = @[strText, img, url];
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
    actVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeAddToReadingList];
    [self presentViewController:actVC animated:YES completion:^{
    }];
}

- (void)doBookActivity
{
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSArray *arrActivityItems = @[url];
    WBookActivity *activityBook = [WBookActivity new];
    NSArray *arrApplicationActivities = @[activityBook];
    UIActivityViewController *actVC = [[UIActivityViewController alloc] initWithActivityItems:arrActivityItems
                                                                        applicationActivities:arrApplicationActivities];
    [self presentViewController:actVC animated:YES completion:^{
    }];
}

- (void)doSLComposeVC
{
    SLComposeViewController *composeViewController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler = ^(SLComposeViewControllerResult result){
            [composeViewController dismissViewControllerAnimated:YES completion:nil];
            switch(result)
            {
                case SLComposeViewControllerResultCancelled:
                default:
                    NSLog(@"Cancelled.....");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Posted....");
                    break;
            }
        };
        [composeViewController addImage:[UIImage imageNamed:@"img-test.png"]];
        [composeViewController setInitialText:@"春节期间，大家好好学习，开开心心，天天向上"];
        [composeViewController addURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        [composeViewController setCompletionHandler:completionHandler];
        //模态视图呈现，如果是iPad则要Popover视图呈现
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)doQQSDK_OpenAPI
{
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    [[QQSDKCall getInstance].oauth authorize:permissions inSafari:NO];
}

- (void)doQQGetUserInfo
{
    if (NO == [[[QQSDKCall getInstance] oauth] getUserInfo])
    {
        [QQSDKCall showInvalidTokenOrOpenIDMessage];
    };
}

- (void)doQQShare
{
    QQApiNewsObject* imgObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:@"http://wiki.open.qq.com/wiki/"]
                                                       title:@"title"
                                                 description:@"description"
                                             previewImageURL:[NSURL URLWithString:@"http://img1.gtimg.com/sports/pics/hv1/87/16/1037/67435092.jpg"]];
    [imgObj setCflag:kQQAPICtrlFlagQZoneShareOnStart];
    SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:imgObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

- (void)doQQSend
{
    QQApiTextObject *textObj = [QQApiTextObject objectWithText:@"test"];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:textObj];
    QQApiSendResultCode sent = [QQApiInterface sendReq:req];
    [self handleSendResult:sent];
}

- (void)loginSuccessed
{
    if (NO == self.isLogined)
    {
        self.isLogined = YES;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录成功" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

- (void)loginFailed
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"结果" message:@"登录失败" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
}

- (void) loginCancelled
{}

- (void)analysisResponse:(NSNotification *)notify
{
    if (notify)
    {
        APIResponse *response = [[notify userInfo] objectForKey:kResponse];
        if (URLREQUEST_SUCCEED == response.retCode && kOpenSDKErrorSuccess == response.detailRetCode)
        {
            NSMutableString *str=[NSMutableString stringWithFormat:@""];
            for (id key in response.jsonResponse)
            {
                [str appendString: [NSString stringWithFormat:@"%@:%@\n",key,[response.jsonResponse objectForKey:key]]];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功" message:[NSString stringWithFormat:@"%@",str]
                                                           delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            NSString *errMsg = [NSString stringWithFormat:@"errorMsg:%@\n%@", response.errorMsg, [response.jsonResponse objectForKey:@"msg"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败" message:errMsg delegate:self cancelButtonTitle:@"我知道啦" otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    switch (sendResult)
    {
        case EQQAPIAPPNOTREGISTED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"App未注册" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        case EQQAPIMESSAGECONTENTNULL:
        case EQQAPIMESSAGETYPEINVALID:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送参数错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTINSTALLED:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"未安装手Q" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"API接口不支持" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        case EQQAPISENDFAILD:
        {
            UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:@"Error" message:@"发送失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            [msgbox show];
            break;
        }
        default:
        {
            break;
        }
    }
}

- (void)doCFHTTPRequest
{
    CFStringRef bodyString = CFSTR(""); // Usually used for POST data
    CFStringRef headerFieldName = CFSTR("X-My-Favorite-Field");
    CFStringRef headerFieldValue = CFSTR("Dreams");
    
    CFStringRef url = CFSTR("http://www.baidu.com");
    CFURLRef myURL = CFURLCreateWithString(kCFAllocatorDefault, url, NULL);
    
    CFStringRef requestMethod = CFSTR("GET");
    CFHTTPMessageRef myRequest = CFHTTPMessageCreateRequest(kCFAllocatorDefault, requestMethod, myURL, kCFHTTPVersion1_1);
    
    CFDataRef bodyDataExt = CFStringCreateExternalRepresentation(kCFAllocatorDefault, bodyString, kCFStringEncodingUTF8, 0);
    CFHTTPMessageSetBody(myRequest, bodyDataExt);
    CFHTTPMessageSetHeaderFieldValue(myRequest, headerFieldName, headerFieldValue);
    //CFDataRef mySerializedRequest = CFHTTPMessageCopySerializedMessage(myRequest);
    
    
    CFReadStreamRef myReadStream = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, myRequest);
    CFRelease(myRequest);
    myRequest = NULL;
    CFRelease(url);
    CFRelease(myURL);
    CFReadStreamOpen(myReadStream);
    
#define kReadBufSize 1024
    NSMutableData *mdResponse = [NSMutableData data];
    CFIndex numBytesRead;
    do{
        UInt8 buf[kReadBufSize];
        numBytesRead = CFReadStreamRead(myReadStream, buf, sizeof(buf));
        if( numBytesRead > 0 )
        {
            printf("%s", buf);
            [mdResponse appendBytes:buf length:numBytesRead];
        }
        else if( numBytesRead < 0 ) {
            //CFStreamError error = CFReadStreamGetError(myReadStream);
            //reportError(error);
        }
    }while( numBytesRead > 0 );
    CFReadStreamClose(myReadStream);
    CFRelease(myReadStream);
    myReadStream = NULL;
}


@end
