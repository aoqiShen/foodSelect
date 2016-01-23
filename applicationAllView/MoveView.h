//
//  MoveView.h
//  applicationAllView
//
//  Created by 王小亮 on 15/12/30.
//  Copyright © 2015年 王小亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveView : UIImageView
@property CGPoint startLocate;
@property CGRect sourceRect;
@property NSString *mainIamge;
@property NSMutableDictionary *imageList;
@property (assign, nonatomic) UIBackgroundTaskIdentifier backgroundUpdateTask;
@end

