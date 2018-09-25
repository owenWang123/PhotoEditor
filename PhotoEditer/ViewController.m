//
//  ViewController.m
//  PhotoEditer
//
//  Created by 皓天 on 2018/9/25.
//  Copyright © 2018年 owen. All rights reserved.
//

#import "ViewController.h"
#import "StoryMakeImageEditorViewController.h"

#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}
- (void)configUI{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    button.center = self.view.center;
    [button setTitle:@"打开相册" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    [button addTarget:self action:@selector(openAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *cameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    cameraBtn.center = CGPointMake(self.view.center.x, self.view.center.y - 60);
    [cameraBtn setTitle:@"打开相机" forState:UIControlStateNormal];
    [cameraBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cameraBtn setBackgroundColor:[UIColor grayColor]];
    [cameraBtn addTarget:self action:@selector(openCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraBtn];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    button2.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    [button2 setTitle:@"使用测试图" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor grayColor]];
    [button2 addTarget:self action:@selector(openTestImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)openAlbum{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)openCamera{
    UIImagePickerController *imagePicker= [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)openTestImage{
    UIImage *image = [UIImage imageNamed:@"bgStory.jpg"];
    
    [self jumpToPhotoEditorPage:image];
}

- (void)jumpToPhotoEditorPage:(UIImage *)image{
    StoryMakeImageEditorViewController *storyMakerVc = [[StoryMakeImageEditorViewController alloc] initWithImage:image];
    [self presentViewController:storyMakerVc animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
     __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf jumpToPhotoEditorPage:image];
    }];
}
#pragma mark-
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
