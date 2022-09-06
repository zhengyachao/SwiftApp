//
//  MBProgressHUD+Category.m
//  ExiuComponent
//
//  Created by jiangzhan on 15/11/18.
//  Copyright © 2015年 Exiu. All rights reserved.
//

#import "MBProgressHUD+Category.h"

@implementation MBProgressHUD(ExiuCategory)

+(void)ShowHud:(NSString *)str object:(id)object{
    
    Class objectClass = [object class];
    
    UIWindow *displayWindow = nil;
    if ([objectClass isSubclassOfClass:[UIView class]]) {
        __weak UIView * wself = object;
        displayWindow = wself.window;
    }else if ([objectClass isSubclassOfClass:[UIViewController class]]){
        __weak UIViewController * wself = object;
        displayWindow = wself.view.window;
    }else{
        displayWindow = [[UIApplication sharedApplication] keyWindow];
    }
    if (displayWindow == nil) {
        displayWindow = [[UIApplication sharedApplication] keyWindow];
    }

    if (displayWindow) {
        MBProgressHUD *hud1 = [MBProgressHUD showHUDAddedTo:displayWindow animated:YES];
        hud1.mode = MBProgressHUDModeText;
        hud1.removeFromSuperViewOnHide = YES;
        hud1.label.text = str;
        hud1.label.numberOfLines = 0;
        hud1.offset = CGPointMake(0, -50);
        [hud1 hideAnimated:YES afterDelay:1.5];
    }
}
@end
