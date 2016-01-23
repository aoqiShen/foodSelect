
//  ImageViewController.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/18.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "ImageViewController.h"
#import "NSUtil.h"
#import "FileUtil.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
@interface ImageViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property UIImageView *imageView;
@property UIImageView *imageviewFrame;
@property UIImagePickerController *imagePicker;
@end

@implementation ImageViewController
@synthesize  imageView,imageviewFrame;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 160, 40)];
    [button setTitle:@"点击测试相机" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(imagefun) forControlEvents:UIControlEventTouchUpInside];
    imageviewFrame =[[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 200, 200)];
    [self.view addSubview:imageviewFrame];
}

-(void)imagefun
{
    UIActionSheet *action=[[UIActionSheet alloc]initWithTitle:@"选择功能" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"相册",nil];
    [action showInView:self.view];
}

//actionsheet 总共有两个功能，相册和相机
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //主要是使用这个controller
    UIImagePickerController *pick=[[UIImagePickerController alloc]init];
    if (buttonIndex==0) {
        NSLog(@"相机");
        //判断相机是否可用,因为模拟机是不可以的
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self pickImageFromCamera];
        }
        else
        {
            NSLog(@"相机不可用");
        }
    }
    else if (buttonIndex==1)
    {
        NSLog(@"相册");
        //判断相册是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [self pickImageFromAlbum];
        }
        else
        {
            NSLog(@"相册不可用");
        }
    }
    else
    {
        NSLog(@"取消");
    }
}

#pragma mark getPickerControllerPhoto
- (void)pickImageFromAlbum
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = YES;
    
    [self presentModalViewController:_imagePicker animated:YES];
}
#pragma mark getPickControllerCamera
- (void)pickImageFromCamera
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = YES;
    _imagePicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:_imagePicker animated:YES];
}

///代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    //    随机生成文件名
    
    if(!image){
        __block NSString *fileName;
        __block NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            fileName = [representation filename];
            NSLog(@"fileName : %@",fileName);
        };
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];
        [self saveImage:image withName:fileName];
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
        self.imageView = [[UIImageView alloc]init];
        [self.imageView setImage:savedImage];
        
        
        [[FileUtil getInstance]changeUploadImage:fileName];
    }
//    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[NSUtil ret32bitString]];
    
    [picker dismissViewControllerAnimated:true completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:^{}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
