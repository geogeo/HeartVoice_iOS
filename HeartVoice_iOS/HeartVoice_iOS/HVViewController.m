//
//  HVViewController.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/24/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "HVViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "iflyMSC/IFlySpeechError.h"

@interface HVViewController (){
    
    UIView              *_HVView;
    
    UIButton            *_FUSButton;
    UIButton            *_sttButton;
    UIButton            *_readButton;
    UIButton            *_clearButton;
    
    UITextView          *_textView;
    
    
    HVFUSViewController *_FUSViewController;

}

@end

@implementation HVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"心声";
    

    //set and add textView
    _textView =[[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 190)];
    _textView.font=[UIFont boldSystemFontOfSize:30];
    //_textView.backgroundColor = [UIColor grayColor];
    [[_textView layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[_textView layer] setBorderWidth:1];
    [[_textView layer] setCornerRadius:10];
    _textView.returnKeyType=UIReturnKeyDone;
    _textView.delegate = self;
    _textView.text=@"你好，我是一位聋人，请点下面的按钮对我说话。";
    [self.view addSubview:_textView];
    
    //set and add buttons-------------------------------------------------------------
    //set and add sttButton
    _sttButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _sttButton.frame = CGRectMake(10,255,300,150);
    _sttButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
    [_sttButton setTitle:@"点此对我说话" forState:UIControlStateNormal];
    [_sttButton addTarget:self action:@selector(onBegin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sttButton];
    
    //set and add readButton
    _readButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
    _readButton.frame = CGRectMake(160,205,150,44);
    _readButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [_readButton setTitle:@"朗读" forState:UIControlStateNormal];
    //[_readButton addTarget:self action:@selector(onRead:) forControlEvents:UIControlEventTouchUpInside];
    [_readButton addTarget:self action:@selector(onReadWithOutUI:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_readButton];
    
    //set and add clear Button
    _clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _clearButton.frame = CGRectMake(10, 205, 72, 44);
    _clearButton.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_clearButton setTitle:@"清除" forState:UIControlStateNormal];
    [_clearButton addTarget:self action:@selector(onClear:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_clearButton];
    
    //add FUSbutton
    _FUSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _FUSButton.frame =CGRectMake(85, 205, 72, 44);
    [_FUSButton setTitle:@"常用语" forState:UIControlStateNormal];
    [self.view addSubview:_FUSButton];
    [_FUSButton addTarget:self action:@selector(onPushFUSViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    //set iFly-----------------------------------------------------------------
    
    //set iFlyRecognizerView
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID ];

    
    _iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithOrigin:CGPointMake(10, 60) initParam:initString];
    _iFlyRecognizerView.delegate = self;
    
    
    //set iFlySynthesizerView
    _iFlySynthesizerView = [[IFlySynthesizerView alloc] initWithOrigin:CGPointMake(10, 60) params:initString];
    _iFlySynthesizerView.delegate = self;
    
    
    //set iFlySynthesizer
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer createWithParams:initString delegate:self] ;
    
    //accept sentence-----------------------------------------------------------------
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onIncertSentence:) name:@"incertSentence" object:nil];
/*
*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadView{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    _HVView = [[UIView alloc] initWithFrame:frame];
    _HVView.backgroundColor=[UIColor whiteColor];
    self.view=_HVView;
}

//Action-------------------------------------------------------------------------------------------------------------
//Push View
- (void)onPushFUSViewController:(id)sender{
    //add FUSController
    _FUSViewController = [HVFUSViewController alloc];
    [self.navigationController pushViewController:_FUSViewController animated:TRUE];
}

//插入常用语
-(void) onIncertSentence:(NSNotification *) notification{
    _textView.text = [notification object];
}

//清空
- (void) onClear:(id)sender
{
    _textView.text = Nil;
    [_textView becomeFirstResponder];
}

//合成
- (void) onReadWithOutUI:(id) sender{
    _readButton.enabled=NO;
    //[_iFlySynthesizerView startSpeaking:_textView.text];
    [_iFlySpeechSynthesizer startSpeaking:_textView.text];
    NSLog(@"SpeechSynthesize start------");
}

//识别
- (void) onBegin:(id) sender
{
    _textView.text = nil;
    // 参数设置
    [_iFlyRecognizerView setParameter:@"sample_rate" value:@"16000"];
    [_iFlyRecognizerView setParameter:@"vad_eos" value:@"1800"];
    [_iFlyRecognizerView setParameter:@"vad_bos" value:@"6000"];
    [_iFlyRecognizerView start];
}

//Delegate-------------------------------------------------------------------------------------------------------------
//textView delegate
- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        textView.font=[UIFont boldSystemFontOfSize:30];
        return NO;
    }
    return YES;
}

- (void) textViewDidBeginEditing:(UITextView *)textView{
    textView.font=[UIFont boldSystemFontOfSize:16];
}

//合成 delegate
//带UI的合成
- (void) onEnd:(IFlySynthesizerView *)iFlySynthesizerView error:(IFlySpeechError *)error
{
    _readButton.enabled = YES;
    NSLog(@"synthesize over");
}

- (void) onBufferProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    NSLog(@"bufferProgress:%d",progress);
}

- (void) onPlayProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    NSLog(@"playProgress:%d",progress);
    [_readButton setTitle:[NSString stringWithFormat:@"正在朗读 %d%%", progress] forState:UIControlStateDisabled];
}

//不带UI的合成
- (void) onSpeakBegin{}
- (void) onBufferProgress:(int)progress message:(NSString *)msg{}
- (void) onSpeakProgress:(int)progress {}
- (void) onSpeakPaused{}
- (void) onSpeakResumed{}
- (void) onSpeakCancel{}
- (void) onCompleted:(IFlySpeechError *)error{}

//识别 delegate
- (void) onResult:(IFlyRecognizerView *)iFlyRecognizerView theResult:(NSArray *)resultArray
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,result];
    
    NSLog(@"result:%@",result);
    NSLog(@"result:%@",_textView.text);
}

- (void)onEnd:(IFlyRecognizerView *)iFlyRecognizerView theError:(IFlySpeechError *) error
{
    NSLog(@"recognizer end");
}

@end


