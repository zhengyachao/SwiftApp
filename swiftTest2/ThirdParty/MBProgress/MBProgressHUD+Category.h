//
//  MBProgressHUD+Category.h
//  ExiuComponent
//
//  Created by jiangzhan on 15/11/18.
//  Copyright © 2015年 Exiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface MBProgressHUD (ExiuCategory)

//生成一个进度框，会将弹框放到window上，并自动消失
+(void)ShowHud:(NSString *)str object:(id)object;

@end
