//
//  HVViewController.h
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/24/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVFUSViewController.h"

#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"

#import "iflyMSC/IFlySynthesizerView.h"
#import "iflyMSC/IFlySynthesizerViewDelegate.h"



#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"

#define APPID @"523e8a23"


@interface HVViewController : UIViewController <IFlyRecognizerViewDelegate,IFlySynthesizerViewDelegate,  IFlySpeechSynthesizerDelegate,UITextViewDelegate>{


//@interface HVViewController : UIViewController <IFlyRecognizerViewDelegate, IFlySpeechSynthesizerDelegate, UITextViewDelegate>

//@interface HVViewController : UIViewController <IFlyRecognizerViewDelegate, IFlySynthesizerViewDelegate, UITextViewDelegate>{
    
    IFlyRecognizerView  *_iFlyRecognizerView;
    IFlySynthesizerView *_iFlySynthesizerView;
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
    
}

@end
