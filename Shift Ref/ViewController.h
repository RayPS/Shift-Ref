//
//  ViewController.h
//  Shift Ref
//
//  Created by Ray on 11/22/14.
//  Copyright (c) 2014 RayPS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface ViewController : UIViewController <UIPageViewControllerDataSource>


@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;

@end
