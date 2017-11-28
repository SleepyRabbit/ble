//
//  ListViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/23.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIStackView *stackView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _stackView.axis = UILayoutConstraintAxisVertical;
    _stackView.alignment = UIStackViewAlignmentFill;
    _stackView.distribution = UIStackViewDistributionFillEqually;   //子控件自动布局为大小相等的控件
    _stackView.spacing = 20;
    _stackView.backgroundColor = [UIColor blueColor];

    UIImage *img1 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:img1];

    UIImage *img2 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:img2];

    UIImage *img3 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:img3];

    UIImage *img4 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:img4];

    UIImage *img5 = [UIImage imageNamed:@"expression.jpg"];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:img5];

    [_stackView addArrangedSubview:imageView1];
    [_stackView addArrangedSubview:imageView2];
    [_stackView addArrangedSubview:imageView3];
    [_stackView addArrangedSubview:imageView4];
    [_stackView addArrangedSubview:imageView5];
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
