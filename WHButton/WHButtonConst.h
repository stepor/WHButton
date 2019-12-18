//
//  WHButtonConst.h
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/18.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#ifndef WHButtonConst_h
#define WHButtonConst_h

#define WHButtonGradientRoundRadius CGFLOAT_MAX

typedef NS_ENUM(NSInteger, WHButtonAlignment) {
    WHButtonAlignmentTop,//title label 的位置
    WHButtonAlignmentLeft,
    WHButtonAlignmentBottom,
    WHButtonAlignmentRight
};

typedef NS_ENUM(NSInteger, GKGradientDirection) {
    GKGradientDirection_LeftToRight,
    GKGradientDirection_TopToBottom,
    GKGradientDirection_TopLeftToBottomRight,
    GKGradientDirection_BottomLeftToTopRight
};

#endif /* WHButtonConst_h */
