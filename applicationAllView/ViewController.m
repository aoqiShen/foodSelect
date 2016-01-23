//
//  ViewController.m
//  applicationAllView
//
//  Created by 王小亮 on 15/12/30.
//  Copyright © 2015年 王小亮. All rights reserved.
//

#import "ViewController.h"
#import "MoveView.h"
#import "SelectFoodView.h"
#import "SelectButton.h"
#import "CenterView.h"
#import "FoodTableViewController.h"
#define space 50
@interface ViewController ()
@property(strong,nonatomic)FoodTableViewController *foodTableViewController;
@end

@implementation ViewController
@synthesize foodView,foodDesc,switchBtn,role,mainViewNavigation;
- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"search.png"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(goToFoodEditView:) forControlEvents:UIControlEventTouchUpInside];
    mainViewNavigation.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    CenterView *centerView = [[CenterView alloc]initWithFrame:self.view.frame];
    centerView = [CenterView instanceCenterViewWithType:@""];
    [self.view addSubview:centerView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)goToFoodEditView:(id)sender{
    _foodTableViewController = [[FoodTableViewController alloc] initWithNibName:@"FoodTableViewController" bundle:nil];;
    [self.navigationController pushViewController:_foodTableViewController animated:true];
}


//-(void)imageChange:(id)sender{
//    SelectButton *btn = (SelectButton*)sender;
//    if (!btn.START) {
//        //开始动画
//        [self.foodView startAnimating];
//        btn.START = true;
//        [btn setTitle:@"选择中" forState:UIControlStateNormal];
//    }
//    else{
//        [self.foodView stopAnimating];
//        btn.START = false;
//        [btn setTitle:@"开始选择" forState:UIControlStateNormal];
//    }
//}




@end
