//
//  ViewController.h
//  applicationAllView
//
//  Created by 王小亮 on 15/12/30.
//  Copyright © 2015年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(strong,nonatomic)UIImageView *foodView;
@property(strong,nonatomic)UIImageView *role;
@property(strong,nonatomic)UILabel *foodDesc;
@property(strong,nonatomic)UIButton *switchBtn;

@property (strong, nonatomic) IBOutlet UINavigationItem *mainViewNavigation;
@end

