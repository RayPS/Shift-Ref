//
//  ViewController.m
//  Shift Ref
//
//  Created by Ray on 11/22/14.
//  Copyright (c) 2014 RayPS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) NSUInteger currentIndex;  // indicate current presentation index
@end

@implementation ViewController

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create the data model
    _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png", @"page5.png"];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    [self setNeedsStatusBarAppearanceUpdate];

    
    // Fill background image to View
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"background.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAgain) name:@"StartAgainNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollToNext) name:@"ScrollToNextNotification" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= [self.pageImages count]) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile = self.pageImages[index];
    pageContentViewController.pageIndex = index;
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageImages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return _currentIndex;
}

- (void)scrollForward:(NSUInteger)index {
    PageContentViewController *startingViewController = [self viewControllerAtIndex:index];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)scrollReverse:(NSUInteger)index {
    _currentIndex--;
    PageContentViewController *startingViewController = [self viewControllerAtIndex:index];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

#pragma mark - Page Control

- (void)startAgain
{
    _currentIndex = 4;
    
    [self scrollReverse:3];
    [self scrollReverse:2];
    [self scrollReverse:1];
    [self scrollReverse:0];
}

- (void)scrollToNext
{
    NSArray *viewControllers = [self.pageViewController viewControllers];
    for (UIViewController *vc in viewControllers) {
        if ([vc isKindOfClass:[PageContentViewController class]]) {
            PageContentViewController *pageContentVC = (PageContentViewController *)vc;
            NSUInteger currentIndex = pageContentVC.pageIndex;
            
            _currentIndex = currentIndex;

            if (_currentIndex < 4) {
                _currentIndex++;
                [self scrollForward:_currentIndex];
            }
            
            NSLog(@"%lu",(unsigned long)_currentIndex);
            return;
        }
    }
}

@end
