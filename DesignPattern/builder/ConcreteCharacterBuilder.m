//
//  StandardCharacterBuilder.m
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "ConcreteCharacterBuilder.h"

@implementation ConcreteCharacterBuilder
- (AbstructCharacterBuilder *)buildProtection:(float)pvalue
{
    self.character.protection = pvalue * 2;
    return self;
}

- (AbstructCharacterBuilder *)buildStregth:(float)pvalue
{
    self.character.strength = pvalue / 3.0;
    return self;
}
@end
