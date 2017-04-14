# PVOnboardKit
Make any app tutorial **as easy as possible**😎❕

**PVOnboardKit** allows to make an tutorial for you app, **as easy as possible**. As main concept uses **UITableView**. 

Also, for more customization [PVOnboardKit](https://github.com/vpeschenkov/PVOnboardKit) uses [TAPageControl](https://github.com/TanguyAladenise/TAPageControl) instead of [UIPageControl](https://developer.apple.com/reference/uikit/uipagecontrol).

# Task Lists
- [ ] Add to [CocoaPods Specs](https://github.com/CocoaPods/Specs)
- [ ] Add an example on Swift
- [ ] Add an example on Objective-C
- [ ] Add reuse ability to [PVOnboardPage](https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardPage.h)
- [ ] Bring out bottom controls from [PVOnboardView](https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h)

# Requirements
Xcode 8. Ready for use on iOS 8+

# Install
Adding the following to your Podfile and running pod install should do the trick:
```
pod 'PVOnboardKit', :git=>'https://github.com/vpeschenkov/PVOnboardKit'
```

1. Import PVOnboardKit
1. Create OKOnboardView and add to your view
1. Implement PVOnboardViewDelegate and PVOnboardViewDataSource and assign to instance of OKOnboardView
1. Call reloadData from instance of OKOnboardView
1. Enjoy😎❕

## Objective-C

### Delegate
```
@optional
/**
 *  Called when a user did touch on the left action button.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index;
```

```
@optional
/**
 *  Called when a user did touch on the right action button.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnRightActionButtonAtIndex:(NSInteger)index;
```

### DataSource
```
@required
/**
 *  Requests a number of pages in a current onboard.
 *
 *  @param onboardView The onboard view.
 *  @return The number of pages.
 */
- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView;
```

```
@required
/**
 *  Requests a page view for the page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return The view that conforms to PVOnboardPage protocol.
 */
- (nonnull UIView<PVOnboardPage> *)onboardView:(nonnull PVOnboardView *)onboardView viewForPageAtIndex:(NSInteger)index;
```

```
@optional
/**
 *  Requests a visible state for the right action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideRightActionButtonForPageAtIndex:(NSInteger)index;
```

```
@optional
/**
 *  Requests a title for the right action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForRightActionButtonAtIndex:(NSInteger)index;
```

```
@optional
/**
 *  Requests a visible state for the left action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return YES if a action button should be visible or NO if shouldn't.
 */
- (BOOL)onboardView:(nonnull PVOnboardView *)onboardView shouldHideLeftActionButtonForPageAtIndex:(NSInteger)index;
```

```
@optional
/**
 *  Requests a title for the left action button for page at index.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a requested page.
 *  @return Return the string that should use as a title.
 */
- (nullable NSString *)onboardView:(nonnull PVOnboardView *)onboardView titleForLeftActionButtonAtIndex:(NSInteger)index;
```

# Thanks

Thank @TanguyAladenise for [TAPageControl](https://github.com/TanguyAladenise/TAPageControl) it's awesome!

# Community

Questions, comments, issues, and pull requests are always welcome😄❕

# License

This project is made available under the MIT license. See LICENSE for details.
