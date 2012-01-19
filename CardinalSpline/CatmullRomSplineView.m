//
//  CatmullRomSplineVIew.m
//  SimpleObjectiveChipmunk
//
//  Created by Ben Ford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CatmullRomSplineView.h"

#define kPointSize 10
#define kHandleMultiplier 5.0f

@interface CatmullRomSplineView(PrivateMethods)

- (CGFloat)catmullRomForTime:(CGFloat)t p0:(CGFloat)P0 p1:(CGFloat)P1 p2:(CGFloat)P2 p3:(CGFloat)P3;

- (CGRect)rectForPoint:(CGPoint)somePoint size:(CGFloat)size;
@end

@implementation CatmullRomSplineView
@synthesize handle1;
@synthesize handle2;
@synthesize point1;
@synthesize point2;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.handle1 = CGPointMake(10.0f, 250.0f);
        self.handle2 = CGPointMake(300.0f, 240.0f);
        
        self.point1 = CGPointMake(100.0f, 190.0f);
        self.point2 = CGPointMake(220.0f, 270.0f);
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.cancelsTouchesInView = NO;
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(context, point1.x, point1.y);
    for( CGFloat t = 0.0f; t < 1.01f; t += 0.05f ) {
        CGPoint multipliedHandle1;
        CGPoint multipliedHandle2;
        
        if( handle1.y > point1.y )
            multipliedHandle1.y = handle1.y + (handle1.y-point1.y)*kHandleMultiplier;
        else
            multipliedHandle1.y = handle1.y - (point1.y-handle1.y)*kHandleMultiplier;
        
        if( handle1.x > point1.x )
            multipliedHandle1.x = handle1.x + (handle1.x-point1.x)*kHandleMultiplier;
        else
            multipliedHandle1.x = handle1.x - (point1.x-handle1.x)*kHandleMultiplier;
        
        if( handle2.y > point2.y )
            multipliedHandle2.y = handle2.y + (handle2.y-point2.y)*kHandleMultiplier;
        else
            multipliedHandle2.y = handle2.y - (point2.y-handle2.y)*kHandleMultiplier;
        
        if( handle2.x > point2.x )
            multipliedHandle2.x = handle2.x + (handle2.x-point2.x)*kHandleMultiplier;
        else
            multipliedHandle2.x = handle2.x - (point2.x-handle2.x)*kHandleMultiplier;
        
        CGFloat x = [self catmullRomForTime:t p0:multipliedHandle1.x p1:point1.x p2:point2.x p3:multipliedHandle2.x];
        CGFloat y = [self catmullRomForTime:t p0:multipliedHandle1.y p1:point1.y p2:point2.y p3:multipliedHandle2.y];
        CGContextAddLineToPoint(context, x, y);
    }
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextFillEllipseInRect(context, [self rectForPoint:point1 size:kPointSize]);
    CGContextFillEllipseInRect(context, [self rectForPoint:point2 size:kPointSize]);

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillEllipseInRect(context, [self rectForPoint:handle1 size:kPointSize]);
    CGContextFillEllipseInRect(context, [self rectForPoint:handle2 size:kPointSize]);
}


@end

@implementation CatmullRomSplineView(PrivateMethods)

- (CGRect)rectForPoint:(CGPoint)somePoint size:(CGFloat)size {
    return CGRectMake(somePoint.x-size/2.0f, somePoint.y-size/2.0f, size, size);
}

- (CGFloat)catmullRomForTime:(CGFloat)t p0:(CGFloat)P0 p1:(CGFloat)P1 p2:(CGFloat)P2 p3:(CGFloat)P3 {
    return 0.5 * ((2 * P1) +
                  (-P0 + P2) * t +
                  (2*P0 - 5*P1 + 4*P2 - P3) * powf(t,2.0f) +
                  (-P0 + 3*P1- 3*P2 + P3) * powf(t, 3.0f));
}

- (void)pan:(UIPanGestureRecognizer *)panGesture {

    CGPoint touchPoint = [panGesture locationInView:self];
    
    if( panGesture.state == UIGestureRecognizerStateBegan ) {
        if( CGRectContainsPoint([self rectForPoint:point1 size:50], touchPoint) == YES )
            dragPoint = &point1;
        else if( CGRectContainsPoint([self rectForPoint:point2 size:50], touchPoint) == YES )
            dragPoint = &point2;
        else if( CGRectContainsPoint([self rectForPoint:handle1 size:50], touchPoint) == YES )
            dragPoint = &handle1;
        else if( CGRectContainsPoint([self rectForPoint:handle2 size:50], touchPoint) == YES )
            dragPoint = &handle2;
        else
            dragPoint = nil;
        
        if( dragPoint != nil )
            NSLog(@"captured point: %@", NSStringFromCGPoint(*dragPoint));
        else
            NSLog(@"no point found");

    } else if( panGesture.state == UIGestureRecognizerStateChanged ) {
        if( dragPoint != nil ) {
            dragPoint->x = touchPoint.x;
            dragPoint->y = touchPoint.y;
        }
        [self setNeedsDisplay];
    } 
}
@end