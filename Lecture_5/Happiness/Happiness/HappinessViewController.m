//
//  HappinessViewController.m
//  Happiness
//
//  Created by Yoyo_Chen on 10/15/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>
@property (nonatomic, weak) IBOutlet FaceView *faceview;

@end

@implementation HappinessViewController

@synthesize happiness = _happiness;
@synthesize faceview = _faceview;

- (void) setHappiness:(int)happiness{
    _happiness = happiness;
    [self.faceview setNeedsDisplay];
}

- (void) setFaceview:(FaceView *)faceview{
    
    _faceview = faceview;
    [self.faceview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceview action:@selector(pinch:)]];
    [self.faceview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHappinessGesture:)]];

    // to set the faceview delegate to be our controller
    self.faceview.dataSource = self;
}

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture{
    
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceview];
        self.happiness -= translation.y / 1;
        [gesture setTranslation:CGPointZero inView:self.faceview];
    }
}
// the faceview to the delegate
// the controller to implement the delegation method
//the controller itself is a delegate 


-(float) smileForFaceview:(FaceView *)sender{
    return (self.happiness - 50)/50.0;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

@end
