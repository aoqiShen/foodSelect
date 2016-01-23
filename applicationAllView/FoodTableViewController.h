//
//  FoodTableViewController.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodTableViewController.h"
#import "FoodTableViewCell.h"
#import "FoodModel.h"
#import "EditFoodView.h"

@interface FoodTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    EditFoodView *_editFoodView;
}
@property (strong, nonatomic) IBOutlet UITableView *foodTableView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;

@property (strong, nonatomic) FoodTableViewCell *foodTableViewCell;
@property (strong, nonatomic) UIImageView *foodImageView;
@property (strong, nonatomic) NSMutableArray *foodDic;
@property (strong, nonatomic) FoodModel *foodModel;
@property (strong, nonatomic) EditFoodView *editFoodView;

//+ (EditFoodView*)getEditFoodView;
-(void)pushImageView;
@end
