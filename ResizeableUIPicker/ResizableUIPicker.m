//
//  ResizableUIPicker.m
//  UIPicker
//
//  Created by USER on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ResizableUIPicker.h"

@implementation ResizableUIPicker
@synthesize customDelegate;
@synthesize ColumnsWidth,ColumnsAlignment,FontSize,_cellHorijontalGap,_perRowHeight;

- (void)baseInit {
    
    if(FontSize == 0)
        FontSize = 20;
    
    if(_perRowHeight == 0)
        _perRowHeight = 54;
    
    if(_cellHorijontalGap == 0)
        _cellHorijontalGap = 20;
    
    _cellVerticalGap = 0;
    _width = (NSInteger)self.frame.size.width;
    _height = (NSInteger)self.frame.size.height - 4;
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_imageView];
    
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width, (self.frame.size.height - 4))];
    [self addSubview:_view];
    
    _barView = [[UIView alloc] initWithFrame:CGRectMake(0, (_height-_perRowHeight)/2, self.frame.size.width, _perRowHeight)];
    _barView.backgroundColor = [UIColor colorWithRed:87/255.f green:142/255.f blue:206/255.f alpha:1.f];
    [_barView setAlpha:0.5];
    [_barView setUserInteractionEnabled:NO];
    [self addSubview:_barView];
    
    self.backgroundColor = [UIColor clearColor];
    
    [self reloadAllComponents];
}

