//
//  FoodUITableView.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/11.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "FoodUITableView.h"
#import "FoodTableViewCell.h"
@implementation FoodUITableView
@synthesize foodTableViewCell;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleIdentify = @"SimpleIdentify";
    FoodTableViewCell *tmpCell = [tableView dequeueReusableCellWithIdentifier:simpleIdentify];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FoodTableViewCell" owner:self options:nil];
    if ([nib count]>0)
    {
        foodTableViewCell = [nib objectAtIndex:0];
        tmpCell = foodTableViewCell;
    }
    [tmpCell createTableViewCell:nil SetimageDesc:@"test"];
    return tmpCell;
}


@end
