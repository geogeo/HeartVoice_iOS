//
//  sttView.m
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/26/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import "sttView.h"
#import <QuartzCore/QuartzCore.h>
#import "iflyMSC/IFlySpeechError.h"


@implementation sttView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        
        //set and add textView
        _textView =[[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 190)];
        _textView.font=[UIFont boldSystemFontOfSize:30];
        _textView.backgroundColor = [UIColor grayColor];
        _textView.returnKeyType=UIReturnKeyDone;
        _textView.delegate = self;
        _textView.text=@"你好，我是一位聋人，请点下面的按钮对我说话。";
        [self addSubview:_textView];
        
        //set and add sttButton
        UIButton *sttButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        sttButton.frame = CGRectMake(10,255,300,150);
        sttButton.titleLabel.font = [UIFont boldSystemFontOfSize:30];
        [sttButton setTitle:@"点此对我说话" forState:UIControlStateNormal];
        [sttButton addTarget:self action:@selector(onBegin:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sttButton];
        
        //set and add readButton
        _readButton =[UIButton buttonWithType:UIButtonTypeRoundedRect];
        _readButton.frame = CGRectMake(10,205,300,44);
        _readButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_readButton setTitle:@"朗读" forState:UIControlStateNormal];
        //[_readButton addTarget:self action:@selector(onRead:) forControlEvents:UIControlEventTouchUpInside];
        [_readButton addTarget:self action:@selector(onReadWithOutUI:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_readButton];
        
        //set iFlyRecognizerView
        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", APPID ];
        _iFlyRecognizerView = [[IFlyRecognizerView alloc] initWithOrigin:CGPointMake(10, 60) initParam:initString];
        _iFlyRecognizerView.delegate=self;
        
        
        //set iFlySynthesizerView
        _iFlySynthesizerView = [[IFlySynthesizerView alloc] initWithOrigin:CGPointMake(10, 60) params:initString];
        _iFlySynthesizerView.delegate=self;
        
        //set iFlySynthesizer
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer createWithParams:initString delegate:self] ;
        
        //_iFlySynthesizer.delegate=self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setText:(NSString *) text
{
    _textView.text = text;
}

//带UI合成 delegate


- (void) onEnd:(IFlySynthesizerView *)iFlySynthesizerView error:(IFlySpeechError *)error
{
    _readButton.enabled = YES;
    //NSLog(@"synthesize over");
}

- (void) onBufferProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    //NSLog(@"bufferProgress:%d",progress);
}

- (void) onPlayProress:(IFlySynthesizerView *)iFlySynthesizerView progress:(int)progress
{
    //NSLog(@"playProgress:%d",progress);
    [_readButton setTitle:[NSString stringWithFormat:@"正在朗读 %d%%", progress] forState:UIControlStateDisabled];
}

//无UI合成
- (void) onReadWithOutUI:(id) sender{
    _readButton.enabled=NO;
    /*[_iFlySpeechSynthesizer setParameter:@"speed" value:@"60"];
    [_iFlySpeechSynthesizer setParameter:@"volume" value:@"100"];
    [_iFlySpeechSynthesizer setParameter:@"voice_name" value:@"xiaoyu"];
    [_iFlySpeechSynthesizer setParameter:@"sample_rate" value:@"8000"];*/
    
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


- (void) onResult:(IFlyRecognizerView *)iFlyRecognizerView theResult:(NSArray *)resultArray
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    NSLog(@"result:%@",result);
    _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,result];
    
    
}

- (void)onEnd:(IFlyRecognizerView *)iFlyRecognizerView theError:(IFlySpeechError *) error
{
    NSLog(@"recognizer end");
}

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

@end