- (void)DefaultBackGroundLoad
{
    if(_backGroundImage == nil)
    {
    CGRect rect = CGRectMake(0.0f, 0.0f, _width, _height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    /*
    NSInteger radius = 8;
    CGContextSetRGBFillColor(context, 157.f/255.f,157.f/255.f,157.f/255.f,1.f);
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, 
                    radius, M_PI, M_PI / 2, 1); //STS fixed
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, 
                            rect.origin.y + rect.size.height);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, 
                    rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, 
                    radius, 0.0f, -M_PI / 2, 1);
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, 
                    -M_PI / 2, M_PI, 1);
    
    CGContextFillPath(context);    
    */
    
    CGFloat height = 1;
    CGFloat currentY = 0,currentColor = 157,currentChange = 1;
        NSInteger cornerRadius = 3;
        NSInteger currentCornerRadius = cornerRadius;
        
    while (currentY<=43) {
        
        UIColor *color = [UIColor colorWithRed:currentColor/255.f green:currentColor/255.f blue:currentColor/255.f alpha:1.f];   
        CGRect rect1 = CGRectMake(currentCornerRadius, currentY, _width - 2 * currentCornerRadius, height);
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect1);
        currentY += height;
        currentColor += currentChange;
        
        if(currentCornerRadius>0)
            currentCornerRadius--;
    }
    
    CGFloat total = 495;
    CGFloat currentDensity = 2;
    
    while (currentY<_height/2) {
        height = floor((currentDensity/total)*((CGFloat)(_height/2 - 43)));
        
        if(currentColor>254)
            height = _height/2 - currentY + 1;
            
        if(height>=1)
        {
            UIColor *color = [UIColor colorWithRed:currentColor/255.f green:currentColor/255.f blue:currentColor/255.f alpha:1.f];   
            CGRect rect1 = CGRectMake(0.0f, currentY, _width, height);
            CGContextSetFillColorWithColor(context, [color CGColor]);
            CGContextFillRect(context, rect1);
            currentY += height;
        }
        
        currentColor += currentChange;
        currentDensity += 0.5;
    }
    
    height = 1;
    currentY = _height - 1;
    currentColor = 157;
        currentCornerRadius = cornerRadius;
    
    while (_height - currentY <= 43) {
        
        UIColor *color = [UIColor colorWithRed:currentColor/255.f green:currentColor/255.f blue:currentColor/255.f alpha:1.f];   
        CGRect rect1 = CGRectMake(currentCornerRadius, currentY, _width - (currentCornerRadius * 2), height);
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect1);
        currentY -= height;
        currentColor += currentChange;
        
        if(currentCornerRadius>0)
            currentCornerRadius--;
    }
    
    currentY++;
    currentDensity = 2;
    
    while (currentY>_height/2) {
        height = floor((currentDensity/total)*((CGFloat)(_height/2 - 43)));
        
        if(currentColor>254)
            height = currentY - height/2 + 1;
        
        if(height>=1)
        {
            UIColor *color = [UIColor colorWithRed:currentColor/255.f green:currentColor/255.f blue:currentColor/255.f alpha:1.f];   
            CGRect rect1 = CGRectMake(0.0f, currentY - height, _width, height);
            CGContextSetFillColorWithColor(context, [color CGColor]);
            CGContextFillRect(context, rect1);
            currentY -= height;
        }
        
        currentColor += currentChange;
        currentDensity += 0.5;
    }    
    
    NSInteger preWidth = 0;
    NSInteger separetorBarColor = 130,separetorWidth=3,separetorColorDif=30;
    
    for (int i=0; i<_numberOfColumn-1; i++) {
        NSNumber *po = [ColumnsWidth objectAtIndex:i];
        NSInteger width = [po integerValue];
        preWidth += width;
        width = preWidth;
        NSInteger mid =  (separetorWidth+1)/2;
        
        for (int j=1; j<=separetorWidth; j++) {
            currentColor = separetorBarColor + abs(j - mid) * separetorColorDif;
            
            UIColor *color = [UIColor colorWithRed:currentColor/255.f green:currentColor/255.f blue:currentColor/255.f alpha:1.f];   
            CGRect rect1 = CGRectMake(width - j, 0, 1, _height);
            CGContextSetFillColorWithColor(context, [color CGColor]);
            CGContextFillRect(context, rect1);            
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    _backGroundImage = image;
    _imageView.image = _backGroundImage; 
    
    _imageView.backgroundColor = [UIColor clearColor];
    self.superview.backgroundColor = [UIColor clearColor];
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    UIView *currentView = recognizer.view;
    UIScrollView *scrollView = (UIScrollView *)currentView.superview;
    
    int i=0;
    
    for(UIScrollView *sc in _scoreViews)
    {
        if(sc == scrollView)
        {
            NSArray *viewsToRemove = [_scoreViewsControls objectAtIndex:i];
            int j=0;
                
            for (UIView *v in viewsToRemove) 
            {
                    if(v == currentView)
                    {
                        NSNumber *pastIndex = [_currentColumnsIndex objectAtIndex:i];
                        
                        if(j!=[pastIndex intValue])
                        {
                            [self selectRow:j inComponent:i animated:YES];
                            [customDelegate ResizableUIPickerView:self didSelectRow:j inComponent:i];
                        }
                        break;
                    }
                    j++;
            }
                
            break;
        }
        i++;
    }    
}

-(void)reloadAllComponents
{
    if(customDelegate != nil)
    {
    NSArray *viewsToRemove = [_view subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
    
    _numberOfColumn = [customDelegate numberOfComponentsInResizableUIPickerView:self];
        
    if(ColumnsWidth == nil)
    {
        ColumnsWidth = [[NSMutableArray alloc] init];
        NSInteger perColumnWidth = _width/_numberOfColumn;
        
        for (int i=0; i<_numberOfColumn; i++) {
            [ColumnsWidth addObject:[[NSNumber alloc] initWithInt:perColumnWidth ]];
        }
    }
    
        NSInteger currentX=0;
        _scoreViews = [[NSMutableArray alloc] init];
        _scoreViewsControls = [[NSMutableArray alloc] init];
        _currentColumnsIndex = [[NSMutableArray alloc] init];
        _currentlyScroll = [[NSMutableArray alloc] init];
        
    for (int i=0; i<_numberOfColumn; i++) {
        NSNumber *po = [ColumnsWidth objectAtIndex:i];
        NSInteger width = [po integerValue];
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(currentX, 0, width, _height)];
        
        currentX += width;
        [_view addSubview:scrollView];
        
        NSMutableArray *controls = [[NSMutableArray alloc] init];
        NSInteger currentY = (_height - _perRowHeight)/2;
        NSInteger row = [customDelegate resizableUIPickerView:self numberOfRowsInComponent:i];
        
        for (int j=0; j<row; j++) {
            NSString *title = [customDelegate resizableUIPickerView:self titleForRow:j forComponent:i];
            
            UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(_cellHorijontalGap, currentY + _cellVerticalGap, width - _cellHorijontalGap * 2, _perRowHeight - _cellVerticalGap *2)];
            currentView.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width - _cellHorijontalGap * 2, _perRowHeight - _cellVerticalGap * 2)];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:FontSize]];
            
            if(ColumnsAlignment != nil && [ColumnsAlignment count]>i)
                label.textAlignment =  [(NSNumber*)[ColumnsAlignment objectAtIndex:i] intValue];
            
            label.adjustsFontSizeToFitWidth = NO;
            label.text = title;
            label.backgroundColor = [UIColor clearColor];
            
            if(j==0)
                [label setTextColor:[UIColor redColor]];
            
            [currentView addSubview:label];
            [scrollView addSubview:currentView];
            [controls addObject:currentView];
            currentY += _perRowHeight;
            
            UITapGestureRecognizer *singleFingerTap = 
            [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                    action:@selector(handleSingleTap:)];
            [currentView addGestureRecognizer:singleFingerTap];
        }
        
        currentY += (_height - _perRowHeight)/2;
        [scrollView setContentSize:CGSizeMake(width, currentY)];
        
        scrollView.delegate = self;
        [_scoreViews addObject:scrollView];
        [_scoreViewsControls addObject:controls];
        
        CGRect scrollTarget = CGRectMake(0, 0, width, _height);
        [scrollView scrollRectToVisible:scrollTarget animated:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        
        [_currentColumnsIndex addObject:[[NSNumber alloc] initWithInt:0]];
        [_currentlyScroll addObject:[[NSNumber alloc] initWithInt:0]];
    }
        
        [self DefaultBackGroundLoad];
    }
}

