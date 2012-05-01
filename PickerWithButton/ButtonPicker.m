//
//  ButtonPicker.m
//  UIPicker
//
//  Created by USER on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonPicker.h"

@implementation ButtonPicker
@synthesize customDelegate;

- (void)baseInit {
    // Width 334 Height 572
    _width = (NSInteger)self.frame.size.width;
    _height = (NSInteger)self.frame.size.height;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    imageView.backgroundColor = [UIColor grayColor];
    [self addSubview:imageView];
    //imageView.backgroundColor = [UIColor clearColor];
    self.superview.backgroundColor = [UIColor clearColor];
    
    CGFloat pickerX = (CGFloat)(6 * _width)/(CGFloat)334;
    CGFloat pickerY = (CGFloat)(25 * _height)/(CGFloat)572;
    CGFloat pickerWidth = (CGFloat)(322 * _width)/(CGFloat)334;
    CGFloat pickerHeight = (CGFloat)(480*_height)/(CGFloat)572;
    
    _picker = [[CustomPicker alloc] initWithFrame:CGRectMake(pickerX, pickerY, pickerWidth, pickerHeight)]; // 6, 25, 322, 480
    _picker.customDelegate = self;
    [self addSubview:_picker];
    
    [_picker FontSize:(20 * _width)/334];
    [_picker ColumnHorizontalGap:(20 * _width)/334];
    [_picker PerRowHeight:(54 * _height)/572];
    [_picker showsSelectionIndicator: TRUE];
    
    NSMutableArray *widths = [[NSMutableArray alloc] init];
    CGFloat columnWidth = (CGFloat)(172 * _width)/(CGFloat)334;
    [widths addObject:[[NSNumber alloc] initWithInt:columnWidth]];
    columnWidth = (CGFloat)(75 * _width)/(CGFloat)334;
    [widths addObject:[[NSNumber alloc] initWithInt:columnWidth]];
    [widths addObject:[[NSNumber alloc] initWithInt:columnWidth]];
    
    NSMutableArray *alignment = [[NSMutableArray alloc] init];
    [alignment addObject:[[NSNumber alloc] initWithInt: UITextAlignmentLeft]];
    [alignment addObject:[[NSNumber alloc] initWithInt: UITextAlignmentCenter]];
    [alignment addObject:[[NSNumber alloc] initWithInt: UITextAlignmentCenter]];
    [_picker ColumnsAlignment:alignment];
    
    [_picker ColumnsWidth:widths];
    
    UIButton *btnReading = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat btnReadingX = (CGFloat)(6 * _width)/(CGFloat)334;
    CGFloat btnReadingY = (CGFloat)(516 * _height)/(CGFloat)572;
    CGFloat btnReadingWidth = (CGFloat)(321 * _width)/(CGFloat)334;
    CGFloat btnReadingHeight = (CGFloat)(44*_height)/(CGFloat)572;
    
    [btnReading setFrame:CGRectMake(btnReadingX, btnReadingY, btnReadingWidth, btnReadingHeight)];
    [btnReading setTitle:@"Go" forState:UIControlStateNormal];
    [btnReading setTitle:@"Go" forState:UIControlStateHighlighted];
    [btnReading setTitle:@"Go" forState:UIControlStateSelected];
    
    [btnReading addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];    
    [self addSubview:btnReading];
    
    CGFloat searchBarX = (CGFloat)(7 * _width)/(CGFloat)334;
    CGFloat searchBarY = (CGFloat)(25 * _height)/(CGFloat)572;
    CGFloat searchBarWidth = (CGFloat)(320 * _width)/(CGFloat)334;
    CGFloat searchBarHeight = (CGFloat)44;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(searchBarX, searchBarY, searchBarWidth, searchBarHeight) ];
    [_searchBar setPlaceholder:@"Search"];
    _searchBar.delegate = self;
    [_searchBar setClipsToBounds:TRUE];
    [self addSubview:_searchBar];
    
    _searchTableRowsData = [[NSMutableArray alloc] init];
    CGFloat searchTableX = (CGFloat)(7 * _width)/(CGFloat)334;
    CGFloat searchTableY = searchBarY + searchBarHeight; // 69
    CGFloat searchTableWidth = (CGFloat)(320 * _width)/(CGFloat)334;
    CGFloat searchTableHeight = pickerHeight - (searchTableY - pickerY);//436
    _searchTable = [[UITableView alloc] initWithFrame:CGRectMake(searchTableX, searchTableY, searchTableWidth, searchTableHeight)];
    _searchTable.hidden = TRUE;
    _searchTable.dataSource = self;
    _searchTable.delegate = self;
    [self addSubview:_searchTable];
    
    _searchBarClearTextClick = FALSE;
    for (UIView *view in _searchBar.subviews){
        if ([view isKindOfClass: [UITextField class]]) {
            UITextField *tf = (UITextField *)view;
            tf.delegate = self;
            break;
        }
    }
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

