//
//  FaceView.h
//  Happiness
//
//  Created by Yoyo_Chen on 10/15/12.
//  Copyright (c) 2012 Yoyo_Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

//the sender's type,FaceView,will not reply becaouse FaceView class is declared after the definition of this method
//I promise class Faceview will be declared in a second
//@protocol : the same
@class FaceView;
@protocol FaceViewDataSource
//I'm passing myself when I ask my delegate to get my smileness
- (float) smileForFaceview:(FaceView *)sender;
@end

@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

//why do I have this dataSource property
//if someone else wants to control the smileness ,they will set themself as a datasource
//they take any data,object except for setting FaceViewDataSource protocol 
@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;
@end
