//
//  ResizableUIPicker.h
//  UIPicker
//
//  Created by USER on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResizableUIPicker;

@protocol ResizableUIPickerDelegate
- (NSInteger)numberOfComponentsInResizableUIPickerView:(ResizableUIPicker *)pickerView;
- (NSInteger)resizableUIPickerView:(ResizableUIPicker *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString *)resizableUIPickerView:(ResizableUIPicker *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)ResizableUIPickerView:(ResizableUIPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

@interface ResizableUIPicker : UIView<UIScrollViewDelegate>
{
    UIView *_view;
    UIImageView *_imageView;
    UIImage *_backGroundImage;
    UIView *_barView;
    NSMutableArray *_scoreViews;
    NSMutableArray *_scoreViewsControls;
    NSInteger _width;
    NSInteger _height;
    NSInteger _numberOfColumn;
    NSInteger _perRowHeight;
    NSInteger _cellHorijontalGap;
    NSInteger _cellVerticalGap;
    
    NSMutableArray *_currentColumnsIndex;
    NSMutableArray *_currentlyScroll;
    NSMutableArray *ColumnsWidth;
    NSMutableArray *ColumnsAlignment;
    NSInteger FontSize;
}

@property (assign) id <ResizableUIPickerDelegate> customDelegate;
@property (nonatomic, retain) NSMutableArray *ColumnsWidth;
@property (nonatomic, retain) NSMutableArray *ColumnsAlignment;
@property NSInteger FontSize;
@property NSInteger _cellHorijontalGap;
@property NSInteger _perRowHeight;

- (void)reloadAllComponents;
- (NSInteger) selectedRowInComponent:(NSInteger)component;
- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (void)showsSelectionIndicator:(BOOL)showed;
- (void)BackGroundImage:(NSString *)imageName;
- (void)reloadComponent:(NSInteger)component;
- (void)SelectItemOfTheScrollView:(UIScrollView *)scrollView;
- (void)StartScrolling:(UIScrollView *)scrollView;
- (void)DefaultBackGroundLoad;

@end