- (void) DataBind
{
    [_picker DataBind];
}

- (void) DataSource:(NSMutableArray*)dataSource
{
    _picker.DataSource = dataSource;
}

- (void) NumberOfColumn:(NSInteger)numberOfColumn
{
    _numberOfColumn = numberOfColumn;
    _picker.NumberOfColumn = numberOfColumn;
}

- (NSInteger) selectedRowInComponent:(NSInteger)component
{
    return [_picker selectedRowInComponent:component];
}

- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    [_picker selectRow:row inComponent:component animated:animated];
}

- (void)showsSelectionIndicator:(BOOL)showed
{
    //[_picker showsSelectionIndicator:showed];
}

- (void)customPickerView:(CustomPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(customDelegate!=nil)
        [customDelegate buttonPickerView:self didSelectRow:row inComponent:component];
}

- (IBAction)buttonClick:(id)sender
{
    NSMutableArray *selectedColumns = [[NSMutableArray alloc] init];
    
    for (int i=0; i<_numberOfColumn; i++) {
        if(i == 0 && [_searchTable isHidden] == FALSE)
        {
            NSIndexPath *selectedIndexPath = [_searchTable indexPathForSelectedRow];
            
            if(selectedIndexPath != nil)
                [selectedColumns addObject:[_searchTableRowsData objectAtIndex:selectedIndexPath.row]];
            else if([_searchTableRowsData count] == 1)
                [selectedColumns addObject:[_searchTableRowsData objectAtIndex:0]];
            else
                [selectedColumns addObject:[_picker selectedRowValueInComponent:i]];
        }
        else
        [selectedColumns addObject:[_picker selectedRowValueInComponent:i]];
    }
    
    if(customDelegate!=nil)
        [customDelegate buttonPickerView:self buttonClicked:selectedColumns];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if([_searchTable isHidden])
    {
        _searchTable.hidden = TRUE;
        [_searchBar setShowsCancelButton:NO animated:YES];
        [_searchBar resignFirstResponder];
        _searchBarClearTextClick = YES;
    }
    
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    if(_searchBarClearTextClick == FALSE)
    {
    [self SearchTableReload];
    _searchTable.hidden = FALSE;
    [_searchBar setShowsCancelButton:YES animated:YES];
    }
    else
        [_searchBar resignFirstResponder];
    
    _searchBarClearTextClick = FALSE;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _searchBar.text = @"";
    _searchTable.hidden = TRUE;
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if(_searchBarClearTextClick == FALSE)
        [self SearchTableReload];
    else
        [_searchBar resignFirstResponder];
}

- (void)SearchTableReload
{
    NSString *searchString = _searchBar.text.lowercaseString;
    _searchTableRowsData = [[NSMutableArray alloc] init];
    _searchTableRowsIndex = [[NSMutableArray alloc] init];
    NSInteger lenth = [searchString length],selectedIndex = -1;
    
    for(int i=0;i<[_picker.DataSource count];i++)
    {
        CustomPickerItem *item = [_picker.DataSource objectAtIndex:i];
        
        if(item.Title.length >= lenth && [[item.Title.lowercaseString substringWithRange:NSMakeRange(0, lenth)] isEqualToString:searchString]==TRUE)
        {
            [_searchTableRowsData addObject: item.Title];
            [_searchTableRowsIndex addObject:[[NSNumber alloc] initWithInt:i]];
            
            if([item.Title.lowercaseString isEqualToString:searchString])
                selectedIndex = ([_searchTableRowsData count] - 1);
        }
    }
    
    [_searchTable reloadData];
    
    if(selectedIndex != -1)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [_searchTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    return [_searchTableRowsData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell.
    cell.textLabel.text = [_searchTableRowsData objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    [_searchBar resignFirstResponder];
    _searchTable.hidden = TRUE;
    [_searchBar setShowsCancelButton:NO animated:YES];
    NSNumber *temp = [_searchTableRowsIndex objectAtIndex:indexPath.row];
    NSInteger selectIndex = [temp integerValue];
    [_picker selectRow:selectIndex inComponent:0 animated:YES];
     */
    _searchBar.text = [_searchTableRowsData objectAtIndex:indexPath.row];
}


@end
