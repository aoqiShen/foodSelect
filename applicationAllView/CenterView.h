//
//  CenterView.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectButton.h"
@interface CenterView : UIView

+(CenterView *)instanceCenterViewWithType:(NSString*)type;

@property (strong, nonatomic) IBOutlet UIImageView *role;
@property (strong, nonatomic) IBOutlet UIImageView *foodView;
@property (strong, nonatomic) IBOutlet UILabel *foodDesc;
@property (strong, nonatomic) IBOutlet SelectButton *switchBtn;


@end
