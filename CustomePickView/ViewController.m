//
//  ViewController.m
//  CustomePickView
//
//  Created by MJHee on 2017/4/19.
//  Copyright © 2017年 MJBaby. All rights reserved.
//

#import "ViewController.h"
#import "PickView.h"


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *yearArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getYearData];
}

- (void)getYearData{
    
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    for (int i = 2003; i <= [dateComponent year]; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    PickView *pick = [[PickView alloc] initWithFrame: CGRectMake(0, 0, kScreenW, kScreenH)];
    pick.yearArray = self.yearArray;
    pick.sureselectBlock = ^(NSString *selectData) {
        //确认-block
        NSLog(@"selectData = %@", selectData);
    };
    pick.cancelselectBlock = ^() {
        //取消-block
        NSLog(@"cancelselectBlock");
    };
    [pick show];
}

#pragma mark - lazy
- (NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
    }
    return _yearArray;
}

@end
