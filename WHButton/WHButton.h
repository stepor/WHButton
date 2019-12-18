//
//  WHButton.h
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/16.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHButtonConst.h"

NS_ASSUME_NONNULL_BEGIN

@interface WHButton : UIButton

+ (instancetype)buttonWithAligment:(WHButtonAlignment)alignment;
- (instancetype)initWithAligment:(WHButtonAlignment)alignment;

@property (nonatomic, assign, readonly) WHButtonAlignment alignment;
//title 和 image 之间的空间，默认为 4
@property (nonatomic, assign) CGFloat middleSpace;
//可以手动设置 title 和 image 的尺寸，否则(CGSizeZero)会根据自有的尺寸来设置
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGSize titleSize;


@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets DEPRECATED_MSG_ATTRIBUTE("该属性已经不起作用, 设置 contentEdgeInsets 和 middleSpace 实现相同效果");
@property (nonatomic, assign) UIEdgeInsets imageEdgeInsets DEPRECATED_MSG_ATTRIBUTE("该属性已经不起作用，设置 contentEdgeInsets 和 middleSpace 实现相同效果");
@end

/*
 * 加一个渐变色的分类
 */

@interface WHButton (GKGradientBg)

//cornerRadius：圆角大小， 默认 WHButtonGradientRoundRadius 圆角 大小为 MIN(width, height)/2.0
- (void)setGradientBgWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction forState:(UIControlState)state;
- (void)setGradientBgWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)cornerRadius forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
