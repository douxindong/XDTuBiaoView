//
//  TableViewCell.m
//  柱状图
//
//  Created by 窦心东 on 2017/2/22.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
/*
 运行顺序是：
 1、先执行 awakeFromNib
 2、再执行 赋值模型方法 
 推断：在赋值模型的时候更改barview的长度
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self createUI];
    
}
- (void)createUI{
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
