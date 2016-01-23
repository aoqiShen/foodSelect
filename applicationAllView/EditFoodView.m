//
//  EditFoodView.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/14.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "EditFoodView.h"
#import "FoodModel.h"
#import "ImageViewController.h"
#import "FoodTableViewController.h"
#import "FileUtil.h"
@implementation EditFoodView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancel:(id)sender {
    self.hidden = YES;
}


- (IBAction)submitFoodView:(id)sender {
    
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    //food文件列表
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"foodList.plist"];
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    FoodModel *food = [[FoodModel alloc]init];
    [food createFoodModelByFoodName:self.foodName.text withFoodDesc:nil];
    [data addObject:food];
    //回写plist文件
    [data writeToFile:plistPath atomically:YES];
    
}


- (IBAction)selectFoodView:(id)sender {
    [[self viewController]pushImageView];
}

-(void)setImage:(UIImage*)image{
    [_defaultFoodView setImage:image];
}

-(void)reFreshEditView{
    [_defaultFoodView setImage:[[FileUtil getInstance]createCurrentImage]];
    [self setNeedsDisplay];
}
#pragma mark 返回主VC
- (FoodTableViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (FoodTableViewController*)nextResponder;
        }
    }
    return nil;
}



//- (IBAction)returnBackGroud:(id)sender {
////    [_foodName resignFirstResponder];
//}

- (IBAction)returnView:(id)sender {
    [self resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {  // 这个方法是UITextFieldDelegate协议里面的
    NSLog(@"textFieldShouldReturn the keyboard *** %@ ",theTextField.text);
    if (theTextField == _foodName) {
        [theTextField resignFirstResponder]; //这句代码可以隐藏 键盘
    }
    return YES;
}
- (IBAction)commitFoodView:(id)sender {
    NSString *foodName = _foodName.text;
    NSString *foodImageUrl = [[FileUtil getInstance] getUploadImageUrl];
    UIImage *image = _defaultFoodView.image;
    [[FileUtil getInstance]addFilePath:foodImageUrl withFileName:foodName];
    FoodModel *food = [[FoodModel alloc]init];
    [food createFoodModelByFoodName:foodName withFoodDesc:nil];
    [[FileUtil getInstance]addFoodList:food withFoodName:foodName];
    [[FileUtil getInstance]addImageList:image withFoodName:foodName];
    
}

@end
