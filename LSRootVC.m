//
//  LSRootVC.m
//  MutiScrollTest
//
//  Created by linyoulu on 2017/7/14.
//  Copyright © 2017年 linyoulu. All rights reserved.
//

#import "LSRootVC.h"
#import "LSMutiScrollView.h"
#import "VTMagic.h"
#import "LSSubVC1.h"
#import "LSSubVC2.h"
#import "LSSubVC3.h"

//顶部头图区域高度
#define HeaderViewHeight 210
//tab标签高度
#define TabViewHeight 50

#define MAXHeight ([UIScreen mainScreen].bounds.size.height - 64)

#define ScrollTogether


@interface LSRootVC () <VTMagicViewDataSource , VTMagicViewDelegate, LSMutiScrollViewDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) LSMutiScrollView *backgroundSV;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) VTMagicController *magicController;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, assign) BOOL lockToTop;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation LSRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭导航栏半透明设置
    if (self.navigationController && self.navigationController.navigationBar)
    {
        self.navigationController.navigationBar.translucent = NO;
        //self.extendedLayoutIncludesOpaqueBars = NO;
    }
    
    //禁止UITableView UIScrollView的自动偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor grayColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    self.dic = [NSMutableDictionary new];
    
    UIView *navView = [UIView new];
    navView.backgroundColor = [UIColor whiteColor];
    navView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    navView.alpha = 0;
    
    
    [self.view addSubview:navView];
    self.navView = navView;

    UILabel *titleLabel = [UILabel new];
    titleLabel.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44);
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"假导航栏";
    
    [navView addSubview:titleLabel];
    
    

   
    
    self.titleArray = @[@"first",@"second",@"third"];
    
    
    
    LSMutiScrollView *sv = [LSMutiScrollView new];
    sv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    sv.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + HeaderViewHeight - 64);
    sv.delegate = self;
    sv.bounces = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    self.backgroundSV = sv;
    [self.view addSubview:sv];
    
    UIImageView *imgv = [UIImageView new];
    imgv.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HeaderViewHeight);
    imgv.image = [UIImage imageNamed:@"学校页"];
    
    [sv addSubview:imgv];
    
    [self addChildViewController:self.magicController];
    [sv addSubview:_magicController.view];
    
    [_magicController.view setFrame:CGRectMake(0, HeaderViewHeight, [UIScreen mainScreen].bounds.size.width, MAXHeight)];
    [_magicController.magicView reloadData];
    
    [self.view bringSubviewToFront:navView];
    
}

- (VTMagicController *)magicController
{
    if (!_magicController) {
        _magicController = [[VTMagicController alloc] init];
        _magicController.magicView.navigationColor = [UIColor whiteColor];
        _magicController.magicView.sliderColor = [UIColor redColor];
        _magicController.magicView.layoutStyle = VTLayoutStyleDivide;
        _magicController.magicView.switchStyle = VTSwitchStyleDefault;
        _magicController.magicView.navigationHeight = TabViewHeight;
        _magicController.magicView.dataSource = self;
        _magicController.magicView.delegate = self;
    }
    return _magicController;
}

- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView
{
    return _titleArray;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex
{
    static NSString *itemIdentifier = @"itemIdentifier";
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem)
    {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:[UIColor colorWithRed:0 green:0 blue:33 alpha:1] forState:UIControlStateNormal];
        [menuItem setTitleColor:[UIColor colorWithRed:33 green:33 blue:0 alpha:1] forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex
{
    NSString *strTitle = [_titleArray objectAtIndex:pageIndex];
    if ([strTitle isEqualToString:@"first"])
    {
        static NSString *gridId = @"first";
        LSSubVC1 *gridViewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!gridViewController)
        {
            gridViewController = [[LSSubVC1 alloc] init];
        }
        
        gridViewController.delegate = self;
        
        
        return gridViewController;
    }
    else if ([strTitle isEqualToString:@"second"])
    {
        static NSString *gridId = @"second";
        LSSubVC2 *gridViewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!gridViewController)
        {
            gridViewController = [[LSSubVC2 alloc] init];
        }
        gridViewController.delegate = self;
        
        
        return gridViewController;
    }
    else
    {
        
        static NSString *recomId = @"third";
        
        LSSubVC3 *recomViewController = [magicView dequeueReusablePageWithIdentifier:recomId];
        if (!recomViewController)
        {
            recomViewController = [[LSSubVC3 alloc] init];
            
        }
        
        recomViewController.delegate = self;
        
        return recomViewController;
    }
}

- (void)scrollViewDidScroll:(CGFloat)yOffset scrollView:(UIScrollView*)view
{
    NSString *strAddr = [NSString stringWithFormat:@"%p", view];
    NSNumber *numY = [self.dic objectForKey:strAddr];
    
    if (numY == nil)
    {
        numY = [NSNumber numberWithFloat:0];
        
    }
    
    CGFloat lastY = [numY floatValue];
    
    
    //标签已经滑动到顶端了
    if (self.backgroundSV.contentOffset.y == HeaderViewHeight - 64)
    {
        if (yOffset > 0)
        {
            self.lockToTop = YES;
            
            NSLog(@"LOCK YES");
        }
        else
        {
            self.lockToTop = NO;
            
             NSLog(@"LOCK NO");
        }
        
        numY = [NSNumber numberWithFloat:yOffset];
        [self.dic setObject:numY forKey:strAddr];
    }
    //标签在底端
    else if(self.backgroundSV.contentOffset.y == 0)
    {

        numY = [NSNumber numberWithFloat:yOffset];
        [self.dic setObject:numY forKey:strAddr];
    }
    else
    {
        
#ifdef ScrollTogether
        
        
        static NSInteger lastyCount = 0;
        static CGFloat lastYCopy = 10000;
        
        if (lastYCopy == lastY)
        {
            lastyCount++;
        }
        else
        {
            lastyCount = 0;
            lastYCopy = lastY;
        }
        
        if (lastyCount >= 2)
        {
            lastyCount = 0;
            lastYCopy = 10000;
        }
        else
        {
            view.contentOffset = CGPointMake(0, lastY);
        }
        
//    view.contentOffset = CGPointMake(0, lastY);
        
        
#endif
    }
    
    NSLog(@"lastY:%f",lastY);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset = scrollView.contentOffset.y;
    
    if (self.lockToTop)
    {
        //锁定在顶端
        scrollView.contentOffset = CGPointMake(0, HeaderViewHeight - 64);
    }
    else
    {
        //改变导航的透明度
        self.navView.alpha = yOffset/(HeaderViewHeight - 64);
    }
    
    
    NSLog(@"nav:%f",yOffset);
}


@end
