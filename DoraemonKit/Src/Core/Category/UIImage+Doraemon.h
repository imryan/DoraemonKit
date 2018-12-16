//
//  UIImage+Doraemon.h
//  DoraemonKit-DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import <UIKit/UIKit.h>

@interface UIImage (Doraemon)

/**
 压缩图片尺寸 等比缩放 通过计算得到缩放系数
 Compressed image size, proportional scaling, calculated by scaling factor
 */
- (UIImage *)doraemon_scaledToSize:(CGSize)newSize;
+ (UIImage *)doraemon_imageNamed:(NSString *)name;

@end
