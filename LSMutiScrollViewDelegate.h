//
//  LSMutiScrollViewDelegate.h
//  MutiScrollTest
//
//  Created by linyoulu on 2017/7/14.
//  Copyright © 2017年 linyoulu. All rights reserved.
//

#ifndef LSMutiScrollViewDelegate_h
#define LSMutiScrollViewDelegate_h



@protocol LSMutiScrollViewDelegate <NSObject>

@optional

- (void)scrollViewDidScroll:(CGFloat)yOffset scrollView:(UIScrollView*)view;

@end

#endif /* LSMutiScrollViewDelegate_h */
