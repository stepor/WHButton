
#import "UIImage+GKGradient.h"
@implementation UIImage (GKGradient)

+ (instancetype)imageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction {
    return [self imageWithSize:size colors:colors direction:direction cornerRadius:0];
}

+ (instancetype)imageWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)radius {
    NSMutableArray *cgColors = @[].mutableCopy;
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cgColors addObject:(id)obj.CGColor];
    }];
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGRect rect = CGRectZero;
    rect.size = size;
    if (radius > 0) {
       UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
       [path addClip];
       [path fill];
    } else {
       CGContextFillRect(context, rect);
    }
    
    CGGradientRef gradient = CGGradientCreateWithColors(CGColorGetColorSpace(colors.lastObject.CGColor), ( CFArrayRef)cgColors.copy, NULL);
    CGPoint startPoint, endPoint;
    switch (direction) {
        case GKGradientDirection_LeftToRight: {
            startPoint = CGPointMake(0, size.height/2.0);
            endPoint = CGPointMake(size.width, size.height/2.0);
        }
            break;
        case GKGradientDirection_TopToBottom: {
            startPoint = CGPointMake(size.width/2.0, 0);
            endPoint = CGPointMake(size.width/2.0, size.height);
        }
            break;
        case GKGradientDirection_TopLeftToBottomRight: {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(size.width, size.height);
        }
            break;
        case GKGradientDirection_BottomLeftToTopRight: {
            startPoint = CGPointMake(size.width, 0);
            endPoint = CGPointMake(0, size.height);
        }
            break;
    }
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation|kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    UIGraphicsEndImageContext();
    return image;
}

@end
