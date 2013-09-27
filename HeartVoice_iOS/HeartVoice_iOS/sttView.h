//
//  sttView.h
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/26/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySynthesizerViewDelegate.h"
#import "iflyMSC/IFlySynthesizerView.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
//#import "UISynthesizerSetupController.h"

#define APPID @"523e8a23"

@interface sttView : UIView <IFlyRecognizerViewDelegate,IFlySynthesizerViewDelegate, UITextViewDelegate, IFlySpeechSynthesizerDelegate>
{
    UITextView                      *_textView;
    IFlyRecognizerView              *_iFlyRecognizerView;
    IFlySynthesizerView             *_iFlySynthesizerView;
    IFlySpeechSynthesizer           *_iFlySpeechSynthesizer;
    UIButton                        *_readButton;
}


- (void) setText:(NSString *) text;

@end