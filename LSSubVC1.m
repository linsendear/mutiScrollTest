//
//  LSSubVC1.m
//  MutiScrollTest
//
//  Created by linyoulu on 2017/7/14.
//  Copyright © 2017年 linyoulu. All rights reserved.
//

#import "LSSubVC1.h"
//#import "SDAutoLayout/UIView+SDAutoLayout.h"

@interface LSSubVC1 ()  <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *t;
@end

@implementation LSSubVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UITableView *v = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, ([UIScreen mainScreen].bounds.size.height - 64 - 50)) style:UITableViewStylePlain];
    
    v.delegate = self;
    v.dataSource = self;
    v.rowHeight = 20;
    self.t = v;
    [self.view addSubview:v];

//    v.sd_layout
//    .topEqualToView(self.view)
//    .bottomEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view);
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"1----------%d",indexPath.row];
    
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate)
    {
        [self.delegate scrollViewDidScroll:scrollView.contentOffset.y scrollView:scrollView];
    }
}
- (UIScrollView*)currentScrollView
{
    return  self.t;
}

@end
