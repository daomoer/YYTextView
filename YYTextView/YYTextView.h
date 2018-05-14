//
//  YYTextView.h
//  YYTextView
//
//  Created by Domo on 2018/5/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^YYTextViewBlock)(NSString *text);

@interface YYTextView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

 //占位文字lable
@property(nonatomic , copy) NSString* placeHolderText;
// 最大文字输入量
@property(nonatomic , assign) NSInteger  maxTextCount;
 //是否显示文字统计
@property(nonatomic , assign) BOOL  showTextCount;

@property (nonatomic, copy)YYTextViewBlock textViewBlock;

@end
