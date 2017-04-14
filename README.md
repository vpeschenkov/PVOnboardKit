# PVOnboardKit
Make any app tutorial **as easy as possible**😎❕

**PVOnboardKit** allows to make an tutorial for you app, **as easy as possible**. As main concept uses [**UITableView**][1]. 

Also, for more customization [**PVOnboardKit**][2] uses [**TAPageControl**][3] instead of [**UIPageControl**][4].

# Task Lists
- [ ] Add to [CocoaPods Specs][5]
- [ ] Add an example on Swift
- [ ] Add an example on Objective-C
- [ ] Add reuse ability to [PVOnboardPage][6]
- [ ] Bring out bottom controls from [PVOnboardView][7]

# Requirements
Xcode 8. Ready for use on iOS 8+

# Install
Adding the following to your Podfile and running pod install should do the trick:
```
pod 'PVOnboardKit', :git=>'https://github.com/vpeschenkov/PVOnboardKit'
```

1. Import [PVOnboardKit][2]
1. Create [PVOnboardView][7] and add to your view
1. Implement [PVOnboardViewDelegate][8] and [PVOnboardViewDataSource][9] and assign to instance of [PVOnboardView][7]
1. Call reloadData from instance of [PVOnboardView][7]
1. Enjoy😎❕

## Objective-C

### Delegate
```obj-c
@optional
/**
 *  Called when a user did touch on the left action button.
 *
 *  @param onboardView The onboard view.
 *  @param index The index of a page.
 */
- (void)onboardView:(nonnull PVOnboardView *)onboardView didTouchOnLeftActionButtonAtIndex:(NSInteger)index;
```

```obj-c
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
```obj-c
@required
/**
 *  Requests a number of pages in a current onboard.
 *
 *  @param onboardView The onboard view.
 *  @return The number of pages.
 */
- (NSInteger)numberOfPagesInOneboardView:(nonnull PVOnboardView *)onboardView;
```

```obj-c
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

```obj-c
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

```obj-c
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

```obj-c
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

```obj-c
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

Thank @TanguyAladenise for [**TAPageControl**][3] it's awesome!

# Community

Questions, comments, issues, and pull requests are always welcome😄❕

# License

This project is made available under the MIT license. See LICENSE for details.

[1]: https://developer.apple.com/reference/uikit/uitableview
[2]: https://github.com/vpeschenkov/PVOnboardKit
[3]: https://github.com/TanguyAladenise/TAPageControl
[4]: https://developer.apple.com/reference/uikit/uipagecontrol
[5]: https://github.com/CocoaPods/Specs
[6]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardPage.h
[7]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L44
[8]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L125
[9]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L150
