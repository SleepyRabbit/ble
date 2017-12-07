//
//  PhotoViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/12/6.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()<UIImagePickerControllerDelegate>
{
    UIImageView *_imageView;
    UIImagePickerController *imagePickerController;
}

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 86, self.view.frame.size.width-32,self.view.frame.size.width-32)];
//    _imageView.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:_imageView];

    //调用系统相册
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UIImagePickerControllerDelegate>
//按下确认按钮
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info {
    [imagePickerController dismissViewControllerAnimated:NO completion:nil];

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];

    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);

    NSLog(@"%f", width);
    NSLog(@"%f", height);

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 86, width, height)];
    [_imageView setImage:image];
    [self.view addSubview:_imageView];
}

//按下取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"cancel");
    [self dismissViewControllerAnimated:YES completion:nil];
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
