//
//  Character.h
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Character就是客户最终想要的东西，东西就是东西，它只有几个属性，当然可以给上初始值
 */
@interface Character : NSObject
@property (nonatomic, assign) float protection;
@property (nonatomic, assign) float strength;
@end
