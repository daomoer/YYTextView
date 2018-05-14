//
//  YYTextView.m
//  YYTextView
//
//  Created by Domo on 2018/5/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

#import "YYTextView.h"

@interface YYTextView()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
// 文字统计的lable
@property(nonatomic , strong) UILabel * textCountLable;
 //占位文字的lable
@property(nonatomic , strong) UILabel * placeHolderLable;
@end

@implementation YYTextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

-(void)initWithUI{
    [self initWithLayer];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(2, 2, self.frame.size.width-4, self.frame.size.height-34)];
    self.textView.delegate = self;
    self.maxTextCount = 300;
    self.placeHolderLable = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width-4, 30)];
    self.placeHolderLable.text = @"请输入...";
    self.placeHolderLable.font = [UIFont systemFontOfSize:15];
    self.placeHolderLable.textColor = [UIColor lightGrayColor];
    [self.textView addSubview:self.placeHolderLable];
    [self addSubview:self.textView];
    
    //创建字数统计lable
    [self creatTextCountLable];
}

-(void)initWithLayer{
    CAShapeLayer* dashLineShapeLayer = [CAShapeLayer layer];
    UIBezierPath* dashLinePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:2];
    
    dashLineShapeLayer.path = dashLinePath.CGPath;
    dashLineShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dashLineShapeLayer.strokeColor = [UIColor colorWithRed:153/255.f green:166/255.f blue:170/255.f alpha:1].CGColor;
    dashLineShapeLayer.lineWidth = 1;
    dashLineShapeLayer.lineDashPattern = @[@(6),@(6)];
    
    dashLineShapeLayer.strokeStart = 0;
    dashLineShapeLayer.strokeEnd = 1;
    dashLineShapeLayer.zPosition = 999;
    [self.layer addSublayer:dashLineShapeLayer];
}

#pragma mark - 设置最大文字输入数量
-(void)setMaxTextCount:(NSInteger)maxTextCount{
    _maxTextCount = maxTextCount;
    _textCountLable.text = [NSString stringWithFormat:@"已输入0/可输入%zd",self.maxTextCount];
    
}

#pragma mark - 代理方法,textView里面的内容发生改变的时候
- (void)textViewDidChange:(UITextView *)textView{
    if (self.textView.text.length >= self.maxTextCount) {
        self.textView.text = [self.textView.text substringToIndex:self.maxTextCount];
    }
    self.placeHolderLable.hidden = self.textView.text.length;
    self.textCountLable.text = [NSString stringWithFormat:@"已输入%d/可输入%d",(int)self.textView.text.length, (int)(self.maxTextCount- self.textView.text.length)];
    self.textCountLable.textColor = self.textView.text.length < self.maxTextCount? [UIColor lightGrayColor]:[UIColor redColor];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.textView resignFirstResponder];
        if (_textViewBlock) {
            _textViewBlock(textView.text);
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}


#pragma mark - 创建字数统计lable
-(void)creatTextCountLable{
    _textCountLable = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width-150, self.frame.size.height-30, 150, 30)];
    _textCountLable.text = @"已输入0/可输入300";
    _textCountLable.font = [UIFont systemFontOfSize:15];
    _textCountLable.textColor = [UIColor lightGrayColor];
    [self addSubview:_textCountLable];
    [_textCountLable sizeToFit];
}


-(void)setPlaceHolderText:(NSString *)placeHolderText{
    _placeHolderText = placeHolderText;
    self.placeHolderLable.text = placeHolderText;
}

-(void)setShowTextCount:(BOOL)showTextCount{
    _showTextCount = !showTextCount;
    self.textCountLable.hidden = _showTextCount;
    if (_showTextCount) {
        self.maxTextCount = INT64_MAX;
    }
}

@end
