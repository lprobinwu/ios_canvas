//
//  TabBarViewController.m
//  Canvas
//
//  Created by Robin Wu on 11/12/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "TabBarViewController.h"
#import "YellowViewController.h"
#import "RedViewController.h"
#import "BlueViewController.h"

@interface TabBarViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIViewController *blueViewController;
@property (nonatomic, strong) UIViewController *yellowViewController;
@property (nonatomic, strong) UIViewController *redViewController;

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.blueViewController = [[BlueViewController alloc]init];
    self.redViewController = [[RedViewController alloc]init];
    self.yellowViewController = [[YellowViewController alloc]init];
    
}
- (IBAction)onYellowButtonTapped:(id)sender {
    // remove current
    [self hideContentController:self.currentViewController];
    
    // set the new current
    self.currentViewController = self.yellowViewController;
    
    // add the new current view controller
    
    [self addChildViewController:self.yellowViewController];
    
    self.yellowViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.yellowViewController.view];
    
    [self.yellowViewController didMoveToParentViewController:self];
}

- (IBAction)onBlueButtonTapped:(id)sender {
    // remove current
    [self hideContentController:self.currentViewController];
    
    // set the new current
    self.currentViewController = self.blueViewController;
    
    // add the new current view controller
    
    [self addChildViewController:self.blueViewController];
    
    self.blueViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.blueViewController.view];
    
    [self.blueViewController didMoveToParentViewController:self];
}

- (IBAction)onRedButtonTapped:(id)sender {
    // remove current
    [self hideContentController:self.currentViewController];
    
    // set the new current
    self.currentViewController = self.redViewController;
    
    // add the new current view controller
    
    [self addChildViewController:self.redViewController];
    
    self.redViewController.view.frame = self.contentView.frame;
    [self.contentView addSubview:self.redViewController.view];
    
    [self.redViewController didMoveToParentViewController:self];
}

- (void) hideContentController:(UIViewController *) content {
    if (content != nil) {
        [content willMoveToParentViewController:nil];
        [content.view removeFromSuperview];
        [content removeFromParentViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