- (void)killScroll:(UIScrollView *)scrollView 
{
    CGPoint offset = scrollView.contentOffset;
    offset.x -= 1.0;
    offset.y -= 1.0;
    [scrollView setContentOffset:offset animated:NO];
    offset.x += 1.0;
    offset.y += 1.0;
    [scrollView setContentOffset:offset animated:NO];
}

- (void)reloadComponent:(NSInteger)component
{
    
        NSNumber *po = [ColumnsWidth objectAtIndex:component];
        NSInteger width = [po integerValue];
        UIScrollView *scrollView = [_scoreViews objectAtIndex:component];
        
        NSNumber *isScrolling = [_currentlyScroll objectAtIndex:component];
    
        if([isScrolling intValue] == 1)
        {
            [scrollView setContentSize:CGSizeMake(width , _height)];
            
            [self killScroll:scrollView];
            
            CGRect scrollTarget = CGRectMake(0, 0, width, _height);
            [scrollView scrollRectToVisible:scrollTarget animated:NO];
            
            [_currentlyScroll removeObjectAtIndex:component];
            [_currentlyScroll insertObject:[[NSNumber alloc] initWithInt:0] atIndex:component];
        }    
    
        NSArray *viewsToRemove = [scrollView subviews];
        for (UIView *v in viewsToRemove) {
            [v removeFromSuperview];
        }
    
        NSMutableArray *controls = [[NSMutableArray alloc] init];
        NSInteger currentY = (_height - _perRowHeight)/2;
        NSInteger row = [customDelegate resizableUIPickerView:self numberOfRowsInComponent:component];
        
        for (int j=0; j<row; j++) {
            NSString *title = [customDelegate resizableUIPickerView:self titleForRow:j forComponent:component];
            
            UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(_cellHorijontalGap, currentY + _cellVerticalGap, width - _cellHorijontalGap * 2, _perRowHeight - _cellVerticalGap *2)];
            currentView.backgroundColor = [UIColor clearColor];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width - _cellHorijontalGap * 2, _perRowHeight - _cellVerticalGap * 2)];
            [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:FontSize]];
            label.adjustsFontSizeToFitWidth = NO;
            label.text = title;
            label.backgroundColor = [UIColor clearColor];
            
            if(j==0)
                [label setTextColor:[UIColor redColor]];
            
            [currentView addSubview:label];
            [scrollView addSubview:currentView];
            [controls addObject:currentView];
            currentY += _perRowHeight;
            
            UITapGestureRecognizer *singleFingerTap = 
            [[UITapGestureRecognizer alloc] initWithTarget:self 
                                                    action:@selector(handleSingleTap:)];
            [currentView addGestureRecognizer:singleFingerTap];
        }
        
        currentY += (_height - _perRowHeight)/2;
        [scrollView setContentSize:CGSizeMake(width, currentY)];
        
        [_scoreViewsControls removeObjectAtIndex:component];
        [_scoreViewsControls insertObject:controls atIndex:component];
        
        CGRect scrollTarget = CGRectMake(0, 0, width, _height);
        [scrollView scrollRectToVisible:scrollTarget animated:NO];
        [scrollView setShowsVerticalScrollIndicator:NO];
        
        [_currentColumnsIndex removeObjectAtIndex:component];
        [_currentColumnsIndex insertObject:[[NSNumber alloc] initWithInt:0] atIndex:component];
}

