//
//  WHButtonGradientBgInfo.m
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/18.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import "WHButtonGradientBgInfo.h"

@implementation WHButtonGradientBgInfo

+(instancetype)infoWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction {
    return [self infoWithColors:colors direction:direction cornerRadius:WHButtonGradientRoundRadius];
}

+(instancetype)infoWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)cornerRadius {
    WHButtonGradientBgInfo *info = [WHButtonGradientBgInfo new];
    info.colors = colors;
    info.direction = direction;
    info.cornerRadius = cornerRadius;
    return info;
}

- (instancetype)init {
    if(self = [super init]) {
        _direction = GKGradientDirection_LeftToRight;
        _cornerRadius = WHButtonGradientRoundRadius;
        _imageSize = CGSizeZero;
    }
    return self;
}

@end
