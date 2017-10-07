# CHANGELOG

```
### Added for new features.
### Changed for changes in existing functionality.
### Deprecated for once-stable features removed in upcoming releases.
### Removed for deprecated features removed in this release.
### Fixed for any bug fixes.
```
## 1.1.2
### Improvements
- Fixed mistakes

## 1.1.1
### Added
- Added optional ```-(UIEdgeInsets)onboardView:titleEdgeInsetsForLeftActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```
- Added optional ```-(nullable UIImage *)onboardView:imageForLeftActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```
- Added optional ```-(UIEdgeInsets)onboardView:imageEdgeInsetsForLeftActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```
- Added optional ```-(UIEdgeInsets)onboardView:titleEdgeInsetsForRightActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```
- Added optional ```-(nullable UIImage *)onboardView:imageForRightActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```
- Added optional ```-(UIEdgeInsets)onboardView:imageEdgeInsetsForRightActionButtonAtIndex:``` method to ```PVOnboardViewDataSource```

## 1.1.0
### Added
- Added ```-(instancetype)initWithFooterView:``` method to ```PVOnboardView```

### Improvements
- Made ```PVOnboardPage``` protocol optional
- Made ```PVOnboardFooterView``` public

## 1.0.1

### Improvements
- Fix typos

## 1.0.0

### Changed
- Renamed ```- (void)scrollToTheNextPage:animated``` to ```- (void)scrollToNextPage:animated```
- Renamed ```- (void)scrollToThePreviouslyPage:animated``` to ```- (void)scrollToPreviouslyPage:animated```

### Improvements
- Improved compatibility with Swift

## 0.2.0

### Added
- Added an example on Swift
- Added an example on Objective-C
- Added ```- (CGFloat)onboardViewFooterBottomPadding:(nonnull PVOnboardView *)onboardView``` to ```PVOnboardViewDataSource``` to allow setting the bottom padding for footer view

### Improvements
- Extracted bottom control panel into ```PVOnboardFooterView``` class

## 0.1.0
