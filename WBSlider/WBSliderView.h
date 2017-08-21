//
//  WBSliderView.h
//  WBSlider
//
//  Created by 王文博 on 2017/8/21.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBSliderLabel;
@protocol WBSliderViewDelegate;

@interface WBSliderView : UIView {
    UISlider *_slider;
    UILabel *_label;
    id<WBSliderViewDelegate> delegate;
    BOOL _sliding;
}

@property (nonatomic, assign) NSString *text;
@property (nonatomic, assign) UIColor *labelColor;
@property (nonatomic, assign)id<WBSliderViewDelegate> delegate;

@end

@protocol WBSliderViewDelegate <NSObject>

- (void) sliderDidSlide:(float)value;

@end