- (void)BackGroundImage:(NSString *)imageName
{
    _backGroundImage = [UIImage imageNamed:imageName];
    _imageView.image = _backGroundImage; 
    _imageView.backgroundColor = [UIColor clearColor];
    self.superview.backgroundColor = [UIColor clearColor];
}

- (NSInteger) selectedRowInComponent:(NSInteger)component
{
    NSNumber *inde = [_currentColumnsIndex objectAtIndex:component];    
    return [inde integerValue];
}

-(void)SelectedRowLabelColorChange:(UIView *)selectedView
{
    NSArray *views = [selectedView subviews];
    for (UIView *v in views) {
        if([v isMemberOfClass:[UILabel class]])
        {
            UILabel *label = (UILabel*)v;
            [label setTextColor:[UIColor redColor]];
        }
    }
}

- (void) selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated
{
    UIScrollView *scrollView = [_scoreViews objectAtIndex:component];
    
    NSArray *viewsAll = [_scoreViewsControls objectAtIndex:component];
    
    for (UIView *v in viewsAll) 
    {
        NSArray *views = [v subviews];
        for (UIView *vv in views) {
            if([vv isMemberOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel*)vv;
                [label setTextColor:[UIColor blackColor]];
            }
        }
    }    
    
    UIView *selectedView = [[_scoreViewsControls objectAtIndex:component] objectAtIndex:row];
    
    [_currentColumnsIndex removeObjectAtIndex:component];
    [_currentColumnsIndex insertObject:[[NSNumber alloc] initWithInt:row] atIndex:component];    
    
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat pageHeight = scrollView.frame.size.height;
    CGFloat currentYY = selectedView.frame.origin.y - (_height - _perRowHeight)/2;
    CGRect scrollTarget = CGRectMake(0, currentYY, pageWidth, pageHeight);
    [scrollView scrollRectToVisible:scrollTarget animated:animated];
    
    if(animated == YES)
        [self performSelector:@selector(SelectedRowLabelColorChange:) withObject:selectedView afterDelay:0.2];
    else
    {
        NSArray *views = [selectedView subviews];
        for (UIView *v in views) {
            if([v isMemberOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel*)v;
                [label setTextColor:[UIColor redColor]];
            }
        }
    }
}

- (void)showsSelectionIndicator:(BOOL)showed
{
    if(showed == TRUE)
        _barView.hidden = FALSE;
    else
        _barView.hidden = TRUE;
    
    _barView.frame = CGRectMake(0, (_height-_perRowHeight)/2, self.frame.size.width, _perRowHeight);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self StartScrolling:scrollView];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self StartScrolling:scrollView];
}

