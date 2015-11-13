//
//  CanvasViewController.m
//  Canvas
//
//  Created by Robin Wu on 11/12/15.
//  Copyright © 2015 Robin Wu. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (weak, nonatomic) IBOutlet UIImageView *happyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *winkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *deadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tongueImageView;
@property (weak, nonatomic) IBOutlet UIImageView *excitedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *downArrowImageView;

@property (nonatomic, assign) CGPoint trayOriginalCenter;

@property (nonatomic, assign) CGPoint trayCenterWhenOpen;
@property (nonatomic, assign) CGPoint trayCenterWhenClosed;

@property (nonatomic, strong) UIImageView *newlyCreatedFace;


@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGPoint location = self.trayView.center;
    self.trayCenterWhenOpen = location;
    
//    CGPoint closedLocation = self.trayView.center;
    self.trayCenterWhenClosed = CGPointMake(self.trayView.center.x, self.trayView.center.y + 140);
}

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(location));
        self.trayOriginalCenter = location;
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed at: %@", NSStringFromCGPoint(location));
        
        CGPoint translation = [sender translationInView:self.view];
        
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x + translation.x,
                                      self.trayOriginalCenter.y + translation.y);
        
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture ended at: %@", NSStringFromCGPoint(location));
        
        [UIView animateWithDuration:1.0 animations:^{
            self.trayView.center = self.trayCenterWhenClosed;
        }];
    }
    
}

- (IBAction)onHappyFacePanGesture:(UIPanGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        // Gesture recognizers know the view they are attached to
        UIImageView *imageView = (UIImageView *)sender.view;
        
        // Create a new image view that has the same image as the one currently panning
        self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
        
        // Add the new face to the tray's parent view.
        [self.view addSubview:self.newlyCreatedFace];
        
        // Initialize the position of the new face.
        self.newlyCreatedFace.center = imageView.center;
        
        // Since the original face is in the tray, but the new face is in the
        // main view, you have to offset the coordinates
        CGPoint faceCenter = self.newlyCreatedFace.center;
        self.newlyCreatedFace.center = CGPointMake(faceCenter.x,
                                                   faceCenter.y + self.trayView.frame.origin.y);
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [sender translationInView:self.newlyCreatedFace];
        
        self.newlyCreatedFace.center = CGPointMake(self.newlyCreatedFace.center.x + translation.x,
                                           self.newlyCreatedFace.center.y + translation.y);

        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
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
