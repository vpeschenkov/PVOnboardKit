# PVOnboardKit

![][10] ![][11] ![][12]

![Demo!](http://i.imgur.com/yvcI91a.gif)

Make an app tutorial **as easy as possible**!

**PVOnboardKit** allows to make an tutorial for you app, **as easy as possible**. As main concept uses [**UITableView**][1]. 

Also, for more customization [**PVOnboardKit**][2] uses [**TAPageControl**][3] instead of [**UIPageControl**][4].

# Task Lists
- [x] Add to [CocoaPods Specs][5]
- [x] Add an example on Swift
- [x] Add an example on Objective-C
- [ ] Add reuse ability to [PVOnboardPage][6]
- [ ] Bring out bottom controls from [PVOnboardView][7]

# Requirements
Xcode 8. Ready for use on iOS 8+

# Install
Adding the following to your Podfile and running pod install should do the trick:
```
pod 'PVOnboardKit'
```

1. Import [PVOnboardKit][2]
1. Create [PVOnboardView][7] and add to your view
1. Implement [PVOnboardViewDelegate][8] and [PVOnboardViewDataSource][9] and assign to instance of [PVOnboardView][7]
1. Call reloadData from instance of [PVOnboardView][7]
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

Thank @TanguyAladenise for [**TAPageControl**][3].

# Community

Questions, comments, issues, and pull requests are always welcome😄❕

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
