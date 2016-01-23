//
//  NSUtil.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/20.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "NSUtil.h"

@implementation NSUtil
+(NSString *)ret32bitString

{
    
    char data[32];
    
    for (int x=0;x<32;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
    
}

@end
