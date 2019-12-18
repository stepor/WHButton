//
//  WHButtonGradientBgInfo.h
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/18.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHButtonConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHButtonGradientBgInfo : NSObject

+(instancetype)infoWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction;
+(instancetype)infoWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)cornerRadius;

//背景信息
@property (nonatomic, copy) NSArray<UIColor *> *colors;
@property (nonatomic, assign) GKGradientDirection direction;
@property (nonatomic, assign) CGFloat cornerRadius;//圆角大小， 默认 WHButtonGradientRoundRadius 即 圆角 大小为 MIN(width, height)/2.0

@property (nonatomic, assign) CGSize imageSize;//图片尺寸大小 默认 CGSizeZero 由WHButton 内部使用
@end

NS_ASSUME_NONNULL_END
