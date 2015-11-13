//
//  ClassDemoViewController.m
//  Canvas
//
//  Created by Robin Wu on 11/12/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "ClassDemoViewController.h"

@interface ClassDemoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *happyImageView;

@property(nonatomic, assign) CGPoint originalCenter;

@end

@implementation ClassDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.happyImageView.alpha = 0.5;
    self.originalCenter = self.happyImageView.center;
    
    // add customized code for listening to gesture recognizer event.
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onIconTapped:)];
    [self.happyImageView addGestureRecognizer:gestureRecognizer];
    
}
- (IBAction)onGoTapped:(id)sender {
    NSLog(@"Go Button tapped");
    
    CGPoint imageCenter = self.happyImageView.center;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        
        // runs to us
        self.happyImageView.center = CGPointMake(imageCenter.x, imageCenter.y + 300);
        self.happyImageView.transform = CGAffineTransformMakeScale(3, 3);
        
        self.happyImageView.alpha = 1;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            // Initial rotate by 10 degrees
            CGFloat rotation = 10 * M_PI / 180;
            self.happyImageView.transform = CGAffineTransformRotate(self.happyImageView.transform, rotation);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
                CGFloat rotation = -20 * M_PI / 180;
                self.happyImageView.transform = CGAffineTransformRotate(self.happyImageView.transform, rotation);
            } completion:^(BOOL finished) {
                //
            }];
        }];
    }];
    
}

- (IBAction)onIconTapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Tapped on happy face");
}

- (IBAction)onIconPinched:(UIPinchGestureRecognizer *)sender {
    NSLog(@"Pinched on happy face");
    
//    self.happyImageView.transform = CGAffineTransformScale(self.happyImageView.transform, sender.scale, sender.scale);

    self.happyImageView.transform = CGAffineTransformMakeScale(sender.scale, sender.scale);
}

- (IBAction)onIconPanned:(UIPanGestureRecognizer *)sender {
    NSLog(@"on Happy face Panned");
    
    // locationInView is the location in parent view.
//    CGPoint location = [sender locationInView:self.view];
    
    CGPoint translation = [sender translationInView:self.view];
//    self.happyImageView.center = location;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalCenter = self.happyImageView.center;
        
        self.happyImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.happyImageView.center = CGPointMake(self.originalCenter.x + translation.x, self.originalCenter.y + translation.y);
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        self.happyImageView.transform = CGAffineTransformIdentity;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
