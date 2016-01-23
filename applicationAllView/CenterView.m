//
//  CenterView.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "CenterView.h"

@implementation CenterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (IBAction)StartViewOrStopView:(id)sender {
    SelectButton *btn = (SelectButton*)sender;
        if (!btn.START) {
            //开始动画
            [self.foodView startAnimating];
            btn.START = true;
            [btn setTitle:@"选择中" forState:UIControlStateNormal];
        }
        else{
            [self.foodView stopAnimating];
            btn.START = false;
            [btn setTitle:@"开始选择" forState:UIControlStateNormal];
        }
}

+(CenterView *)instanceCenterViewWithType:(NSString *)type{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"View" owner:nil options:nil];
    CenterView *cv =[nibView objectAtIndex:0];
    cv.role.image = [UIImage imageNamed:@"eat.jpg"];
    NSArray *imageList = [NSArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"eat.jpg"],nil];
    cv.foodView.image = [UIImage imageNamed:@"eat.jpg"];
    cv.foodView.contentMode = UIViewContentModeScaleToFill;
    cv.foodView.animationImages = imageList;
        //按照原始比例缩放图片，保持纵横比
    cv.foodView.contentMode = UIViewContentModeScaleAspectFit;
        //切换动作的时间3秒，来控制图像显示的速度有多快，
    cv.foodView.animationDuration = 1;
        //动画的重复次数，想让它无限循环就赋成0
    cv.foodView.animationRepeatCount = 0;
        //默认为停止自动播放状态
    [cv.foodView stopAnimating];
    cv.foodDesc.text = @"厨师";
    cv.switchBtn.titleLabel.text = @"开始选择";
    
    return cv;
    
}
@end
