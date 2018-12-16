//
//  DoraemonBaseViewController.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "DoraemonBaseViewController.h"
#import "DoraemonNavBarItemModel.h"
#import "UIImage+Doraemon.h"
#import "DoraemonHomeWindow.h"
#import "UIView+Doraemon.h"
#import "DoraemonDefine.h"

@interface DoraemonBaseViewController() <DoraemonBaseBigTitleViewDelegate>
@end

@implementation DoraemonBaseViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if ([self needBigTitleView]) {
        _bigTitleView = [[DoraemonBaseBigTitleView alloc] initWithFrame: CGRectMake(0, 0, self.view.doraemon_width, kDoraemonSizeFrom750(178))];
        _bigTitleView.delegate = self;
        [self.view addSubview:_bigTitleView];
    } else {
        DoraemonNavBarItemModel *leftModel = [[DoraemonNavBarItemModel alloc] initWithImage:[UIImage doraemon_imageNamed:@"doraemon_back"] selector:@selector(leftNavBackClick:)];
        
        [self setLeftNavBarItems:@[leftModel]];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = [self needBigTitleView];
    [[DoraemonHomeWindow shareInstance] makeKeyWindow];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    UIWindow *appWindow = [[UIApplication sharedApplication].delegate window];
    [appWindow makeKeyWindow];
}

#pragma mark - Functions

- (void)setTitle:(NSString *)title {
    if (_bigTitleView && !_bigTitleView.hidden) {
        [_bigTitleView setTitle:title];
    } else {
        [super setTitle:title];
    }
}

- (void)leftNavBackClick:(id)clickView {
    if (self.navigationController.viewControllers.count == 1) {
        [[DoraemonHomeWindow shareInstance] hide];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setLeftNavBarItems:(NSArray *)items{
    NSArray *barItems = [self navigationItems:items];
    if (barItems) {
        self.navigationItem.leftBarButtonItems = barItems;
    }
}

#pragma mark - Queries

//是否需要大标题，默认不需要
- (BOOL)needBigTitleView {
    return NO;
}

- (NSArray *)navigationItems:(NSArray *)items {
    NSMutableArray *barItems = [NSMutableArray array];
    
    //距离左右的间距
    UIBarButtonItem *spacer = [self getSpacerByWidth:-10];
    [barItems addObject:spacer];
    
    for (int i = 0; i < items.count; i++) {
        DoraemonNavBarItemModel *model = items[i];
        UIBarButtonItem *barItem;
        if (model.type == DoraemonNavBarItemTypeText) { //文字按钮
            barItem = [[UIBarButtonItem alloc] initWithTitle: model.text style: UIBarButtonItemStylePlain
                                                      target: self action: model.selector];
            barItem.tintColor = model.textColor;
        } else if (model.type == DoraemonNavBarItemTypeImage) { //图片按钮
            //设置图片没有默认蓝色效果 默认的间距太大
            UIImage *image = [model.image imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
            UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
            [button setImage: image forState:UIControlStateNormal];
            [button addTarget:self action: model.selector forControlEvents: UIControlEventTouchUpInside];
            button.frame = CGRectMake(0, 0, 30, 30);
            button.clipsToBounds = YES;
            barItem = [[UIBarButtonItem alloc] initWithCustomView: button];
        }
        [barItems addObject:barItem];
    }
    
    return barItems;
}

/**
 * 获取间距
 */
- (UIBarButtonItem *)getSpacerByWidth:(CGFloat)width {
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]
                               initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                               target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    spacer.width = width;
    return spacer;
}

#pragma mark - DoraemonBaseBigTitleViewDelegate

- (void)bigTitleCloseClick {
    [self leftNavBackClick:nil];
}

@end
