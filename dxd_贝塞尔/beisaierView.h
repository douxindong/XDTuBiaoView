//
//  beisaierView.h
//  dxd_贝塞尔
//
//  Created by 窦心东 on 2017/4/20.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface beisaierView : UIView

/** 头像的图片 */
@property (nonatomic,strong) UIImage *header_image;
/** 数据源数组 */
@property (nonatomic,strong) NSArray *value_array;
/** 数据元素的名称 */
@property (nonatomic,strong) NSArray *title_array;
/** 圆半径 */
@property (nonatomic,assign) CGFloat cirlR;
/** 头像的半径边框的宽度 */
@property (nonatomic,assign) CGFloat headerimageBoderWidth;
/** 头像的宽度 */
@property (nonatomic,assign) CGFloat headerimageWidth;
/** 小白点 */
@property (nonatomic,assign) CGFloat whiteDianWdith;
/** 小白点边框的宽度  */
@property (nonatomic,assign) CGFloat whiteDianBoderWdith;

/** label的宽度 */
@property (nonatomic,assign) CGFloat labelWidth;
/** label的宽度 */
@property (nonatomic,assign) CGFloat labelHeight;

/** 图层的颜色 */
@property (nonatomic,strong) UIColor *TuCengColor;
/** 圆环的颜色 */
@property (nonatomic,strong) UIColor *cirlColor;
/** 圆环之间的间距 */
@property (nonatomic,assign) CGFloat cirlMargin;

/** 小图层减少大图层值得比例 百分比 small_percent*cirlR*/
@property (nonatomic,assign) CGFloat small_percent;
@end
