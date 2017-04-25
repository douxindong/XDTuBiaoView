//
//  XDBarView.m
//  柱状图
//
//  Created by 窦心东 on 2017/2/23.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import "XDBarView.h"
#import "TableViewCell.h"

#import "XDControl.h"
@interface XDBarView  ()<UITableViewDataSource,UITableViewDelegate>{
}

/** footerview */
@property (nonatomic,strong) UIView *footerview;
/** headerview */
@property (nonatomic,strong) UIView *headerview;
/** <#注释#> */
@property (nonatomic,strong) NSIndexPath *indexPathss;
/** 最大数 */
@property (nonatomic,assign) CGFloat maxValue;
@end

@implementation XDBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if([super initWithFrame:frame])
    {
        [self initViewDidLoad];
    }
    return self;
}

- (instancetype)init
{
    if([super init])
    {
        [self initViewDidLoad];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if([super initWithCoder:aDecoder])
    {
        [self initViewDidLoad];
    }
    return self;
}

- (UITableView *)tb{
    
    if (_tb == nil) {
        _tb = [[UITableView alloc] initWithFrame:CGRectMake(HEAL_X(106), HEAL_Y(-110),HEAL_WIDTH(200),SCREEN_WIDTH) style:UITableViewStylePlain];
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.transform = CGAffineTransformMakeRotation(-M_PI / 2);//旋转-π/2
        _tb.separatorStyle = NO;
        _tb.showsVerticalScrollIndicator = NO;
//        _tb.alwaysBounceHorizontal= YES;
        _tb.tableFooterView = self.footerview;
        _tb.tableHeaderView = self.headerview;
    }
    return _tb;
}
#pragma mark - 懒加载创建头视图headView
- (UIView *)headerview{
    if (_headerview == nil) {
        _headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tb.frame.size.width, SCREEN_WIDTH/2-_cellHeight/2)];
        _headerview.backgroundColor = [UIColor clearColor];//64.311594202898561
        UIView *line = [XDControl createViewWithFrame:CGRectMake(HEAL_X(_barWith+10), 0,HEAL_WIDTH(1),SCREEN_WIDTH/2-_cellHeight/2) BackgroundColor:ColorWithHEAL];
        [_headerview addSubview:line];
    }
    return _headerview;
}
#pragma mark - 懒加载创建足视图footerview
- (UIView *)footerview{
    if (_footerview == nil) {
        _footerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tb.frame.size.width,SCREEN_WIDTH/2-_cellHeight/2)];
        _footerview.backgroundColor = [UIColor clearColor];
        UIView *line = [XDControl createViewWithFrame:CGRectMake(HEAL_X(_barWith+10), 0,HEAL_WIDTH(1),SCREEN_WIDTH/2+_cellHeight/2) BackgroundColor:ColorWithHEAL];
        [_footerview addSubview:line];
        
    }
    return _footerview;
}
/** 初始化数据 设置背景view的属性*/
- (void)initViewDidLoad
{
    if(!_cellHeight){

        _cellHeight = HEAL_HEIGHT(80);
    }
    if (!_barWith) {
        
        _barWith = HEAL_HEIGHT(60);
    }
//    self.currentView = [UIView new];
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)layoutSubviews
{
    //添加子视图
    [self addSubview:self.tb];
    
   
}
- (void)newinitSelectedWithTableViewPath:(NSIndexPath *)indexPath{
//    NSIndexPath * path = [NSIndexPath indexPathForRow:5 inSection:0];
    [self tableView:self.tb didSelectRowAtIndexPath:indexPath];
}
-(void)setModelArray:(NSArray *)modelArray{
    _modelArray = [NSArray arrayWithArray:modelArray];
    
    //arr为实际的模型取出的数组
    NSMutableArray * arr = [NSMutableArray array];
    for (int i= 0; i<_modelArray.count; i++) {
        
        if (i == 0) {
            if (_modelArray[i][@"cptimes"]==nil) {
                return;
            }
        }
        [arr addObject:_modelArray[i][@"cptimes"]];
        NSLog(@"所有数字是：cptimes%@",_modelArray[i][@"cptimes"]);
    }

    _maxValue = [[arr valueForKeyPath:@"@max.intValue"] floatValue];
     NSLog(@"最大数字是：_maxValue%f",_maxValue);
    
    
}
#pragma mark - 分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//#pragma mark - 返回自定义组头
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH-70, 20)];
//    view.backgroundColor = [UIColor whiteColor];
//    return view;
//}
//#pragma mark - 返回组头头高
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20;
//}
#pragma mark - 每组几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}
#pragma mark - 每行行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}
#pragma mark - tableViewData delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cellName";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] lastObject];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(HEAL_X(_barWith+10), -HEAL_HEIGHT(20),HEAL_WIDTH(1),HEAL_HEIGHT(_cellHeight)+HEAL_HEIGHT(40))];
    line.backgroundColor = ColorWithHEAL;
    [cell.contentView addSubview:line];
    if (indexPath.row>=self.modelArray.count) {
        return cell;
    }
    UIView *view = [[UIView alloc] init];
  
    //20 填写实际数值%%%%%%%%%%%%%%%%%%%%%%%%%%
    [UIView animateWithDuration:0.25 animations:^{
//        NSLog(@"cptimes%@",[_modelArray[indexPath.row] cptimes]);
        CGFloat height = [_modelArray[indexPath.row][@"cptimes"] floatValue]/_maxValue*HEAL_HEIGHT(100);
        if (height < HEAL_HEIGHT(1)&&height>0) {
            height = HEAL_HEIGHT(1);
        }
        view.frame =CGRectMake(CGRectGetMaxX(line.frame),HEAL_Y(10),height ,HEAL_WIDTH(_barWith));
        

    }];
    view.backgroundColor = _defaultColor;
    view.tag = indexPath.row+1;
    [cell.contentView addSubview:view];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, HEAL_Y(10), HEAL_HEIGHT(_cellHeight), HEAL_WIDTH(_barWith))];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = Font_shuzi_DINCond_Medium_size(HEAL_X(15));
    label.text = _modelArray[indexPath.row][@"colname"];
    label.textColor = [UIColor grayColor];
    [cell.contentView addSubview:label];
    label.transform = CGAffineTransformMakeRotation(M_PI / 2);
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=self.modelArray.count) {
        return ;
    }
    UIView *view = [self viewWithTag:indexPath.row+1];
    
    if (self.currentView == view) {
        return;
    }else{
        view.backgroundColor = _SelectColor;
        self.currentView.backgroundColor = _defaultColor;
    }
    self.currentView = view;
    
    [self.tb scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    
    NSLog(@"点击的是%ldlabel==%@",indexPath.row,_modelArray[indexPath.row][@"colname"]);
 

    self.SelectedWithTableViewPathRowBlock?self.SelectedWithTableViewPathRowBlock(_modelArray[indexPath.row][@"colname"],indexPath.row):nil;
}
- (void)selectedWithTableViewPathRowBlock:(SelectedWithTableViewPathRowBlock)block{
    self.SelectedWithTableViewPathRowBlock = block;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        //滑动到这里的时候  判断那个 cell的进入了中间这个区域
        /*
         * 在tableview 屏幕中部提取出那个 cell 的indexPath.row
         */
       
        NSIndexPath *path = [NSIndexPath indexPathForRow:floor(scrollView.contentOffset.y/_cellHeight) inSection:0];
        [self tableView:self.tb didSelectRowAtIndexPath:path];
        
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"滑动速度减为0时 的纵坐标%f",scrollView.contentOffset.y);
    //round这个是四舍五入；floor这个是向下取整数 都可以的写哪个都对。
    
    NSLog(@"%f",scrollView.contentOffset.y);
    NSIndexPath *path = [NSIndexPath indexPathForRow:floor(scrollView.contentOffset.y/_cellHeight) inSection:0];
    [self tableView:self.tb didSelectRowAtIndexPath:path];
}
//监听scrollView滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%f",scrollView.contentOffset.y);
}
#pragma mark -- 画进度条
- (void)drawRect:(CGRect)rect
{
    
}
#pragma mark - 懒加载创建图示控件

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code  当调用needdisplay方法的时候 才自动调用这个方法
}
*/



@end
