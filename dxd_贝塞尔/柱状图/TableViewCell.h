//
//  TableViewCell.h
//  柱状图
//
//  Created by 窦心东 on 2017/2/22.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
/** 横坐标轴线 */
@property (nonatomic,strong) UIView *hengline;
/** 横坐标文字 */
@property (nonatomic,strong) UILabel *henglabel;
/** 柱子 */
@property (nonatomic,strong) UIView *barview;
/** 柱子高度 赋值模型之前 赋好值*/
@property (nonatomic,assign) CGFloat barheight;
@end
