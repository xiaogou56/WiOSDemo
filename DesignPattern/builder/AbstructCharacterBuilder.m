//
//  CharacterBuilder.m
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "Character.h"
#import "AbstructCharacterBuilder.h"

@implementation AbstructCharacterBuilder
- (instancetype) init
{
    self = [super init];
    if(self)
    {
        // 角色对象的创建一般在初始化方法中直接创建好；
        // 在其他语言中，因为这个类本身是个抽象类，所以角色对象的初始化是在concrete builder的初始化方法中；
        _character = [[Character alloc] init];
    }
    return self;
}

/**
 * 说明：该函数也可以直接返回void，返回instancetype *是为了支持链式调用；
 */
- (AbstructCharacterBuilder *)buildProtection:(float)pvalue
{
    _character.protection = pvalue;
    return self;
}

- (AbstructCharacterBuilder *)buildStregth:(float)pvalue
{
    _character.strength = pvalue;
    return self;
}
@end
