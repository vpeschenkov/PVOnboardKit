/*
 PVOnboardView.h
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

@protocol PVOnboardPage;
@protocol PVOnboardViewDelegate;
@protocol PVOnboardViewDataSource;

@class PVOnboardFooterView;

NS_ASSUME_NONNULL_BEGIN

/**
 * The type of block to update an action button appearance.
 */
NS_SWIFT_NAME(OnboardViewConfigureActionButtonBlock)
typedef void(^PVOnboardViewConfigureActionButtonBlock)(UIButton * _Nonnull actionButton);

/**
 * PVOnboardView is a view that shows a tutorial for users.
 */
NS_SWIFT_NAME(OnboardView)
@interface PVOnboardView : UIView

/**
 * The delegate of PVOnboardView.
 */
@property (nullable, nonatomic, weak) NSObject<PVOnboardViewDelegate> *delegate;

/**
 * The data source of PVOnboardView.
 */
@property (nullable, nonatomic, weak) NSObject<PVOnboardViewDataSource> *dataSource;

/**
 * The Class of your custom UIView, make sure to respect the TAAbstractDotView class.
 */
@property (nonatomic, assign) Class dotViewClass;

/**
 * UIImage to represent a dot.
 */
@property (nullable, nonatomic, strong) UIImage *dotImage;

/**
 * UIImage to represent current page dot.
 */
@property (nullable, nonatomic, strong) UIImage *currentDotImage;

/**
 * Dot size for dot views. Default is 8 by 8.
 */
@property (nonatomic, assign) CGSize dotSize;

/**
 * Spacing between two dot views. Default is 8.
 */
@property (nonatomic, assign) NSInteger spacingBetweenDots;

/**
 * The background image for PVOnboardView.
 */
@property (nonatomic, strong) UIImage *backgroundImage;

/**
 * The content mode for the background image.
 */
@property (nonatomic, assign) UIViewContentMode backgroundImageContentMode;

/**
 * Initializes and returns a newly allocated onboard view object with the
 * specified footer view.
 * @param footerView Your implementation of footer view.
 * @return An initialized onboard view object.
 */
- (instancetype)initWithFooterView:(PVOnboardFooterView *)footerView;

/**
 * Scrolls to the next page.
 * @param animated The flag that indicate about an animation while scrolling.
 */
- (void)scrollToNextPage:(BOOL)animated NS_SWIFT_NAME(scrollToNextPage(animated:));

/**
 * Scrolls to the previously page.
 * @param animated The flag that indicate about an animation while scrolling.
 */
- (void)scrollToPreviouslyPage:(BOOL)animated NS_SWIFT_NAME(scrollToPreviouslyPage(animated:));

/**
 * Reloads data.
 */
- (void)reloadData;

/**
 * Sets up or updates the left action button apperence.
 * @param block The block that invoked to update the action button apperence.
 */
- (void)setUpLeftActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block;

/**
 * Sets up or updates the right action button apperence.
 * @param block The block that invoked to update the action button apperence.
 */
- (void)setUpRightActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block;

@end

/**
 * The PVOnboardView data source protocol.
 */
NS_SWIFT_NAME(OnboardViewDataSource)
@protocol PVOnboardViewDataSource <NSObject>

@required
/**
 * Requests a number of pages in current onboardView.
 *
 * @param onboardView The onboard-view object asking for number of pages.
 * @return The number of pages.
 */
- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView NS_SWIFT_NAME(numberOfPages(in:));

@required
/**
 * Requests a page view for the page at index.
 *
 * @param onboardView The onboard-view object asking for the view.
 * @param index An index of a requested page.
 * @return The view that conforms to PVOnboardPage protocol.
 */
- (nonnull UIView *)onboardView:(nonnull PVOnboardView *)onboardView viewForPageAtIndex:(NSInteger)index NS_SWIFT_NAME(onboardView(_:viewForPageAtIndex:));

@optional
/**
 * Requests a visible state for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button
 * visible state.
 * @param index An index of a requested page.
 * @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideRightActionButtonForPageAtIndex:(NSInteger)index;

@optional
/**
 * Requests a title for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button title.
 * @param index An index of a requested page.
 * @return The string to use as a title for the right action button.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForRightActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests title edge insets for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button edge
 * insets.
 * @param index An index of a requested page.
 * @return The edge insets to use as the title edge insets for the right
 * action button.
 */
- (UIEdgeInsets)onboardView:(nonnull PVOnboardView *)onboardView titleEdgeInsetsForRightActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests an image for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button image.
 * @param index An index of a requested page.
 * @return The image to use as the image for the right action button.
 */
- (nullable UIImage *)onboardView:(nonnull PVOnboardView *)onboardView imageForRightActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests image edge insets for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button image
 * edge insets.
 * @param index An index of a requested page.
 * @return The edge insets to use as the image edge insets for the right
 * action button.
 */
- (UIEdgeInsets)onboardView:(nonnull PVOnboardView *)onboardView imageEdgeInsetsForRightActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests a visible state for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button
 * visible state.
 * @param index An index of a requested page.
 * @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideLeftActionButtonForPageAtIndex:(NSInteger)index;

@optional
/**
 * Requests a title for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button title.
 * @param index An index of a requested page.
 * @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests title edge insets for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button edge
 * insets.
 * @param index An index of a requested page.
 * @return The edge insets to use as the title edge insets for the left
 * action button.
 */
- (UIEdgeInsets)onboardView:(nonnull PVOnboardView *)onboardView titleEdgeInsetsForLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests an image for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button image.
 * @param index An index of a requested page.
 * @return The image to use as the image for the left action button.
 */
- (nullable UIImage *)onboardView:(nonnull PVOnboardView *)onboardView imageForLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests image edge insets for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button image
 * edge insets.
 * @param index An index of a requested page.
 * @return The edge insets to use as the image edge insets for the left
 * action button.
 */
- (UIEdgeInsets)onboardView:(nonnull PVOnboardView *)onboardView imageEdgeInsetsForLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Requests a bottom padding for the footer view. Default is 0.
 *
 * @param onboardView The onboardView.
 * @return The padding to use as the footer view bottom padding.
 */
- (CGFloat)onboardViewFooterBottomPadding:(nonnull PVOnboardView *)onboardView NS_SWIFT_NAME(onboardViewFooterBottomPadding(paddingForPageAtIndex:));

@end

/**
 * The PVOnboardView delegate protocol
 */
NS_SWIFT_NAME(OnboardViewDelegate)
@protocol PVOnboardViewDelegate <NSObject>

@optional
/**
 * Invoked after a user did touch on the left action button.
 *
 * @param onboardView The onboardView.
 * @param index The index of the page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 * Invoked after a user did touch on the right action button.
 *
 * @param onboardView The onboardView.
 * @param index The index of the page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnRightActionButtonAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
