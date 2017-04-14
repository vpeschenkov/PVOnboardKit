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

@class TAPageControl;

NS_ASSUME_NONNULL_BEGIN

/**
 * The type of block to update an action button appearance.
 */
typedef void(^PVOnboardViewConfigureActionButtonBlock)(UIButton * _Nonnull actionButton);

/**
 * PVOnboardView is a view that shows a tutorial for users.
 */
@interface PVOnboardView : UIView

/**
 * The delegate for PVOnboardView.
 */
@property (nullable, nonatomic, weak) NSObject<PVOnboardViewDelegate> *delegate;

/**
 * The data source for PVOnboardView.
 */
@property (nullable, nonatomic, weak) NSObject<PVOnboardViewDataSource> *dataSource;

/**
 *  The Class of your custom UIView, make sure to respect the TAAbstractDotView class.
 */
@property (nonatomic, assign) Class dotViewClass;

/**
 *  UIImage to represent a dot.
 */
@property (nullable, nonatomic, strong) UIImage *dotImage;

/**
 *  UIImage to represent current page dot.
 */
@property (nullable, nonatomic, strong) UIImage *currentDotImage;

/**
 *  Dot size for dot views. Default is 8 by 8.
 */
@property (nonatomic, assign) CGSize dotSize;

/**
 *  Spacing between two dot views. Default is 8.
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
 * Scroll to the next page
 * @param animated The flag that indicate about an animation while scrolling.
 */
- (void)scrollToTheNextPage:(BOOL)animated;

/**
 * Scroll to the previously page
 * @param animated The flag that indicate about an animation while scrolling.
 */
- (void)scrollToThePreviouslyPage:(BOOL)animated;

/**
 * Reloads data
 */
- (void)reloadData;

/**
 * Set up or update the left action button apperence.
 * @param block The block that invoked to update the action button apperence.
 */
- (void)setUpLeftActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block;

/**
 * Set up or update the right action button apperence.
 * @param block The block that invoked to update the action button apperence.
 */
- (void)setUpRightActionButtonWithBlock:(nonnull PVOnboardViewConfigureActionButtonBlock)block;

@end

/**
 *  The PVOnboardView delegate protocol
 */
@protocol PVOnboardViewDelegate <NSObject>

@optional
/**
 *  Called when a user did touch on the left action button.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index;

@optional
/**
 *  Called when a user did touch on the right action button.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnRightActionButtonAtIndex:(NSInteger)index;

@end

/**
 *  The PVOnboardView data source protocol.
 */
@protocol PVOnboardViewDataSource <NSObject>

@required
/**
 *  Requests a number of pages in a current onboard.
 *
 *  @param onboardView The onboard view.
 *  @return The number of pages.
 */
- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView;

@required
/**
 *  Requests a page view for the page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return The view that conforms to PVOnboardPage protocol.
 */
- (nonnull UIView<PVOnboardPage> *)onboardView:(nonnull PVOnboardView *)onboardView viewForPageAtIndex:(NSInteger)index;

@optional
/**
 *  Requests a visible state for the right action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideRightActionButtonForPageAtIndex:(NSInteger)index;

@optional
/**
 *  Requests a title for the right action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForRightActionButtonAtIndex:(NSInteger)index;

@optional
/**
 *  Requests a visible state for the left action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideLeftActionButtonForPageAtIndex:(NSInteger)index;

@optional
/**
 *  Requests a title for the left action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForLeftActionButtonAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
