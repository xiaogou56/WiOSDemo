//
//  WDemoCellInfo.h
//  WiOSDemo
//
//  Created by xiaowei.li on 16/2/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WDemoCellMapSelector(strTitle, strMethod) [WDemoCellInfo cellTitle:(strTitle) target:self sel:@selector(strMethod) userInfo:nil]
#define WDemoGetCellTitle(arrItem) ((WDemoCellInfo *)arrItem).title
#define WDemoDoCell(arrItem) \
_Pragma("clang diagnostic push")                                        \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")     \
{WDemoCellInfo *info = (WDemoCellInfo *)arrItem;                        \
[info.target performSelector:info.sel withObject:info.userInfo];}       \
_Pragma("clang diagnostic pop")

@interface WDemoCellInfo : NSObject
@property (nonatomic, strong)NSString   *title;
@property (nonatomic, assign)id         target;
@property (nonatomic, assign)SEL        sel;
@property (nonatomic, strong)id         userInfo;

+ (WDemoCellInfo *)cellTitle:(NSString *)strTitle target:(id)target sel:(SEL)sel userInfo:(id) userInfo;
@end
