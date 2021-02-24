# Sidebar iOS 14

This is a sample project demonstrating how to implement the new Sidebar UI on an iPad app using Swift. It tries to mimic the UI of the new Music app on iPadOS 14.0:

![Preview.png](Preview.png)

It contains just the code required to create the UI, and it was based on the Apple's sample project  [Implementing Modern Collection Views](https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views).

## Multiplatform with SwiftUI

Check out [this repository](https://github.com/marcosatanaka/multiplatform-sidebar-swiftui) to see how to do this for a multiplatform app (iOS, iPadOS, macOS) built with SwiftUI.

## TO-DO

- [ ] Maintain the selection when contracting/expanding a section.
- [ ] Restore the state of a view controller when changing between regular and compact mode.
- [x] Revert to tab bar based navigation on compact layouts, and on the iPhone.

## Known bugs

Starting the app in compact mode, and then changing it to regular mode causes the following error:

```
Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Unexpected view controller change in Secondary column for expanding <UISplitViewController: 0x10550a630>'
```

I have a [question for this on the Apple Developer Forums](https://developer.apple.com/forums/thread/653562), I'm not sure if this is a bug in the API, or if I'm using it incorrectly.

## Documentation links

- [Human Interface Guidelines for the Sidebar](https://developer.apple.com/design/human-interface-guidelines/ios/bars/sidebars/)
- [Updated UISplitViewController documentation](https://developer.apple.com/documentation/uikit/uisplitviewcontroller)

## WWDC20 videos

- [Design for iPad](https://developer.apple.com/videos/play/wwdc2020/10206/)
- [Build for iPad](https://developer.apple.com/videos/play/wwdc2020/10105/)
- [Advances in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10097/)
- [Advances in diffable data sources](https://developer.apple.com/videos/play/wwdc2020/10045/)
- [Lists in UICollectionView](https://developer.apple.com/videos/play/wwdc2020/10026/)
- [Modern cell configuration](https://developer.apple.com/videos/play/wwdc2020/10027/)
