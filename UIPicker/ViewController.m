//
//  ViewController.m
//  UIPicker
//
//  Created by USER on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CustomPickerItem.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [ customPicker NumberOfColumn:3];
    
    CustomPickerItem *a = [[CustomPickerItem alloc] init];
    a.Title = @"AAAAAA";
    CustomPickerItem *b = [[CustomPickerItem alloc] init];
    b.Title = @"BBBBB";
    CustomPickerItem *a1 = [[CustomPickerItem alloc] init];
    a1.Title = @"CCCCC";
    CustomPickerItem *b1 = [[CustomPickerItem alloc] init];
    b1.Title = @"DDDDD";
    
    CustomPickerItem *c = [[CustomPickerItem alloc] init];
    c.Title = @"C";
    c.ChildItems = [[NSMutableArray alloc] init];
    CustomPickerItem *d = [[CustomPickerItem alloc] init];
    d.Title = @"D";
    d.ChildItems = [[NSMutableArray alloc] init];
    CustomPickerItem *e = [[CustomPickerItem alloc] init];
    e.Title = @"E";
    e.ChildItems = [[NSMutableArray alloc] init];
    CustomPickerItem *f = [[CustomPickerItem alloc] init];
    f.Title = @"F";
    f.ChildItems = [[NSMutableArray alloc] init];
    
    for (int i=1; i<=64; i++) {
        CustomPickerItem *it = [[CustomPickerItem alloc] init];
        it.Title = [NSString stringWithFormat:@"%d",i];
        it.ChildItems = NULL;
        
        if(i<=16)
            [c.ChildItems addObject:it];
        else if(i<=32)
            [d.ChildItems addObject:it];
        else if(i<=48)
            [e.ChildItems addObject:it];
        else
            [f.ChildItems addObject:it];
    }
    
    
    a.ChildItems = [[NSMutableArray alloc] init];
    [a.ChildItems addObject:c];
    [a.ChildItems addObject:d];
    
    b.ChildItems = [[NSMutableArray alloc] init];
    [b.ChildItems addObject:e];
    [b.ChildItems addObject:f];
    
    a1.ChildItems = [[NSMutableArray alloc] init];
    [a1.ChildItems addObject:c];
    [a1.ChildItems addObject:d];
    
    b1.ChildItems = [[NSMutableArray alloc] init];
    [b1.ChildItems addObject:e];
    [b1.ChildItems addObject:f];
    
    NSMutableArray *source = [[NSMutableArray alloc] init];
    [source addObject:a];
    [source addObject:b];
    [source addObject:a1];
    [source addObject:b1];
    
    [customPicker DataSource: source];
    [customPicker DataBind];
    customPicker.customDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)buttonPickerView:(ButtonPicker *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    
}

- (void)buttonPickerView:(ButtonPicker *)thePickerView buttonClicked:(NSMutableArray*)selectedComponents
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Selected row data array!" message:[NSString stringWithFormat:@"%@",selectedComponents] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
}

@end
