//
//  WHButton.m
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/16.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import "WHButton.h"
#import "WHButtonGradientBgInfo.h"
#import "UIImage+GKGradient.h"

CG_INLINE NSString *
StateKey(UIControlState state) {
    return @(state).stringValue;
}

#define IntrinsicSizeGreater [self intrinsicSizeGreater]

@interface WHButton()

@property (nonatomic, assign) WHButtonAlignment alignment;
@property (nonatomic, strong) NSMutableDictionary<NSString *, WHButtonGradientBgInfo *> *bgInfoDict;

@end

@implementation WHButton {
    CGRect contentRect_;
    CGRect titleRect_;
    CGRect imageRect_;
}

@dynamic titleEdgeInsets;
@dynamic imageEdgeInsets;

#pragma mark - init
+ (instancetype)buttonWithAligment:(WHButtonAlignment)alignment {
    WHButton *btn = [[self alloc] initWithAligment:alignment];
    return btn;
}
- (instancetype)initWithAligment:(WHButtonAlignment)alignment {
    if(self = [super initWithFrame:CGRectZero]) {
        _alignment = alignment;
        _middleSpace = 4;
        contentRect_ = CGRectZero;
        _imageSize = CGSizeZero;
        _titleSize = CGSizeZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [self initWithAligment:WHButtonAlignmentRight]) {
        self.frame = frame;
    }
    return self;
}

- (void)layoutSubviews {
    [self layout];
    [self refreshGradientBgImage];
    [super layoutSubviews];
//    NSLog(@"layout");
}

#pragma mark - layout
- (void)layout {
    contentRect_ = CGRectZero;
    imageRect_ = CGRectZero;
    contentRect_ = CGRectZero;
    
    CGSize imgSize;
    if(CGSizeEqualToSize(CGSizeZero, self.imageSize)) {
        imgSize = [self currentImage] ? [self currentImage].size : CGSizeZero;
    } else {
        imgSize = self.imageSize;
    }
    BOOL isImgZero = CGSizeEqualToSize(CGSizeZero, imgSize);
    
    CGSize titSize;
    if(CGSizeEqualToSize(CGSizeZero, self.titleSize)) {
        titSize = [self.titleLabel sizeThatFits:CGSizeZero];
    } else {
        titSize = self.titleSize;
    }
    BOOL isTitZero = CGSizeEqualToSize(CGSizeZero, titSize);
    
    if(isTitZero || isImgZero) {
        if(isTitZero && isImgZero) {
            contentRect_ = CGRectZero;
            imageRect_ = CGRectZero;
            contentRect_ = CGRectZero;
        } else if(isTitZero) {
            CGFloat width = imgSize.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            CGFloat height = imgSize.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            contentRect_ = CGRectMake(0, 0, width, height);
            imageRect_ = CGRectMake(self.contentEdgeInsets.left, self.contentEdgeInsets.top, imgSize.width, imgSize.height);
        } else {
            CGFloat width = titSize.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            CGFloat height = titSize.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            contentRect_ = CGRectMake(0, 0, width, height);
            titleRect_ = CGRectMake(self.contentEdgeInsets.left, self.contentEdgeInsets.top, titSize.width, titSize.height);
        }
    } else {
        CGFloat totalW, totalH;
        if(self.alignment == WHButtonAlignmentTop || self.alignment == WHButtonAlignmentBottom) {//垂直布局
            CGFloat validW = MAX(titSize.width, imgSize.width);
            totalW = validW + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            totalH = titSize.height + imgSize.height + self.middleSpace + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            CGFloat titX = (validW - titSize.width)/2.0+self.contentEdgeInsets.left;
            CGFloat imgX = (validW - imgSize.width)/2.0+self.contentEdgeInsets.left;
            if(self.alignment == WHButtonAlignmentTop) {//标题在上
                titleRect_ = CGRectMake(titX, self.contentEdgeInsets.top, titSize.width, titSize.height);
                imageRect_ = CGRectMake(imgX, CGRectGetMaxY(titleRect_)+self.middleSpace, imgSize.width, imgSize.height);
            } else {                                    //标题在下
                imageRect_ = CGRectMake(imgX, self.contentEdgeInsets.top, imgSize.width, imgSize.height);
                titleRect_ = CGRectMake(titX, CGRectGetMaxY(imageRect_)+self.middleSpace, titSize.width, titSize.height);
            }
        } else {                                                                                  //水平布局
            CGFloat validH = MAX(titSize.height, imgSize.height);
            totalW = titSize.width+imgSize.height+self.middleSpace+self.contentEdgeInsets.left + self.contentEdgeInsets.right;
            totalH = validH + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
            CGFloat titY = (validH - titSize.height)/2.0+self.contentEdgeInsets.top;
            CGFloat imgY = (validH - imgSize.height)/2.0+self.contentEdgeInsets.top;
            if(self.alignment == WHButtonAlignmentLeft) {//标题在左
                titleRect_ = CGRectMake(self.contentEdgeInsets.left, titY, titSize.width, titSize.height);
                imageRect_ = CGRectMake(CGRectGetMaxX(titleRect_)+self.middleSpace, imgY, imgSize.width, imgSize.height);
            } else {                                     //标题在右
                imageRect_ = CGRectMake(self.contentEdgeInsets.left, imgY, imgSize.width, imgSize.height);
                titleRect_ = CGRectMake(CGRectGetMaxX(imageRect_)+self.middleSpace, titY, titSize.width, titSize.height);
            }
        }
        contentRect_ = CGRectMake(0, 0, totalW, totalH);
    }
    
//    NSLog(@"title Size: %@ image size: %@ content bounds: %@", NSStringFromCGSize(titSize), NSStringFromCGSize(imgSize), NSStringFromCGRect(contentRect_));
}

