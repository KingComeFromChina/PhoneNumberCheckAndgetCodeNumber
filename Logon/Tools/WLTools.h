//
//  WLTools.h
//  Logon
//
//  Created by 王垒 on 2017/2/5.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface WLTools : NSObject

+ (void)showTextOnlyHud:(NSString *)text delay:(NSTimeInterval)delay;

+ (BOOL)valiMobile:(NSString *)mobile;

@end
