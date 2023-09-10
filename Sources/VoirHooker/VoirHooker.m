#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#if DEBUG
__attribute__((constructor)) static void voir() {
    printf("VoirHooker loaded.\n");
}
#endif

@interface NSObject (Swizzling)
+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector;
@end

@implementation NSObject (Swizzling)
+ (void)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector {
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
@end

@implementation UIView (Orientation)
+ (void)load {
    [self swizzleMethod:@selector(traitCollectionDidChange:) withMethod:@selector(swizzled_traitCollectionDidChange:)];
}

- (void)swizzled_traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [self swizzled_traitCollectionDidChange:previousTraitCollection];
    if ([self respondsToSelector:@selector(notifyOrientation)]) {
        [self performSelector:@selector(notifyOrientation)];
    }
}
@end

@implementation UIViewController (Orientation)
+ (void)load {
    [self swizzleMethod:@selector(viewDidLoad) withMethod:@selector(swizzled_viewDidLoad)];
}

- (void)swizzled_viewDidLoad {
    [self swizzled_viewDidLoad];
    if ([self respondsToSelector:@selector(notifyOrientation)]) {
        [self performSelector:@selector(notifyOrientation)];
    }
}
@end
