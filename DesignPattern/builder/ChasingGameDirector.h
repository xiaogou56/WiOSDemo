//
//  ChasingGameDirector.h
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"
#import "AbstructCharacterBuilder.h"

@interface ChasingGameDirector : NSObject
// 同样的，我们还可以再添加一个创建Enemy的方法，另外我们也可以直接新增一个enemy的concrete builder来实现此功能，只不过在这里没有太大意义；
- (Character *)createPlayer:(AbstructCharacterBuilder *)builder;
@end
