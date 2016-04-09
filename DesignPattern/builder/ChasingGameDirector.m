//
//  ChasingGameDirector.m
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "ChasingGameDirector.h"

@implementation ChasingGameDirector
- (Character *)createPlayer:(AbstructCharacterBuilder *)builder
{
    [builder buildProtection:3.0];
    [builder buildStregth:2.0];
    return [builder character];
}
@end
