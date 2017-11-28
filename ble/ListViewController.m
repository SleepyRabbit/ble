//
//  ListViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/23.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
@property (strong, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentFill;
    _stackView.distribution = UIStackViewDistributionFillEqually;   //子控件自动布局为大小相等的控件
    _stackView.spacing = 0;
    _stackView.backgroundColor = [UIColor blueColor];

    CGRect stackRect = _stackView.frame;
    NSLog(@"%f", stackRect.size.height);
    NSLog(@"%f", stackRect.size.width);


    CGRect tabRect = CGRectMake(10, 10, stackRect.size.width - 20, stackRect.size.height/5 - 20);

    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor redColor];

    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor redColor];

    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor redColor];

    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor redColor];

    UIView *view5 = [[UIView alloc] init];
    view5.backgroundColor = [UIColor redColor];

    UIImage *img1 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:tabRect];
    imageView1.image = img1;
//    [imageView1 layoutIfNeeded];
    imageView1.layer.cornerRadius = 10;
    imageView1.clipsToBounds = YES;

    UIImage *img2 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:tabRect];
    imageView2.image = img2;

    UIImage *img3 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:tabRect];
    imageView3.image = img3;

    UIImage *img4 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithFrame:tabRect];
    imageView4.image = img4;

    UIImage *img5 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView5 = [[UIImageView alloc] initWithFrame:tabRect];
    imageView5.image = img5;


    [view1 addSubview:imageView1];
    [view2 addSubview:imageView2];
    [view3 addSubview:imageView3];
    [view4 addSubview:imageView4];
    [view5 addSubview:imageView5];

    [_stackView addArrangedSubview:view1];
    [_stackView addArrangedSubview:view2];
    [_stackView addArrangedSubview:view3];
    [_stackView addArrangedSubview:view4];
    [_stackView addArrangedSubview:view5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
