//
//  ViewController.m
//  WHButton
//
//  Created by 黄文鸿 on 2019/12/16.
//  Copyright © 2019 黄文鸿. All rights reserved.
//

#import "ViewController.h"
#import "WHButton.h"
#import <Masonry/Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WHButton *leftBtn = [self createWHButtonWithAligment:WHButtonAlignmentLeft];//标题在左
    WHButton *rightBtn = [self createWHButtonWithAligment:WHButtonAlignmentRight];//标题在右
    WHButton *topBtn = [self createWHButtonWithAligment:WHButtonAlignmentTop];//标题在上
    WHButton *bottomBtn = [self createWHButtonWithAligment:WHButtonAlignmentBottom];//标题在下
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(200);
        make.centerX.mas_offset(0);
//        make.width.mas_equalTo(60);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftBtn.mas_bottom).mas_offset(40);
        make.centerX.mas_offset(0);
//        make.width.mas_equalTo(60);
    }];
    [topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightBtn.mas_bottom).mas_offset(40);
        make.centerX.mas_offset(0);
//        make.width.mas_equalTo(60);
    }];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topBtn.mas_bottom).mas_offset(40);
        make.centerX.mas_offset(0);
//        make.width.mas_equalTo(60);
    }];
}

- (WHButton *)createWHButtonWithAligment:(WHButtonAlignment)align {
    WHButton *btn = [WHButton buttonWithAligment:align];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
//    btn.imageSize = CGSizeMake(50, 50);
//    btn.titleSize = CGSizeMake(20, 20);
//    btn.titleLabel.backgroundColor = [UIColor purpleColor];
//    btn.imageView.backgroundColor = [UIColor orangeColor];
//    btn.backgroundColor = [UIColor grayColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"normal" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_fail"] forState:UIControlStateNormal];
//    [btn setTitle:@"select....." forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"icon_fail"] forState:UIControlStateSelected];
    
    //渐变色背景
    [btn setGradientBgWithColors:@[[UIColor blueColor], [UIColor purpleColor]] direction:GKGradientDirection_LeftToRight forState:UIControlStateNormal];
    [btn setGradientBgWithColors:@[[UIColor orangeColor], [UIColor whiteColor]] direction:GKGradientDirection_LeftToRight forState:UIControlStateSelected];
    [btn setGradientBgWithColors:@[[UIColor greenColor], [UIColor greenColor]] direction:GKGradientDirection_LeftToRight forState:UIControlStateHighlighted];
    
//    btn.adjustsImageWhenHighlighted = NO;
    btn.contentEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40);
    btn.middleSpace = 10;
    [self.view addSubview:btn];
    return btn;
}

- (void)buttonAction:(WHButton *)btn {
    btn.selected = !btn.selected;
    if(btn.selected) {
        btn.contentEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40);
        btn.middleSpace = 10;
    } else {
        btn.contentEdgeInsets = UIEdgeInsetsMake(40, 40, 40, 40);
        btn.middleSpace = 10;
    }
}

@end
