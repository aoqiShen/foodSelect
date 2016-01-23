//
//  FileUtil.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/20.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FoodModel.h"
@interface FileUtil : NSObject

@property NSCache *imageList;
@property NSCache *fileList;
@property NSCache *foodList;
@property NSString *uploadImageUrl;
@property NSString *uploadImageName;
+(FileUtil *)getInstance;
-(void) changeUploadImage:(NSString*) imageName;
-(void) changeUploadImageUrl:(NSString *)imageNameUrl;
-(void) addFilePath :(NSString *)filePath withFileName : (NSString*)fileName;
-(void) addImageList:(UIImage *)image withFoodName:(NSString *)foodName;
-(void) addFoodList :(FoodModel*)foodModel withFoodName:(NSString*)foodName;
-(UIImage*) getImageWithFoodName:(NSString*)foodName;
-(NSString *) getUploadImageUrl;
-(NSString *) getUploadImageName;
-(UIImage*)createCurrentImage;
@end
