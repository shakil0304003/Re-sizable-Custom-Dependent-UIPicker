//
//  CustomPickerItem.h
//  UIPicker
//
//  Created by USER on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomPickerItem : NSObject
{
    NSString *Title;
    NSMutableArray *ChildItems;
}

@property (nonatomic, retain) NSString *Title;
@property (nonatomic, retain) NSMutableArray *ChildItems;

@end
