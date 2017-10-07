# PVOnboardKit

![][10] ![][11] ![][12]

PVOnboardKit is a framework that allows you to add your own walkthrough/intro/tutorial into your app. As main concept uses [**UITableView**][1]. Also, for more customization [**PVOnboardKit**][2] uses [**TAPageControl**][3] instead of [**UIPageControl**][4].

![Demo!](http://i.imgur.com/yvcI91a.gif)

# Requirements
Xcode 9. Ready for use on iOS 8+

# Install
Adding the following to your Podfile and running pod install should do the trick:
```
pod 'PVOnboardKit'
```

1. Import [PVOnboardKit][2]
1. Create [PVOnboardView][7] and add to your view
1. Implement [PVOnboardViewDelegate][8] and [PVOnboardViewDataSource][9] and assign to instance of [PVOnboardView][7]
1. Call reloadData from instance of [PVOnboardView][7]
1. Enjoy 😎

# PVOnboardPage Protocol
```
@optional
/**
 * Invoked just after transition on the next page.
 */
- (void)willContentShow;
```

```
/**
 * Invoked before transition on the next page.
 */
@optional
- (void)didContentShow;
```

```
/**
 * Invoked just after transition on the next page.
 */
@optional
- (void)willContentHide;
```

```
/**
 * Invoked before transition on the next page.
 */
@optional
- (void)didContentHide;
```

# PVOnboardView Delegate Methods
```
@optional
/**
 * Invoked after a user did touch on the left action button.
 *
 * @param onboardView The onboardView.
 * @param index The index of the page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index;
```

```
@optional
/**
 * Invoked after a user did touch on the right action button.
 *
 * @param onboardView The onboardView.
 * @param index The index of the page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnRightActionButtonAtIndex:(NSInteger)index;
```

# PVOnboardView DataSource Methods

```
@required
/**
 * Requests a number of pages in current onboardView.
 *
 * @param onboardView The onboard-view object asking for number of pages.
 * @return The number of pages.
 */
- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView NS_SWIFT_NAME(numberOfPages(in:));
```

```
@required
/**
 * Requests a page view for the page at index.
 *
 * @param onboardView The onboard-view object asking for the view.
 * @param index An index of a requested page.
 * @return The view that conforms to PVOnboardPage protocol.
 */
- (nonnull UIView *)onboardView:(nonnull PVOnboardView *)onboardView viewForPageAtIndex:(NSInteger)index NS_SWIFT_NAME(onboardView(_:viewForPageAtIndex:));
```

```
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
```

```
@optional
/**
 * Requests a title for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button title.
 * @param index An index of a requested page.
 * @return The string to use as a title for the right action button.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForRightActionButtonAtIndex:(NSInteger)index;
```

```
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
```

```
@optional
/**
 * Requests an image for the right action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the right button image.
 * @param index An index of a requested page.
 * @return The image to use as the image for the right action button.
 */
- (nullable UIImage *)onboardView:(nonnull PVOnboardView *)onboardView imageForRightActionButtonAtIndex:(NSInteger)index;
```

```
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
```

```
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
```

```
@optional
/**
 * Requests a title for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button title.
 * @param index An index of a requested page.
 * @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForLeftActionButtonAtIndex:(NSInteger)index;
```

```
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
```

```
@optional
/**
 * Requests an image for the left action button for page at index.
 *
 * @param onboardView The onboard-view object asking for the left button image.
 * @param index An index of a requested page.
 * @return The image to use as the image for the left action button.
 */
- (nullable UIImage *)onboardView:(nonnull PVOnboardView *)onboardView imageForLeftActionButtonAtIndex:(NSInteger)index;
```

```
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
```

```
@optional
/**
 * Requests a bottom padding for the footer view. Default is 0.
 *
 * @param onboardView The onboardView.
 * @return The padding to use as the footer view bottom padding.
 */
- (CGFloat)onboardViewFooterBottomPadding:(nonnull PVOnboardView *)onboardView NS_SWIFT_NAME(onboardViewFooterBottomPadding(paddingForPageAtIndex:));
```

# Thanks

Thank @TanguyAladenise for [**TAPageControl**][3].

# Community

Questions, comments, issues, and pull requests are always welcome!

# License

Distributed under the MIT license. See LICENSE for more information.

[1]: https://developer.apple.com/reference/uikit/uitableview
[2]: https://github.com/vpeschenkov/PVOnboardKit
[3]: https://github.com/TanguyAladenise/TAPageControl
[4]: https://developer.apple.com/reference/uikit/uipagecontrol
[5]: https://github.com/CocoaPods/Specs
[6]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardPage.h
[7]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L44
[8]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L125
[9]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L150
[10]: https://travis-ci.org/vpeschenkov/PVOnboardKit.svg?branch=master
[11]: https://cocoapod-badges.herokuapp.com/v/PVOnboardKit/badge.png
[12]: https://cocoapod-badges.herokuapp.com/p/PVOnboardKit/badge.png
