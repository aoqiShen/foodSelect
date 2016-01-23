//
//  EditFoodView.h
//  applicationAllView
//
//  Created by 王小亮 on 16/1/14.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditFoodView : UIView<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *foodName;
@property (strong, nonatomic) IBOutlet UIImageView *defaultFoodView;
@property (strong, nonatomic) IBOutlet UIButton *uploadFoodView;
@property (strong, nonatomic) IBOutlet UIButton *submitFood;

-(void)reFreshEditView;
-(void)setImage:(UIImage*)image;
@end
