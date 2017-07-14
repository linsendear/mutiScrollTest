//
//  LSMutiScrollView.m
//  MutiScrollTest
//
//  Created by linyoulu on 2017/7/14.
//  Copyright © 2017年 linyoulu. All rights reserved.
//

#import "LSMutiScrollView.h"

@interface LSMutiScrollView() <UIGestureRecognizerDelegate>

@end

@implementation LSMutiScrollView

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
}

@end
