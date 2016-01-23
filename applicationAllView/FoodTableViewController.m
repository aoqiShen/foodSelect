//
//  FoodTableViewController.m
//  applicationAllView
//
//  Created by 王小亮 on 16/1/10.
//  Copyright © 2016年 王小亮. All rights reserved.
//

#import "FoodTableViewController.h"
#import "FoodTableViewCell.h"
#import "FoodModel.h"
#import "EditFoodView.h"
#import "ImageViewController.h"
#import "FileUtil.h"
#import "NSUtil.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#define editViewX 10

@interface FoodTableViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property UIImageView *imageView;
@property UIImageView *imageviewFrame;
@property UIImagePickerController *imagePicker;
@end

@implementation FoodTableViewController
@synthesize foodTableView,foodTableViewCell,foodImageView,foodDic;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.foodModel = [[FoodModel alloc]init];
    //获取本地沙盒路径
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsPath = [path objectAtIndex:0];
    //food文件列表
    NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"foodList.plist"];
    NSLog(@"documentsPaht:%@",documentsPath);
    //没有数据的时候初始化
    if (!foodDic) {
        FoodModel *tmpFoodModel = [[FoodModel alloc]init];
        [tmpFoodModel createFoodModelByFoodName:@"race" withFoodDesc:nil];
        self.foodDic = [[NSMutableArray alloc ] init];
        [self.foodDic addObject:tmpFoodModel];
        tmpFoodModel = [[FoodModel alloc]init];
        [tmpFoodModel createFoodModelByFoodName:@"eat" withFoodDesc:nil];
        [self.foodDic addObject:tmpFoodModel];
        [self.foodDic writeToFile:plistPath atomically:true];
    }
    
    foodTableView.dataSource = self;
    foodTableView.delegate = self;
    foodTableView.rowHeight = 80;
    foodTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    foodTableView.contentMode = UIViewContentModeScaleAspectFit;
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidAppear:(BOOL)animated{
    [_editFoodView reFreshEditView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return foodDic.count;
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
    NSLog(@"%ld",(long)indexPath.row);
    self.foodModel = [foodDic objectAtIndex:indexPath.row];
    [tmpCell createTableViewCell:self.foodModel.foodName];
    return tmpCell;
}

//采用xib作为action
- (IBAction)addFood:(id)sender {
    //    重用原来的UIVIiew
    if (self.editFoodView) {
        self.editFoodView.hidden = NO;
        return;
    }
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"EditFoodView" owner:self options:nil];
    if ([nib count]>0) {
        self.editFoodView = [nib objectAtIndex:0];
    }

    NSLog(@"x:%fy:%fwidth:%fheight:%f",self.editFoodView.frame.origin.x,self.editFoodView.frame.origin.y,self.editFoodView.frame.size.width,self.editFoodView.frame.size.height);
    
    CGRect editView = CGRectMake(editViewX, 100, self.view.frame.size.width-editViewX*2, self.view.frame.size.width-editViewX*2);
    [self.editFoodView setFrame:editView];
    UIImage *image = [UIImage imageNamed:@"race.jpg"];
    [self.editFoodView setImage:image];
    NSLog(@"x:%fy:%fwidth:%fheight:%f",self.editFoodView.frame.origin.x,self.editFoodView.frame.origin.y,self.editFoodView.frame.size.width,self.editFoodView.frame.size.height);
    
    [self.view addSubview:self.editFoodView];

}

- (void)onSelectionChanged:(id)action{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)pushImageView{
    [self imagefun];
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
    
    if(image){
        __block NSString *fileName;
        __block NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            fileName = [representation filename];
            NSLog(@"从相册中获取的文件名%@",fileName);
            NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
            NSLog(@"从相册中获取的文件名对应的相册%@",fullPath);
//            UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
            [self saveImage:image withName:fileName];
        };
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];

        
    }
    //    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[NSUtil ret32bitString]];
    
    [picker dismissViewControllerAnimated:true completion:nil];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];   // 保存文件
    NSLog(@"存储图片的路径%@",filePath);
    [UIImagePNGRepresentation(currentImage)writeToFile: filePath    atomically:YES];
    [[FileUtil getInstance]changeUploadImageUrl:filePath];
    [[FileUtil getInstance]changeUploadImage:imageName];
}
@end
