

#import <UIKit/UIKit.h>
#import "WHButtonConst.h"

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (GKGradient)
+ (instancetype)imageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction;
+ (instancetype)imageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)radius;
@end

NS_ASSUME_NONNULL_END
