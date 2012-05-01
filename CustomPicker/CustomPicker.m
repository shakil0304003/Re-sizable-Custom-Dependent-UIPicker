//
//  CustomPicker.m
//  UIPicker
//
//  Created by USER on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomPicker.h"
#import "CustomPickerItem.h"

@implementation CustomPicker
@synthesize DataSource,NumberOfColumn;
@synthesize customDelegate;

- (void)baseInit {
    
    DataSource = [[NSMutableArray alloc] init];
    NumberOfColumn = 0;
    CurrentColumns = [[NSMutableArray alloc] init];
    CurrentColumnsIndex = [[NSMutableArray alloc] init];
    _picker = [[ResizableUIPicker alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _picker.customDelegate = self;
    [self addSubview:_picker];
    [_picker showsSelectionIndicator: TRUE];
}

- (void)showsSelectionIndicator:(BOOL)showed
{
    [_picker showsSelectionIndicator: showed];
}

- (id)initWithFrame:(CGRect)frame
{
 
    self = [super initWithFrame:frame];
    if (self) {
        [self baseInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if ((self = [super initWithCoder:aDecoder])) {
        [self baseInit];        
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark Refresh + ReLayout

- (void)layoutSubviews {
    [super layoutSubviews];        
}

- (void)ColumnsWidth:(NSMutableArray *)widths
{
    _picker.ColumnsWidth = widths;
}

- (void)BackGroundImage:(NSString *)imageName
{
    [_picker BackGroundImage:imageName];
}

- (NSInteger)numberOfComponentsInResizableUIPickerView:(ResizableUIPicker *)pickerView
{
	return NumberOfColumn;
}

- (NSInteger)resizableUIPickerView:(ResizableUIPicker *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
	return [DataSource count];
    else
    {
        CustomPickerItem *item = [CurrentColumns objectAtIndex:(component -1)];
        return [item.ChildItems count];
    }
}

#pragma mark Picker Delegate Methods

- (NSString *)resizableUIPickerView:(ResizableUIPicker *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    if(component == 0)
    {
        CustomPickerItem *item = [DataSource objectAtIndex:row];
        return item.Title;
    }
    else
    {
        CustomPickerItem *parentItem = [CurrentColumns objectAtIndex:(component - 1)];
        CustomPickerItem *item = [parentItem.ChildItems objectAtIndex:row];
        
        return item.Title;
    }
    
    return @"";
}

- (void)ResizableUIPickerView:(ResizableUIPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSInteger next = 0;
    
    if(component == 0)
    {
        [CurrentColumns removeAllObjects];
        [CurrentColumnsIndex removeAllObjects];
        [CurrentColumns addObject:[DataSource objectAtIndex:row]];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:row]];
        next = 1;    
    }
    else
    {
        while([CurrentColumns count]>component)
        {
            [CurrentColumns removeLastObject];
            [CurrentColumnsIndex removeLastObject];
        }
        
        CustomPickerItem *parentItem = [CurrentColumns objectAtIndex:(component - 1)];
        [CurrentColumns addObject:[parentItem.ChildItems objectAtIndex:row]];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:row]];
        next = component + 1;
    }
    
    CustomPickerItem *item = [CurrentColumns objectAtIndex:(next - 1)];
    
    for (int i=next; i<NumberOfColumn; i++) {
        [CurrentColumns addObject:[item.ChildItems objectAtIndex:0]];
        item = [item.ChildItems objectAtIndex:0];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:0]];
        [_picker reloadComponent:i];
    }
    
    //[self BalanceSelectRow];
    
    if(customDelegate != nil)
        [customDelegate customPickerView:self didSelectRow:row inComponent:component];
}


- (void) DataBind
{
    [CurrentColumns removeAllObjects];
    [CurrentColumnsIndex removeAllObjects];
    NSMutableArray *temp = DataSource;
    
    for (int i=0; i<NumberOfColumn; i++) {
        [CurrentColumns addObject:[temp objectAtIndex:0]];
        CustomPickerItem *item = [temp objectAtIndex:0];
        temp = item.ChildItems;
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:0]];
    }
    
    [_picker reloadAllComponents];
    //[self BalanceSelectRow];
}

- (void) BalanceSelectRow
{
    for(int i=0;i<NumberOfColumn;i++)
    {
        NSNumber *po = [CurrentColumnsIndex objectAtIndex:i];
        int va = [po integerValue];
        [_picker selectRow:va inComponent:i animated:YES];
    }
}

- (NSInteger) selectedRowInComponent:(NSInteger)component
{
    return [_picker selectedRowInComponent:component];
}

- (NSString*) selectedRowValueInComponent:(NSInteger)component
{
    CustomPickerItem *item = [CurrentColumns objectAtIndex:component];
    return item.Title;
}

- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    NSInteger next = 0;
    
    if(component == 0)
    {
        [CurrentColumns removeAllObjects];
        [CurrentColumnsIndex removeAllObjects];
        [CurrentColumns addObject:[DataSource objectAtIndex:row]];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:row]];
        next = 1;
        [_picker selectRow:row inComponent:component animated:animated];
    }
    else
    {
        while([CurrentColumns count]>component)
        {
            [CurrentColumns removeLastObject];
            [CurrentColumnsIndex removeLastObject];
        }
        
        CustomPickerItem *parentItem = [CurrentColumns objectAtIndex:(component - 1)];
        [CurrentColumns addObject:[parentItem.ChildItems objectAtIndex:row]];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:row]];
        next = component + 1;
        [_picker selectRow:row inComponent:component animated:animated];
    }
    
    CustomPickerItem *item = [CurrentColumns objectAtIndex:(next - 1)];
    
    for (int i=next; i<NumberOfColumn; i++) {
        [CurrentColumns addObject:[item.ChildItems objectAtIndex:0]];
        item = [item.ChildItems objectAtIndex:0];
        [CurrentColumnsIndex addObject:[[NSNumber alloc] initWithInt:0]];
        [_picker reloadComponent:i];
    }
    /*
    for(int i=0;i<NumberOfColumn;i++)
    {
        NSNumber *po = [CurrentColumnsIndex objectAtIndex:i];
        int va = [po integerValue];
        [_picker selectRow:va inComponent:i animated:animated];
    }
     */
}

- (void)ColumnsAlignment:(NSMutableArray *)columnsAlignment
{
    _picker.ColumnsAlignment = columnsAlignment;
}

- (void)FontSize:(NSInteger) size
{
    _picker.FontSize = size;
}

- (void)ColumnHorizontalGap:(NSInteger) gap
{
    _picker._cellHorijontalGap = gap;
}

- (void)PerRowHeight:(NSInteger) height
{
    _picker._perRowHeight = height;
}

@end
