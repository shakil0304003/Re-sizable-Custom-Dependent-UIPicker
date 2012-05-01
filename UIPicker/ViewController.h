//
//  ViewController.h
//  UIPicker
//
//  Created by USER on 12/8/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ButtonPicker.h"

@interface ViewController : UIViewController<ButtonPickerDelegate>
{
    IBOutlet ButtonPicker *customPicker;
}

@end
