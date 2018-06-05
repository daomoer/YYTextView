//
//  YYUploadImage.m
//  YYTextView
//
//  Created by Domo on 2018/5/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

#import "YYUploadImage.h"
#import "SelectedImageCell.h"
#import "singleModel.h"

@interface YYUploadImage()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataSourse;

@property(nonatomic,strong) UIViewController *superVC;
@end

NSString *const CollectionViewCellID = @"SelectedImageCell";


@implementation YYUploadImage


- (UIViewController *)viewController:(UIView *)view{
    
    UIResponder *responder = view;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]])
            return (UIViewController *)responder;
    
    return nil;
}


-(NSMutableArray *)dataSourse{
    if (!_dataSourse) {
        _dataSourse = [[NSMutableArray alloc] init];
    }
    return _dataSourse;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"1.png",@"2.png", nil];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
        [self initCollectionView];
        [self dataArray];
        [self initModel];
    }
    return self;
}

-(void)initModel{
    for (NSString *imageName in self.dataArray) {
        singleModel *model = [[singleModel alloc] init];
        model.image = [UIImage imageNamed:imageName];
        model.selected = NO;
        [self.dataSourse addObject:model];
    }
}

-(void)initWithUI{
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.frame = CGRectMake(10, 10, 60, 60);
    [selectBtn setImage:[UIImage imageNamed:@"addWaterPring"] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(selectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectBtn];
}


-(void)selectBtnAction{
    //跳转到相机或者相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    
    _superVC = [self viewController:self];
    
    [_superVC presentViewController:imagePickerController animated:YES completion:nil];
}

//pickerController的代理

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    for (singleModel * signerModel in self.dataSourse) {
        signerModel.selected = NO;
    }
    singleModel *model = [[singleModel alloc] init];
    model.image = image;
    model.selected = YES;
    [self.dataSourse insertObject:model atIndex:0];
    [self.collectionView reloadData];
    
}



-(void)initCollectionView{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(60, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80, 0, self.frame.size.width-80,self.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SelectedImageCell" bundle:nil] forCellWithReuseIdentifier:@"SelectedImageCell"];
    
    [self addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSourse.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SelectedImageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    singleModel *model = self.dataSourse[indexPath.row];
    cell.imageView.image = model.image;
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 0.4;
    if (model.selected) {
        cell.selectBtn.hidden = NO;
    }else{
        cell.selectBtn.hidden = YES;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{    
    for (singleModel * signerModel in self.dataSourse) {
        signerModel.selected = NO;
    }
    singleModel * model = self.dataSourse[indexPath.row];
    model.selected = YES;
    [self.collectionView reloadData];

}



@end
