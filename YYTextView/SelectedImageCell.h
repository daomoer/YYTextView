//
//  SelectedImageCell.h
//  YYTextView
//
//  Created by Domo on 2018/5/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedImageCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
- (IBAction)selectBtnClick:(id)sender;

@end
