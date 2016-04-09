//
//  CharacterBuilder.h
//  WiOSDemo
//
//  Created by Wayne on 16/3/22.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

/**
 * 在其他语言里面，这个类其实是个抽象类或者接口，只定义了一些抽象方法，没有实现，但iOS不支持这种特性，所以可以简单的赋值。
 */
@interface AbstructCharacterBuilder : NSObject
@property (nonatomic, readonly, strong) Character *character;

- (AbstructCharacterBuilder *)buildProtection:(float)pvalue;
- (AbstructCharacterBuilder *)buildStregth:(float)pvalue;
@end
