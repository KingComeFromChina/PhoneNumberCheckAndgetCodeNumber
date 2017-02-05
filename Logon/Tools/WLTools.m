//
//  WLTools.m
//  Logon
//
//  Created by 王垒 on 2017/2/5.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "WLTools.h"

static  MBProgressHUD *hud = nil;
static BOOL isAddHud;

@implementation WLTools

+(MBProgressHUD *)sharedManager{
    
    @synchronized(hud)
    {
        if(!hud)
        {
            hud = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
            isAddHud = NO;
        }
    }
    return hud;
    
}

+ (void)removeHudWindow{
    
    [[WLTools sharedManager] removeFromSuperview];
    isAddHud = NO;
}

+ (void)addHudWindow:(MBProgressHUD *)hudMsg{
    
    if (isAddHud == NO) {
        [[[UIApplication sharedApplication].windows objectAtIndex:[[UIApplication sharedApplication].windows count]-1] addSubview:hudMsg];
        isAddHud = YES;
    }
    
}

+(void)showTextOnlyHud:(NSString *)text delay:(NSTimeInterval)delay
{
    MBProgressHUD *hudMsg = [WLTools sharedManager];
    [self addHudWindow:hudMsg];
    hudMsg.mode = MBProgressHUDModeText;
   
    hudMsg.labelText = text;
       hudMsg.margin = 10.f;
    
    hudMsg.labelFont = [UIFont systemFontOfSize:16.0];
    hudMsg.yOffset = 150.f;
    
    [hudMsg show:YES];
    [hudMsg hide:YES afterDelay:delay==0?1.0:delay];
    [self performSelector:@selector(removeHudWindow) withObject:nil afterDelay:delay == 0?1.0:delay];
}

//判断手机号码格式是否正确

+ (BOOL)valiMobile:(NSString *)mobile

{
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if (mobile.length != 11)
        
    {
        
        return NO;
        
    }else{
        
        /**
         
         * 移动号段正则表达式
         
         */
        
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        
        /**
         
         * 联通号段正则表达式
         
         */
        
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        
        /**
         
         * 电信号段正则表达式
         
         */
        
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        
        
        if (isMatch1 || isMatch2 || isMatch3) {
            
            return YES;
            
        }else{

          
            return NO;
            
        }
        
    }
    
}


@end
