//
//  MoveView.m
//  applicationAllView
//
//  Created by 王小亮 on 15/12/30.
//  Copyright © 2015年 王小亮. All rights reserved.
//

#import "MoveView.h"

@implementation MoveView
@synthesize startLocate,sourceRect,mainIamge,imageList;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithImage:(UIImage *)image{
    [self initImage];
    if (self = [super initWithImage:image]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
#pragma move
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject]locationInView:self];
    self.startLocate = pt;
    sourceRect = self.frame;
    self.frame = [self adjustSize:true];
    [[self superview]bringSubviewToFront:self];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint pt = [[touches anyObject]locationInView:self];
    float dx = pt.x - startLocate.x;
    float dy = pt.y - startLocate.y;
    CGPoint movePT = CGPointMake(self.center.x + dx, self.center.y + dy);
    self.center = movePT;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.frame = [self adjustSize:false];
}
//点击
//-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
// 
//}
#pragma adjustView
-(CGRect )adjustSize:(Boolean)flag{
    int indexX = self.sourceRect.size.width;
    int indexY = self.sourceRect.size.height;
    if (flag) {
        return CGRectMake(self.frame.origin.x-0.5*indexX, self.frame.origin.y-0.5*indexY, self.frame.size.width+0.5*indexX, self.frame.size.height+0.5*indexY);

    }else{
        return CGRectMake(self.frame.origin.x+0.5*indexX, self.frame.origin.y+0.5*indexY, self.frame.size.width-0.5*indexX, self.frame.size.height-0.5*indexY);
    }
    
}
-(void)initImage{
    imageList = [NSMutableDictionary dictionaryWithCapacity:10];
}
@end
