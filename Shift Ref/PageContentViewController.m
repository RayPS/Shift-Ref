//
//  PageContentViewController.m
//  Shift Ref
//
//  Created by Ray on 11/22/14.
//  Copyright (c) 2014 RayPS. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()
@end


@implementation PageContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
    
    if (4 == _pageIndex) {
        self.nextStep.hidden = YES;
    } else {
        self.startAgain.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)startAgain:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StartAgainNotification" object:nil];
}
- (IBAction)nextStep:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollToNextNotification" object:nil];
}
@end
