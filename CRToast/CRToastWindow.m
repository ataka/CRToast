//
//  CRToast
//  Copyright (c) 2014-2015 Collin Ruffenach. All rights reserved.
//

#import "CRToastWindow.h"
#import "CRToastViewController.h"

@implementation CRToastWindow

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
    for (UIView *subview in self.subviews) {
        if ([subview hitTest:[self convertPoint:point toView:subview] withEvent:event] != nil) {
            return YES;
        }
    }
    return NO;
}

// FIXME:
// Xcode/iOS13 iPad で Toast を表示すると UIWindow 内の Subview にイベントが反応し、
// Main Window の UI が操作できなくなるため、Toast 箇所以外のビューがタップされた場合は透過するように調整
// 一時的な対応なので 本ライブラリ自体差し替えを検討する必要がある
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if ([hitView isKindOfClass:CRToastContainerView.class]) {
        return hitView;
    }
    return nil;
}

@end
