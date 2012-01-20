//
//  AboutViewController.m
//  CardinalSpline
//
//  Created by Ben Ford on 1/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController

- (id)init {
    if( (self = [super initWithNibName:@"AboutView" bundle:nil]) ) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tap:(UIGestureRecognizer *)tapGesture {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
