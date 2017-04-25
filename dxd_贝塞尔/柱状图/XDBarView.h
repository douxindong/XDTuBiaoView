//
//  XDBarView.h
//  柱状图
//
//  Created by 窦心东 on 2017/2/23.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedWithTableViewPathRowBlock)(NSString *coldate,NSInteger row);
@interface XDBarView : UIView
@property (nonatomic,copy) void(^SelectedWithTableViewPathRowBlock) (NSString *coldate,NSInteger row);
- (void)selectedWithTableViewPathRowBlock:(SelectedWithTableViewPathRowBlock)block;

/**
 * 新图刚显示的时候默认选择的cell
 * Api
 */
- (void)newinitSelectedWithTableViewPath:(NSIndexPath *)indexPath;
/** tableview */
@property(nonatomic,strong)UITableView *tb;
/** 默认颜色 */
@property (nonatomic,strong) UIColor *defaultColor;
/** 点击颜色 */
@property (nonatomic,strong) UIColor *SelectColor;
/** 模型数组 {value、日期 （下标）}*/
@property (nonatomic,strong) NSArray *modelArray;
/** 柱状图宽 <60 */
@property (nonatomic,assign) CGFloat barWith;
/** cell点击范围宽度 默认 80*/
@property (nonatomic,assign) CGFloat cellHeight;

/** 记录view */
@property (nonatomic,strong) UIView *currentView;


@end
