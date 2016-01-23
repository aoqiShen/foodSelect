//
//  FoodModel.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/11.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodModel : NSObject
@property NSString *foodName;
@property NSString *foodDesc;
-(void)createFoodModelByFoodName:(NSString*)foodN withFoodDesc:(NSString*)foodDesc;
@end
