//
//  PeopleView.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/6.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "PeopleView.h"

@implementation PeopleView
@synthesize viewName;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithImage:(UIImage *)image{
    if (viewName) {
        self = [super initWithImage:image];
        return self;
    }
    return [super initWithImage:image];
}

@end
