//
//  FoodTableViewCell.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *food;
@property (strong, nonatomic) IBOutlet UILabel *foodDesc;
- (void)createTableViewCell:(NSString *)foodName;
@end
