//
//  ViewController.m
//  YYTextView
//
//  Created by Domo on 2018/5/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

#import "ViewController.h"
#import "YYTextView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YYTextView *textView = [[YYTextView alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 120)];
//    textView.showTextCount = NO;
    [textView setTextViewBlock:^(NSString *text) {
        NSLog(@"-=%@",text);
    }];
    [self.view addSubview:textView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
