//
//  HVViewController.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/24/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "HVViewController.h"

@interface HVViewController ()

@end

@implementation HVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    _sttView = [[sttView alloc] initWithFrame:frame];
    self.title = @"心声";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadView{
    self.view=_sttView;
}


@end


