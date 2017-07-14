//
//  LSSubVC3.m
//  MutiScrollTest
//
//  Created by linyoulu on 2017/7/14.
//  Copyright © 2017年 linyoulu. All rights reserved.
//

#import "LSSubVC3.h"
#import "LSSub3TableViewCell.h"

@interface LSSubVC3 () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation LSSubVC3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //当然，这里也可以用tableview，然后就只有一个cell的方式，来自定义页面;
    
    UITableView *v = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64 - 50)) style:UITableViewStylePlain];
    
    v.delegate = self;
    v.dataSource = self;
    v.rowHeight = ([UIScreen mainScreen].bounds.size.height - 64 - 50);
    [v registerClass:[LSSub3TableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:v];
    
//    v.sd_layout
//    .topEqualToView(self.view)
//    .bottomEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSSub3TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    if (!cell)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"1----------%d",indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate)
    {
        [self.delegate scrollViewDidScroll:scrollView.contentOffset.y scrollView:scrollView];
    }
}

@end
