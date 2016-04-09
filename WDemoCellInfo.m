//
//  WDemoCellInfo.m
//  WiOSDemo
//
//  Created by xiaowei.li on 16/2/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "WDemoCellInfo.h"

@implementation WDemoCellInfo
+ (WDemoCellInfo *)cellTitle:(NSString *)strTitle target:(id)target sel:(SEL)sel userInfo:(id) userInfo
{
    WDemoCellInfo *obj = [[WDemoCellInfo alloc] init];
    obj.title = strTitle;
    obj.target = target;
    obj.sel = sel;
    obj.userInfo = userInfo;
    return obj;
}
@end
