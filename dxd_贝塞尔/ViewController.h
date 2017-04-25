//
//  ViewController.h
//  dxd_贝塞尔
//
//  Created by 窦心东 on 2017/4/20.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,TuType) {
    ZhuZhuangTu = 0,
    LeiDaTu = 1,
   
};
@interface ViewController : UIViewController

/** index */
@property (nonatomic,assign) NSInteger index;
@end