- (void)refreshGradientBgImage {
    if(self.bgInfoDict.count == 0) {
        return;
    }
    [self.bgInfoDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, WHButtonGradientBgInfo * _Nonnull bgInfo, BOOL * _Nonnull stop) {
        UIControlState state = (UIControlState)[key integerValue];
        UIImage *img = [self backgroundImageForState:state];
        CGSize size = IntrinsicSizeGreater ?  contentRect_.size : self.bounds.size;
        if(!img || !CGSizeEqualToSize(bgInfo.imageSize, size)) {//需要绘制图片
//            NSLog(@"绘制");
            bgInfo.imageSize = size;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                CGFloat radius = bgInfo.cornerRadius == WHButtonGradientRoundRadius ? MIN(size.width, size.height)/2.0 : bgInfo.cornerRadius;
                UIImage *img = [UIImage imageWithSize:size colors:bgInfo.colors direction:bgInfo.direction cornerRadius:radius];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self setBackgroundImage:img forState:state];
                });
            });
        } else {
//            NSLog(@"不绘制");
        }
    }];
}

#pragma mark - override 尺寸方法
- (CGRect)contentRectForBounds:(CGRect)bounds {
    if(IntrinsicSizeGreater) {
        return contentRect_;
    } else {
        return bounds;
    }
}

- (CGRect)backgroundRectForBounds:(CGRect)bounds {
    return bounds;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if(CGRectEqualToRect(contentRect, contentRect_)) {
        return titleRect_;
    } else {
        CGFloat deltaW = CGRectGetWidth(contentRect) - CGRectGetWidth(contentRect_);
        CGFloat deltaH = CGRectGetHeight(contentRect) - CGRectGetHeight(contentRect_);
        CGRect titRect = titleRect_;
        titRect.origin.x += deltaW/2.0;
        titRect.origin.y += deltaH/2.0;
        
//        NSLog(@"titrect %@, content rect: %@  content rect_: %@", NSStringFromCGRect(titRect), NSStringFromCGRect(contentRect), NSStringFromCGRect(contentRect_));
        
        return titRect;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    if(CGRectEqualToRect(contentRect, contentRect_)) {
        return imageRect_;
    } else {
        CGFloat deltaW = CGRectGetWidth(contentRect) - CGRectGetWidth(contentRect_);
        CGFloat deltaH = CGRectGetHeight(contentRect) - CGRectGetHeight(contentRect_);
        CGRect imgRect = imageRect_;
        imgRect.origin.x += deltaW/2.0;
        imgRect.origin.y += deltaH/2.0;
        return imgRect;
    }
}

- (CGSize)intrinsicContentSize {
    return contentRect_.size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return contentRect_.size;
}
#pragma mark - public setter
- (void)setMiddleSpace:(CGFloat)middleSpace {
    if(_middleSpace == middleSpace) {
        return;
    }
    _middleSpace = middleSpace;
    [self layout];
    [self invalidateIntrinsicContentSize];
}

- (void)setImageSize:(CGSize)imageSize {
    if(CGSizeEqualToSize(imageSize, _imageSize)) {
        return;
    }
    
    _imageSize = imageSize;
    [self layout];
    [self invalidateIntrinsicContentSize];
}

- (void)setTitleSize:(CGSize)titleSize {
    if(CGSizeEqualToSize(titleSize, _titleSize)) {
        return;
    }
    
    _titleSize = titleSize;
    [self layout];
    [self invalidateIntrinsicContentSize];
}

#pragma mark - getter
- (NSMutableDictionary<NSString *, WHButtonGradientBgInfo *> *)bgInfoDict {
    if(!_bgInfoDict) {
        _bgInfoDict = [NSMutableDictionary new];
    }
    return _bgInfoDict;
}

#pragma mark - 辅助方法
- (BOOL)intrinsicSizeGreater {
    if(CGRectGetWidth(self.bounds) < CGRectGetWidth(contentRect_) && CGRectGetHeight(self.bounds) < CGRectGetHeight(contentRect_)) {
        return YES;
    } else {
        return NO;
    }
}
@end


@implementation WHButton (GKGradientBg)

//cornerRadius：圆角大小， 默认 WHButtonGradientRoundRadius 圆角 大小为 MIN(width, height)/2.0
- (void)setGradientBgWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction forState:(UIControlState)state {
    [self setGradientBgWithColors:colors direction:direction cornerRadius:WHButtonGradientRoundRadius forState:state];
}
- (void)setGradientBgWithColors:(NSArray<UIColor *> *)colors direction:(GKGradientDirection)direction cornerRadius:(CGFloat)cornerRadius forState:(UIControlState)state {
    WHButtonGradientBgInfo *info = [WHButtonGradientBgInfo infoWithColors:colors direction:direction cornerRadius:cornerRadius];
    self.bgInfoDict[StateKey(state)] = info;
    [self setNeedsLayout];
}

@end
