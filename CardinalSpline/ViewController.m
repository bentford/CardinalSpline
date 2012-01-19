//
//  ViewController.m
//  CardinalSpline
//
//  Created by Ben Ford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CatmullRomSplineView.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    splineView = [[CatmullRomSplineView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height, self.view.bounds.size.width, self.view.bounds.size.height-headerView.frame.size.height)];
    [self.view insertSubview:splineView belowSubview:instructionsLabel];
}

@end
