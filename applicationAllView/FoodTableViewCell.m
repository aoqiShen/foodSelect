//
//  FoodTableViewCell.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "FoodTableViewCell.h"
#import "FileUtil.h"
@implementation FoodTableViewCell
@synthesize food,foodDesc;
- (void)awakeFromNib {
    // Initialization code
}

-(void)layoutSubviews{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)createTableViewCell:(NSString *)foodName{
    self.food.image = [[FileUtil getInstance]getImageWithFoodName:foodName];
    self.foodDesc.text = foodName;
}
@end
