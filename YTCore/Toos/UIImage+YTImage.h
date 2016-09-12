//
//  UIImage+YTImage.h
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YTImage)

//切图
- (UIImage*)crop:(CGRect)rect;
//改变图片颜色
- (UIImage *)imageThemeChangeWithColor:(UIColor *)color;

/*
 * 按照Rect截取Image里一块生成新的image
 */
- (UIImage *)getSubImage:(CGRect)rect;

@end
