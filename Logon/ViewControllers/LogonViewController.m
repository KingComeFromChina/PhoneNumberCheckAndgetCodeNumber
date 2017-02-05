//
//  LogonViewController.m
//  PhoneNumberCheckAndgetCodeNumber
//
//  Created by 王垒 on 2017/2/5.
//  Copyright © 2017年 王垒. All rights reserved.
//

#import "LogonViewController.h"
#import "WLTools.h"

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
@interface LogonViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation LogonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

- (void)initSubViews{
   
    self.phoneNumberTF.delegate = self;
    self.codeTF.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    [self.phoneNumberTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
}


- (IBAction)getCodeNumber:(id)sender {
    if ([self.phoneNumberTF.text isEqualToString:@""]) {
        [WLTools showTextOnlyHud:@"手机号不能为空" delay:1.0];
        return;
    } else {
        if ([WLTools valiMobile:self.phoneNumberTF.text]) {
              [self.codeBtn setTitle:@"重发(60s)" forState:UIControlStateNormal];
            __block int timeout=59; //倒计时时间
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    
                    dispatch_source_cancel(_timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        self.codeBtn.userInteractionEnabled = YES;
                        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        
                    });
                }else{
                    int seconds = timeout % 60;
                    NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //设置界面的按钮显示 根据自己需求设置
                        [UIView beginAnimations:nil context:nil];
                        [UIView setAnimationDuration:1];
                        [self.codeBtn setTitle:[NSString stringWithFormat:@"重发(%@秒)",strTime] forState:UIControlStateNormal];
                        
                        [UIView commitAnimations];
                        self.codeBtn.userInteractionEnabled = NO;
                        
                    });
                    timeout--;
                }
            });
            
            dispatch_resume(_timer);
            
        

        } else {
             [WLTools showTextOnlyHud:@"手机号格式无效" delay:1.0];
        }
    }
}

#pragma mark - UITextField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
    
}


#pragma mark  textField的输入限制
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum]invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
    
    BOOL canChange = [string isEqualToString:filtered];
    
    return canChange;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
