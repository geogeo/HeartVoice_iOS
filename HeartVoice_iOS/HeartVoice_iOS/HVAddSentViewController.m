//
//  HVAddSentViewController.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/30/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "HVAddSentViewController.h"

@interface HVAddSentViewController (){
    UITextView * _sentence;
}

@end

@implementation HVAddSentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UINavigationBar *_navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UINavigationItem *_theNavigationItem = [[UINavigationItem alloc] initWithTitle:nil];
    UIBarButtonItem *_cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel:)];
    UIBarButtonItem *_saveButton = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(onSave:)];
    [_theNavigationItem setTitle:@"添加常用语"];
    [_theNavigationItem setLeftBarButtonItem:_cancelButton];
    [_theNavigationItem setRightBarButtonItem:_saveButton];
    [_navigationBar pushNavigationItem:_theNavigationItem animated:FALSE];
    [self.view addSubview:_navigationBar];
    
    // textarea
    _sentence = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, 300, 80)];
    _sentence.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:_sentence];
    [_sentence becomeFirstResponder];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadView{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *_HVView = [[UIView alloc] initWithFrame:frame];
    _HVView.backgroundColor=[UIColor whiteColor];
    self.view=_HVView;
}

-(void) onCancel:(id)sender{
    [self dismissViewControllerAnimated:TRUE completion:Nil];
    NSLog(@"cancel");
}



-(void) onSave:(id)sender{
    [self dismissViewControllerAnimated:TRUE completion:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addSentence" object:_sentence.text];

    NSLog(@"save");
}

@end
