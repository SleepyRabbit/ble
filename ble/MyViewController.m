//
//  MyViewController.m
//  ble
//
//  Created by 侯恩星 on 2017/11/25.
//  Copyright © 2017年 侯恩星. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;                                         //tableView delegate
    _tableView.dataSource = self;                                       //tableView dataSource
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;  //Single separator line
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;      //No separator line
//    _tableView.backgroundColor = [UIColor colorWithRed:198/255.0 green:198/255.0 blue:203/255.0 alpha:1];
//    _tableView.separatorColor = [UIColor blueColor];
//    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <TableView delegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuse = @"cell";

    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:reuse];

    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuse];
    }

    cell.separatorInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;

    switch(indexPath.row) {
        case 0:
            cell.textLabel.text = @"我的设备";
            cell.detailTextLabel.text = @"我问问";
            cell.imageView.image = [UIImage imageNamed:@"1.png"];
            break;
        case 1:
            cell.textLabel.text = @"我的收藏";
            break;
        case 2:
            cell.textLabel.text = @"地址管理";
            break;
        case 3:
            cell.textLabel.text = @"反馈";
            break;
        case 4:
            cell.textLabel.text = @"关于";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"Select is: %@", cell.textLabel.text);
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
