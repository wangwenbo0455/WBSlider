//
//  ViewController.m
//  WBSlider
//
//  Created by 王文博 on 2017/8/21.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "ViewController.h"
#import "WBSliderView.h"
@interface ViewController ()<WBSliderViewDelegate>
@property (strong, nonatomic) WBSliderView *WBSlider;//滑块不带边框

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _WBSlider = [[WBSliderView alloc] initWithFrame:CGRectMake(20.0, 165.0, [[UIScreen mainScreen] bounds].size.width-38.0, 50)];
    _WBSlider.backgroundColor = [UIColor grayColor];
    [_WBSlider setText:@"向左滑动结束睡眠记录"];
    [_WBSlider setDelegate:self];
    [self.view addSubview:_WBSlider];

    // Do any additional setup after loading the view, typically from a nib.
}



- (void) sliderDidSlide:(float)value
{
    NSLog(@"%f",value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
