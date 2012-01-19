//
//  CatmullRomSplineVIew.h
//  SimpleObjectiveChipmunk
//
//  Created by Ben Ford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatmullRomSplineView : UIView {
    CGPoint *dragPoint;
    
    UIColor *splineColor;
    UIColor *handleColor;
}

@property (nonatomic, assign) CGPoint handle1;
@property (nonatomic, assign) CGPoint handle2;
@property (nonatomic, assign) CGPoint point1;
@property (nonatomic, assign) CGPoint point2;
@end
