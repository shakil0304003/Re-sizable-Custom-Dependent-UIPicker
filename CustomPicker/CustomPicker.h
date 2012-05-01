//
//  CustomPicker.h
//  UIPicker
//
//  Created by USER on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResizableUIPicker.h"

@class CustomPicker;

@protocol CustomPickerDelegate
- (void)customPickerView:(CustomPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@interface CustomPicker : UIView<ResizableUIPickerDelegate>
{
    ResizableUIPicker  *_picker;
    
    NSMutableArray *DataSource;
    NSInteger NumberOfColumn;
    NSMutableArray *CurrentColumns;
    NSMutableArray *CurrentColumnsIndex;
}

@property (assign) id <CustomPickerDelegate> customDelegate;
@property (nonatomic, retain) NSMutableArray *DataSource;
@property NSInteger NumberOfColumn;

- (void) DataBind;
- (void) BalanceSelectRow;
- (NSInteger) selectedRowInComponent:(NSInteger)component;
- (NSString*) selectedRowValueInComponent:(NSInteger)component;
- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (void)showsSelectionIndicator:(BOOL)showed;
- (void)ColumnsWidth:(NSMutableArray *)widths;
- (void)BackGroundImage:(NSString *)imageName;
- (void)ColumnsAlignment:(NSMutableArray *)columnsAlignment;
- (void)FontSize:(NSInteger) size;
- (void)ColumnHorizontalGap:(NSInteger) gap;
- (void)PerRowHeight:(NSInteger) height;

@end
