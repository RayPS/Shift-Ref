//
//  PageContentViewController.h
//  Shift Ref
//
//  Created by Ray on 11/22/14.
//  Copyright (c) 2014 RayPS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (weak, nonatomic) IBOutlet UIButton *startAgain;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;

@property NSUInteger pageIndex;
@property NSString *imageFile;

@end
