//
//  HVViewController.h
//  HeartVoice_iOS
//
//  Created by zhuchen on 9/24/13.
//  Copyright (c) 2013 zhuchen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sttView.h"
#import "HVFUSViewController.h"


@interface HVViewController : UIViewController{
    UIView               *_sttView;
    UIButton             *_FUSButton;
    HVFUSViewController  *_FUSViewController;
}

@end
