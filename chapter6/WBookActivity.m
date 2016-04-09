//
//  WBookActivity.m
//  WiOSDemo
//
//  Created by Wayne on 16/2/20.
//  Copyright © 2016年 Wayne. All rights reserved.
//

#import "WBookActivity.h"

@interface WBookActivity ()
@property(nonatomic, strong)NSURL *iurl;//instance method
@end
@implementation WBookActivity
-(NSString *)activityType
{
    return NSStringFromClass(self.class);
}

-(NSString *)activityTitle
{
    return @"Open Book";
}

-(UIImage *)activityImage
{
    return [UIImage imageNamed:@"img-test.png"];
}

-(BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id actItem in activityItems)
    {
        if([actItem isKindOfClass:[NSURL class]])
        {
            return YES;
        }
    }
    return NO;
}

-(void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id actItem in activityItems)
    {
        if([actItem isKindOfClass:[NSURL class]])
        {
            self.iurl = actItem;
            break;
        }
    }

}

-(void)performActivity
{
    NSLog(@"%s", __FUNCTION__);
    BOOL bRet = [[UIApplication sharedApplication] openURL:self.iurl];
    [self activityDidFinish:bRet];
}
@end
