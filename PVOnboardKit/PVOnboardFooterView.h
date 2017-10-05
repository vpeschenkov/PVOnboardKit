/*
 PVOnboardFooterViewDelegate.h
 PVOnboardKit
 
 Copyright 2017 Victor Peschenkov
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

@import UIKit;
@import TAPageControl;

@protocol PVOnboardFooterViewDelegate;

extern CGFloat const PVOnboardFooterViewHeight;

NS_ASSUME_NONNULL_BEGIN

/**
 * The PVOnboardFooterView is a view that contains bottom controls such as the
 * left action button, right action button and page control.
 */
NS_SWIFT_NAME(OnboardFooterView)
@interface PVOnboardFooterView : UIView

/**
 * The left action button.
 */
@property (nonnull, nonatomic, strong, readonly) UIButton *leftActionButton;

/**
 * The page control.
 */
@property (nonnull, nonatomic, strong, readonly) TAPageControl *pageControl;

/**
 * The right action button.
 */
@property (nonnull, nonatomic, strong, readonly) UIButton *rightActionButton;

/**
 * The delegate for PVOnboardFooterView.
 */
@property (nullable, nonatomic, weak) NSObject<PVOnboardFooterViewDelegate> *delegate;

@end

/**
 * The delegate of PVOnboardFooterView.
 */
NS_SWIFT_NAME(OnboardFooterViewDelegate)
@protocol PVOnboardFooterViewDelegate <NSObject>

@required
/**
 * Invoked just after a touch-up event in the left action button where the
 * finger is inside the bounds of the control.
 *
 * @param footerView The own instance of PVOnboardFooterView.
 */
- (void)footerViewdidTouchLeftActionButton:(nonnull PVOnboardFooterView *)footerView;

@required
/**
 * Invoked just after a touch-up event in the right action button where the
 * finger is inside the bounds of the control.
 *
 * @param footerView The own instance of PVOnboardFooterView.
 */
- (void)footerViewdidTouchRightActionButton:(nonnull PVOnboardFooterView *)footerView;

@end

NS_ASSUME_NONNULL_END
