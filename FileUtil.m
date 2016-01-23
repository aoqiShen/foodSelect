//
//  FileUtil.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/20.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileUtil.h"
@implementation FileUtil

+(FileUtil *)getInstance{
    static FileUtil *instance = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        instance = [[FileUtil alloc]init];
    });
    return instance;
}



-(void) addFilePath :(NSString *)filePath withFileName : (NSString*)fileName{
    if([_fileList objectForKey:fileName]){
        return;
    }
    [_fileList setValue:filePath forKey:fileName];
}

-(void) addImageList:(UIImage *)image withFoodName:(NSString*)foodName{
    if ([_imageList objectForKey:foodName]) {
        return;
    }
    [_imageList setValue:image forKey:foodName];
}

-(void) addFoodList :(FoodModel*)foodModel withFoodName:(NSString*)foodName{
    if([_fileList objectForKey:foodName]){
        return;
    }
    [_fileList setValue:foodModel forKey:foodName];
}

-(UIImage*) getImageWithFoodName:(NSString*)foodName{
    return [_imageList objectForKey:foodName];
}

-(void)createUploadImage{
    _uploadImageUrl = @"eat.jpg";
}
-(void) changeUploadImageUrl:(NSString*) imageUrl{
    _uploadImageUrl = imageUrl;
}
-(void) changeUploadImage:(NSString *)imageName{
    _uploadImageName = imageName;
}

-(UIImage*)createCurrentImage{
    UIImage *img = [UIImage imageWithContentsOfFile:_uploadImageUrl];
    return img;
}

-(NSString *) getUploadImageUrl{
    return _uploadImageUrl;
}
-(NSString *) getUploadImageName{
    return _uploadImageName;
}


@end