- (void)StartScrolling:(UIScrollView *)scrollView
{
    int i=0;
    for(UIScrollView *sc in _scoreViews)
    {
        if(sc == scrollView)
        {
            NSArray *viewsToRemove = [_scoreViewsControls objectAtIndex:i];
            
            for (UIView *v in viewsToRemove) 
            {
                NSArray *views = [v subviews];
                for (UIView *vv in views) {
                    if([vv isMemberOfClass:[UILabel class]])
                    {
                        UILabel *label = (UILabel*)vv;
                        [label setTextColor:[UIColor blackColor]];
                    }
                }
            }
            
            [_currentlyScroll removeObjectAtIndex:i];
            [_currentlyScroll insertObject:[[NSNumber alloc] initWithInt:1] atIndex:i];
            break;
        }
        i++;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(decelerate == FALSE)
        [self SelectItemOfTheScrollView:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{
    [self SelectItemOfTheScrollView:scrollView];
}

- (void)SelectItemOfTheScrollView:(UIScrollView *)scrollView
{
    NSInteger currentY = (NSInteger)scrollView.contentOffset.y + (_height - _perRowHeight)/2;
    
    bool selectedIndexChange = FALSE;
    UIView *selectedView = NULL;
    NSInteger minDif = _height * 2;
    int i=0,posi=0;
    
    for(UIScrollView *sc in _scoreViews)
    {
        if(sc == scrollView)
        {
            NSNumber *tempNum = [_currentlyScroll objectAtIndex:i];
            NSInteger isScrolling = [tempNum integerValue];
            
            if(isScrolling == 0)
            {
                tempNum = [_currentColumnsIndex objectAtIndex:i];
                posi = [tempNum integerValue];
                selectedView = [[_scoreViewsControls objectAtIndex:i] objectAtIndex:posi];
            }
            else
            {
            NSArray *viewsToRemove = [_scoreViewsControls objectAtIndex:i];
            int j=0;
            for (UIView *v in viewsToRemove) 
            {
                NSInteger dis = (NSInteger)v.frame.origin.y - currentY;
                
                if(dis<0)
                    dis = - dis;
                
                if(dis<minDif)
                {
                    minDif = dis;
                    selectedView = v;
                    posi = j;
                }
                j++;
                
                
                NSArray *views = [v subviews];
                for (UIView *vv in views) {
                    if([vv isMemberOfClass:[UILabel class]])
                    {
                        UILabel *label = (UILabel*)vv;
                        [label setTextColor:[UIColor blackColor]];
                    }
                }
            }
            
            NSNumber *pastIndex = [_currentColumnsIndex objectAtIndex:i];
            
            if(posi!=[pastIndex intValue])
                selectedIndexChange = TRUE;
            }
            
            [_currentColumnsIndex removeObjectAtIndex:i];
            [_currentColumnsIndex insertObject:[[NSNumber alloc] initWithInt:posi] atIndex:i];
            [_currentlyScroll removeObjectAtIndex:i];
            [_currentlyScroll insertObject:[[NSNumber alloc] initWithInt:0] atIndex:i];
            break;
        }
        i++;
    }
    
    if(selectedView != NULL)
    {
        NSArray *views = [selectedView subviews];
        for (UIView *v in views) {
            if([v isMemberOfClass:[UILabel class]])
            {
                UILabel *label = (UILabel*)v;
                [label setTextColor:[UIColor redColor]];
            }
        }
        
        CGFloat pageWidth = scrollView.frame.size.width;
        CGFloat pageHeight = scrollView.frame.size.height;
        CGFloat currentYY = selectedView.frame.origin.y - (_height - _perRowHeight)/2;
         
        CGRect scrollTarget = CGRectMake(0, currentYY, pageWidth, pageHeight);
        [scrollView scrollRectToVisible:scrollTarget animated:YES];        
        if(selectedIndexChange == TRUE)
        [customDelegate ResizableUIPickerView:self didSelectRow:posi inComponent:i];
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


@end
