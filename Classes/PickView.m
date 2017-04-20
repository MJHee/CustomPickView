//
//  PickView.m
//  CustomePickView
//
//  Created by MJHee on 2017/4/19.
//  Copyright © 2017年 MJBaby. All rights reserved.
//

#import "PickView.h"

//顶部nav导航+状态条
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/480.0


#define UIColorFromRGBA(rgbValue, alphaValue) \
    [UIColor \
colorWithRed: ((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green: ((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue: ((float)(rgbValue & 0x0000FF))/255.0 \
alpha: alphaValue]

#define UIColorFromRGB(rgbValue) UIColorFromRGBA(rgbValue, 1.0)


@interface PickView () <UIPickerViewDataSource, UIPickerViewDelegate>
//确定和取消按钮
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;

@property(nonatomic,strong)UIPickerView *pickView;
//背景视图
@property(nonatomic,strong)UIView *backView;
//选中的数据
@property (nonatomic, strong) NSString *selectData;


@end

@implementation PickView

-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        //页面透明背景相当于蒙版
        _backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _backView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_backView addGestureRecognizer:tap];
        [self addSubview:_backView];
        
        //存放按钮、picker的白色背景
        UIView *view =[[UIView alloc] initWithFrame:CGRectMake(0, kScreenH - 180*Height,kScreenW, 30*Height)];
        view.backgroundColor = UIColorFromRGB(0xf4f4f4);
        [_backView addSubview:view];

        //取消、确认按钮创建
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(10*Width, 0*Height, 40*Width, 30*Height)];
        [_cancelBtn addTarget:self action:@selector(cancelpickview) forControlEvents:UIControlEventTouchUpInside];
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIColorFromRGB(0x3699FF) forState:UIControlStateNormal];
        [view addSubview:_cancelBtn];
        
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(270*Width, 0*Height, 40*Width, 30*Height)];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureselectBtn) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:UIColorFromRGB(0x3699FF) forState:UIControlStateNormal];
        [view addSubview:_sureBtn];
        
        //picker创建
        _pickView =[[UIPickerView alloc] initWithFrame:CGRectMake(0, kScreenH - 150*Height, kScreenW, 150*Height)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_pickView];
        
        [_pickView reloadAllComponents];
        
    }
    return self;
}

//选择方法
-(void)sureselectBtn
{
    if (self.sureselectBlock) {
        self.sureselectBlock(self.selectData);
    }
    [self dismiss];
}

//取消方法
-(void)cancelpickview
{
    if (self.cancelselectBlock) {
        self.cancelselectBlock();
    }
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{

        self.alpha = 1;

    }];
}

- (void)dismiss{

    [UIView animateWithDuration:0.3 animations:^{

        self.alpha = 0;

    } completion:^(BOOL finished) {

        [self removeFromSuperview];

    }];
}

- (void)setYearArray:(NSMutableArray *)yearArray {
    _yearArray = yearArray;
    [_pickView selectRow:0 inComponent:0 animated:NO];
    self.selectData = yearArray[[_pickView selectedRowInComponent:0]];
}


#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.yearArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.yearArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectData = self.yearArray[[pickerView selectedRowInComponent:0]];
}


@end
