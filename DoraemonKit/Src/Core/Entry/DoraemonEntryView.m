//
//  DoraemonEntryView.m
//  DoraemonKitDemo
//
//  Created by yixiang on 2017/12/11.
//  Copyright © 2017年 yixiang. All rights reserved.
//

#import "DoraemonEntryView.h"
#import "DoraemonDefine.h"
#import "DoraemonUtil.h"
#import "UIView+Doraemon.h"
#import "UIImage+Doraemon.h"
#import "DoraemonDefine.h"
#import "DoraemonHomeWindow.h"

@interface DoraemonEntryView()

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UIButton *entryButton;
@property (nonatomic, assign) CGFloat kEntryViewSize;

@end

@implementation DoraemonEntryView

#pragma mark - Initialization

- (instancetype)init {
    _kEntryViewSize = kDoraemonSizeFrom750(116);
    
    if (self = [super initWithFrame:CGRectMake(0, DoraemonScreenHeight/3, _kEntryViewSize, _kEntryViewSize)]) {
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 100.f;
        
        if (!self.rootViewController) {
            self.rootViewController = [UIViewController new];
        }
        
        UIButton *entryButton = [[UIButton alloc] initWithFrame:self.bounds];
        entryButton.backgroundColor = [UIColor clearColor];
        [entryButton setImage:[UIImage doraemon_imageNamed:@"doraemon_logo"] forState:UIControlStateNormal];
        entryButton.layer.cornerRadius = 20.f;
        [entryButton addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.rootViewController.view addSubview:entryButton];
        _entryButton = entryButton;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
    }
    
    return self;
}

#pragma mark - Actions

- (void)closePluginClick:(UIButton *)button {
    [_entryButton setImage:[UIImage doraemon_imageNamed:@"doraemon_logo"] forState:UIControlStateNormal];
    [_entryButton removeTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
    [_entryButton addTarget:self action:@selector(entryClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DoraemonClosePluginNotification object:nil userInfo:nil];
}

/**
 进入工具主面板
 */
- (void)entryClick:(UIButton *)button {
    if ([DoraemonHomeWindow shareInstance].hidden) {
        [[DoraemonHomeWindow shareInstance] show];
    } else {
        [[DoraemonHomeWindow shareInstance] hide];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DoraemonClosePluginNotification object:nil userInfo:nil];
}

- (void)pan:(UIPanGestureRecognizer *)sender {
    // 1、获得拖动位移
    CGPoint offsetPoint = [sender translationInView:sender.view];
    // 2、清空拖动位移
    [sender setTranslation:CGPointZero inView:sender.view];
    // 3、重新设置控件位置
    UIView *panView = sender.view;
    CGFloat newX = panView.doraemon_centerX + offsetPoint.x;
    CGFloat newY = panView.doraemon_centerY + offsetPoint.y;
    if (newX < _kEntryViewSize / 2) {
        newX = _kEntryViewSize / 2;
    }
    if (newX > DoraemonScreenWidth - _kEntryViewSize / 2) {
        newX = DoraemonScreenWidth - _kEntryViewSize / 2;
    }
    if (newY < _kEntryViewSize / 2) {
        newY = _kEntryViewSize / 2;
    }
    if (newY > DoraemonScreenHeight - _kEntryViewSize / 2) {
        newY = DoraemonScreenHeight - _kEntryViewSize / 2;
    }
    panView.center = CGPointMake(newX, newY);
}

#pragma mark - Functions

- (void)showClose:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    
    [_entryButton setImage:[UIImage doraemon_imageNamed:@"doraemon_close"] forState:UIControlStateNormal];
    [_entryButton removeTarget:self action:@selector(showClose:) forControlEvents:UIControlEventTouchUpInside];
    [_entryButton addTarget:self action:@selector(closePluginClick:) forControlEvents:UIControlEventTouchUpInside];
}

// 不能让该View成为keyWindow，每一次它要成为keyWindow的时候，都要将appDelegate的window指为keyWindow
- (void)becomeKeyWindow {
    UIWindow *appWindow = [[UIApplication sharedApplication].delegate window];
    [appWindow makeKeyWindow];
}

@end
