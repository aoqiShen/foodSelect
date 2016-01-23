//
//  SelectButton.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/8.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "SelectButton.h"

@implementation SelectButton
@synthesize START;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)startChangeView{
    [NSThread detachNewThreadSelector:@selector(changeView:) toTarget:self withObject:nil];
}

-(void)changeView{
    NSArray *image = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"eat.jpg"]];
}
@end
