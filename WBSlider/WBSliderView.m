//
//  WBSliderView.h
//  WBSlider
//
//  Created by 王文博 on 2017/8/21.
//  Copyright © 2017年 王文博. All rights reserved.
//

#import "WBSliderView.h"
#import <QuartzCore/QuartzCore.h>

#define FRAMES_PER_SEC 10



@interface WBSliderView()
- (void) loadContent;
- (UIImage *) clearPixel;
@end

@implementation WBSliderView
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    if (frame.size.width < 136.0) {
        frame.size.width = 136.0;
    }
    if (frame.size.height < 44.0) {
        frame.size.height = 34.0;
    }
    self = [super initWithFrame:frame];
    if (self) {
        [self loadContent];        
    }
    return self;
}



- (void) loadContent {
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    
    if (!_label || !_slider) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:16];
        [self addSubview:_label];
        
        
        
        
        _slider = [[UISlider alloc] initWithFrame:CGRectZero];
        _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        CGPoint ctr = _slider.center;
        CGRect sliderFrame = _slider.frame;
        sliderFrame.size.width -= 4; //each "edge" of the track is 2 pixels wide
        _slider.frame = sliderFrame;
        _slider.center = ctr;
        _slider.backgroundColor = [UIColor clearColor];
        UIImage *thumbImage = [self thumbWithColor:[UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1.0]];//   换成你自己的图
        [_slider setThumbImage:thumbImage forState:UIControlStateNormal];
        [_slider setMinimumTrackTintColor:[UIColor clearColor]];
        [_slider setMaximumTrackTintColor:[UIColor clearColor]];
        _slider.minimumValue = 0.0;
        _slider.maximumValue = 1.0;
        _slider.continuous = YES;
        _slider.value = 0.0;
        [_slider trackRectForBounds:self.bounds];
        [self addSubview:_slider];
        
        
        [_slider addTarget:self
                   action:@selector(sliderUp:) 
         forControlEvents:UIControlEventTouchUpInside];
        [_slider addTarget:self 
                   action:@selector(sliderUp:) 
         forControlEvents:UIControlEventTouchUpOutside];
        [_slider addTarget:self 
                   action:@selector(sliderDown:) 
         forControlEvents:UIControlEventTouchDown];
        [_slider addTarget:self 
                   action:@selector(sliderChanged:) 
         forControlEvents:UIControlEventValueChanged];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _label.frame = self.bounds;
    _slider.frame = self.bounds;
    self.layer.cornerRadius = self.bounds.size.height/2;
}



- (NSString *) text {
    return [_label text];
}

- (void) setText:(NSString *)text {
    [_label setText:text];
}

- (UIColor *) labelColor {
    return [_label textColor];
}

- (void) setLabelColor:(UIColor *)labelColor {
    [_label setTextColor:labelColor];
}

- (void) sliderUp:(UISlider *)sender {
	if (_sliding) {
		_sliding = NO;
        
        if (_slider.value == 1.0) {
           
        }
        
        if (_slider.value >= 0.5) {
            [_slider setValue:1 animated: YES];
             [_delegate sliderDidSlide:sender.value];
        }else
        {
            [_slider setValue:0.0 animated: YES];
             [_delegate sliderDidSlide:sender.value];
        }
        _label.alpha = 1.0;
	}
}

- (void) sliderDown:(UISlider *)sender {
	if (!_sliding) {
	}
	_sliding = YES;
}

- (void) sliderChanged:(UISlider *)sender {

	_label.alpha = MAX(0.0, 1.0 - (_slider.value * 3.5));
}

- (UIImage *) thumbWithColor:(UIColor*)color {
    CGFloat scale = [UIScreen mainScreen].scale;
    if (scale<1.0) {scale = 1.0;}
    CGSize size = CGSizeMake(self.bounds.size.height*3, self.bounds.size.height*3);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);// 这里选颜色
    CGContextAddArc(context, self.bounds.size.height/3*4.5, self.bounds.size.height/3*4.5, self.bounds.size.height/3*4, 0,2.0 * M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    UIImage *outputImage = [[UIImage alloc] initWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:scale orientation:UIImageOrientationUp];
    UIGraphicsEndImageContext();
    return outputImage;
}


- (UIImage *) clearPixel {
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
