//
//  DoraemonNavBarItemModel.m
//  DoraemonKit
//
//  Created by yixiang on 2017/12/11.
//

#import "DoraemonNavBarItemModel.h"

@implementation DoraemonNavBarItemModel

#pragma mark - Initialization

- (instancetype)initWithText:(NSString *)text color:(UIColor *)color selector:(SEL)selector {
    self = [DoraemonNavBarItemModel new];
    
    self.type = DoraemonNavBarItemTypeText;
    self.text = text;
    self.textColor = color;
    self.selector = selector;
    
    return self;
}

- (instancetype)initWithImage:(UIImage *)image selector:(SEL)selector {
    self = [DoraemonNavBarItemModel new];
    
    self.type = DoraemonNavBarItemTypeImage;
    self.image = image;
    self.selector = selector;
    
    return self;
}

@end
