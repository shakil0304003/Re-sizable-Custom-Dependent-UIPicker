//
//  ButtonPicker.h
//  UIPicker
//
//  Created by USER on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPicker.h"
#import "CustomPickerItem.h"

@class ButtonPicker;

@protocol ButtonPickerDelegate
- (void)buttonPickerView:(ButtonPicker *)thePickerView buttonClicked:(NSMutableArray*)selectedComponents;
- (void)buttonPickerView:(ButtonPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end


@interface ButtonPicker : UIView<CustomPickerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    CustomPicker *_picker;
    NSInteger _numberOfColumn;
    UISearchBar *_searchBar;
    UITableView *_searchTable;
    NSMutableArray *_searchTableRowsData;
    NSMutableArray *_searchTableRowsIndex;
    BOOL _searchBarClearTextClick;
    NSInteger _width;
    NSInteger _height;
}

@property (assign) id <ButtonPickerDelegate> customDelegate;

- (void) DataBind;
- (void) DataSource:(NSMutableArray*)dataSource;
- (void) NumberOfColumn:(NSInteger)numberOfColumn;
- (NSInteger) selectedRowInComponent:(NSInteger)component;
- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated;
- (void)showsSelectionIndicator:(BOOL)showed;
- (IBAction)buttonClick:(id)sender;
- (void)SearchTableReload;

@end
