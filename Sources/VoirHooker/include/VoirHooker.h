#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Swizzling)
+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector;
@end

@interface UIView (Orientation)
- (void)swizzled_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection;
@end

@interface UIViewController (Orientation)
- (void)swizzled_viewWillAppear:(BOOL *)animated;
@end

NS_ASSUME_NONNULL_END
