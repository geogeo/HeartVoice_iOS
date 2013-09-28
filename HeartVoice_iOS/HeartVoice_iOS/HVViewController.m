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
    
    //add FUSbutton
    _FUSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _FUSButton.frame =CGRectMake(85, 205, 72, 44);
    [_FUSButton setTitle:@"常用语" forState:UIControlStateNormal];
    [self.view addSubview:_FUSButton];
    [_FUSButton addTarget:self action:@selector(onPushFUSViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onPushFUSViewController:(id)sender{
    //add FUSController
    _FUSViewController = [HVFUSViewController alloc];
    [self.navigationController pushViewController:_FUSViewController animated:TRUE];
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


