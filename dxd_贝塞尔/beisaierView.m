//
//  beisaierView.m
//  dxd_贝塞尔
//
//  Created by 窦心东 on 2017/4/20.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import "beisaierView.h"
#define ColorWithHEAL [UIColor colorWithRed:0/255.0f green:197/255.0f blue:188/255.0f alpha:1]//大图层的颜色
#define ColorWithHEALa [UIColor colorWithRed:0/255.0f green:197/255.0f blue:188/255.0f alpha:0.3]//小图层的颜色
#define P_M(x,y) CGPointMake(x, y)
@interface beisaierView (){
    
    
}

/** self 的宽度 */
@property (nonatomic,assign) CGSize beisaierView_size;

@end

@implementation beisaierView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
        
    }
    return self;
    
}
- (void)setUI{
    
    _beisaierView_size = self.frame.size;
    _cirlR = _beisaierView_size.width/2;
    _whiteDianWdith = 5;
    _labelWidth = 50;
    _labelHeight = 30;
    _TuCengColor = ColorWithHEAL;
    _cirlColor = [UIColor lightGrayColor];
    _cirlMargin = 30;
    _value_array = @[@"40",@"50",@"80",@"50",@"90",@"50",@"70",@"90",@"30"];
    _title_array = @[@"阴虚",@"痰湿",@"温热",@"血瘀",@"气郁",@"特禀",@"平和",@"气虚",@"阳虚"];
    _headerimageWidth = 20;
    _small_percent = 0.2;
    _whiteDianBoderWdith = 1;
    _headerimageBoderWidth = 1;
    _header_image = [UIImage imageNamed:@"背景.jpg"];
}

-(void)setValue_array:(NSArray *)value_array{
    _value_array = value_array;
}
-(void)setTitle_array:(NSArray *)title_array{
    _title_array = title_array;
}
-(void)setCirlR:(CGFloat)cirlR{
    _cirlR = cirlR;
}
-(void)setWhiteDianWdith:(CGFloat)whiteDianWdith{
    _whiteDianWdith = whiteDianWdith;
}
-(void)setWhiteDianBoderWdith:(CGFloat)whiteDianBoderWdith{
    _whiteDianBoderWdith = whiteDianBoderWdith;
}
-(void)setLabelWidth:(CGFloat)labelWidth{
    _labelWidth = labelWidth;
}
-(void)setLabelHeight:(CGFloat)labelHeight{
    _labelHeight = labelHeight;
}
-(void)setCirlColor:(UIColor *)cirlColor{
    _cirlColor = cirlColor;
}
-(void)setTuCengColor:(UIColor *)TuCengColor{
    _TuCengColor = TuCengColor;
}
-(void)setCirlMargin:(CGFloat)cirlMargin{
    _cirlMargin = cirlMargin;
}
-(void)setHeaderimageWidth:(CGFloat)headerimageWidth{
    _headerimageWidth = headerimageWidth;
}
-(void)setHeaderimageBoderWidth:(CGFloat)headerimageBoderWidth{
    _headerimageBoderWidth = headerimageBoderWidth;
}
-(void)setSmall_percent:(CGFloat)small_percent{
    _small_percent = small_percent;
}
-(void)setHeader_image:(UIImage *)header_image{
    _header_image = header_image;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    //设置frame
    
}


#pragma mark - 空心圆
- (void)drawRect:(CGRect)rect
{
    //画虚线的
    CGFloat dashPattern[] = {2,1};// 实线长为2，空白为1
    CGFloat lineWidth = 0.5;
    
    CGFloat _headerimageR = _headerimageWidth/2;//头像的半径
    
    //画多少个圆环
    for (int i = 0; i<3; i++) {
        UIBezierPath* aPath_yuanhuan = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(i*_cirlMargin, i*_cirlMargin, _beisaierView_size.width-(i*_cirlMargin*2), _beisaierView_size.width-(i*_cirlMargin*2))];
        [aPath_yuanhuan setLineDash:dashPattern count:1 phase:1];
        aPath_yuanhuan.lineWidth = lineWidth;
        [_cirlColor set];
        aPath_yuanhuan.lineCapStyle = kCGLineCapRound; //线条拐角
        aPath_yuanhuan.lineJoinStyle = kCGLineCapRound; //终点处理
        [aPath_yuanhuan stroke];
    }
    float maxValue = [[_value_array valueForKeyPath:@"@max.intValue"] floatValue];//value array里面的最大值
    UIBezierPath* aPath = [UIBezierPath bezierPath];//🌿外边的😊大图层
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    UIBezierPath* aPathsmall = [UIBezierPath bezierPath];//🌿里边的😊小图层
    aPathsmall.lineWidth = 1.0;
    aPathsmall.lineCapStyle = kCGLineCapRound; //线条拐角
    aPathsmall.lineJoinStyle = kCGLineCapRound; //终点处理
    
    NSMutableArray *pointArray = [NSMutableArray array];//大图层的顶点位置
    NSMutableArray *pointArraysmall = [NSMutableArray array];//小涂层的顶点位置
    
    //提取出大小图层的point
    for (int i = 0; i<_value_array.count; i++) {
        
        NSValue *value = [NSValue valueWithCGPoint:[self calcCircleCoordinateWithCenter:CGPointMake(_cirlR, _cirlR) andWithAngle:i*(360/_value_array.count) andWithRadius:([_value_array[i] floatValue]/maxValue+(_headerimageR+_whiteDianWdith+_whiteDianBoderWdith+_headerimageBoderWidth)/_cirlR)*(_cirlR-_headerimageR-_whiteDianBoderWdith-_whiteDianWdith-_headerimageBoderWidth)]];//20为头像的半径
        
        [pointArray addObject:value];
        
        NSValue *valuesmall = [NSValue valueWithCGPoint:[self calcCircleCoordinateWithCenter:CGPointMake(_cirlR, _cirlR) andWithAngle:i*(360/_value_array.count) andWithRadius:([_value_array[i] floatValue]/maxValue+(_headerimageR+_whiteDianBoderWdith+_headerimageBoderWidth)/_cirlR-_small_percent)*(_cirlR-_headerimageR-_whiteDianBoderWdith-_whiteDianWdith-_headerimageBoderWidth)]];//20为头像的半径
        
        [pointArraysmall addObject:valuesmall];
        
        
        
    }
    
    for (int i = 0; i<pointArray.count; i++) {
        UIBezierPath *path3 = [UIBezierPath bezierPath];
        [path3 moveToPoint:CGPointMake(_cirlR,_cirlR)];
        CGPoint pointyuanshangde = [self calcCircleCoordinateWithCenter:CGPointMake(_cirlR,_cirlR) andWithAngle:i*(360/pointArray.count) andWithRadius:_cirlR];
        [path3 addLineToPoint:pointyuanshangde];
        [path3 setLineWidth:lineWidth];
        [path3 setLineDash:dashPattern count:1 phase:1];
        [[UIColor lightGrayColor] setStroke];
        [path3 stroke];//画的圆环
        CGPoint p = [pointArray[i] CGPointValue];
        CGPoint psmall = [pointArraysmall[i] CGPointValue];
        
        if (i == 0) {
            [aPath moveToPoint:p];
            [aPathsmall moveToPoint:psmall];
        }else{
            //画曲线 找出控制点
            //            CGPoint nextP = [pointArray[i-1] CGPointValue];
            //            CGPoint control1 = P_M(p.x + (nextP.x - p.x) / 2.0, nextP.y);
            //            CGPoint control2 = P_M(p.x + (nextP.x - p.x) / 2.0, p.y);
            //
            //            [aPath addCurveToPoint:p controlPoint1:control1 controlPoint2:control2];
        }
        
        [aPath addLineToPoint:p];
        [aPathsmall addLineToPoint:psmall];
        [ColorWithHEALa setFill];
        
        
        UIView *cile = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _whiteDianWdith, _whiteDianWdith)];
        cile.backgroundColor = [UIColor whiteColor];
        
        cile.layer.borderWidth = _whiteDianBoderWdith;
        cile.layer.borderColor = ColorWithHEAL.CGColor;
        cile.layer.masksToBounds = YES;
        cile.layer.cornerRadius = _whiteDianWdith/2;
        cile.center = p;
        [self addSubview:cile];
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _labelWidth, _labelHeight)];
        label.text = _title_array[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = ColorWithHEAL;
        CGFloat selfWidth = self.frame.size.width;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat labelWidth = label.frame.size.width;
        CGFloat labelHeight = label.frame.size.height;
        
        if (p.x<selfWidth/2-labelWidth) {
            CGFloat x = p.x - labelWidth/2;
            CGFloat y;
            if (p.y<(selfHeight/2-labelHeight)) {
                y = p.y - labelHeight/2;
                
            } else {
                y = p.y + labelHeight/2;
                
            }
            label.center = CGPointMake(x, y);
            
        } else {
            CGFloat x = p.x + labelWidth/2;
            
            CGFloat y;
            if (p.y<(selfHeight/2-labelHeight)) {
                y = p.y - labelHeight/2;
                
            } else {
                y = p.y + labelHeight/2;
                
            }
            label.center = CGPointMake(x, y);
        }
        if (p.y>(selfHeight/2-labelHeight/2)&&p.y<(selfHeight/2+labelHeight/2)) {
            if (p.x<selfWidth/2-labelHeight) {
                
                label.center = CGPointMake(p.x-labelWidth/2, p.y);
            }else{
                label.center = CGPointMake(p.x+labelWidth/2, p.y);
            }
        }else{
            if (p.x>(selfWidth/2-labelWidth/2)&&p.x<(selfWidth/2+labelWidth/2)) {
                if (p.y<selfHeight/2-labelWidth) {
                    label.center = CGPointMake(p.x, p.y-labelHeight/2);
                } else {
                    label.center = CGPointMake(p.x, p.y+labelHeight/2);
                }
            }
        }
        label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:label];
    }
    
    [aPath fill];
    [aPathsmall fill];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _headerimageWidth, _headerimageWidth)];
    [imageview setImage:_header_image];
    imageview.center = CGPointMake(_cirlR, _cirlR);
    imageview.layer.masksToBounds = YES;
    imageview.layer.cornerRadius = _headerimageR;
    imageview.layer.borderWidth = _headerimageBoderWidth;
    imageview.layer.borderColor = [UIColor whiteColor].CGColor;
    [self addSubview:imageview];
    
}
#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}
/**
 ：douxindong
 ：2017-4-20 1:02:26
 : 1.0.0
 --------------------------------------------------------------
 功能说明
 --------------------------------------------------------------
 根据IOS视图中圆组件的中心点(x,y)、半径(r)、圆周上某一点与圆心的角度这3个
 条件来计算出该圆周某一点在IOS中的坐标(x2,y2)。
 
 注意：
 （1）IOS坐标体系与数学坐标体系有差别，因此不能完全采用数学计算公式。
 （2）数学计算公式：
 x2=x+r*cos(角度值*PI/180)
 y2=y+r*sin(角度值*PI/180)
 （3）IOS中计算公式：
 x2=x+r*cos(角度值*PI/180)
 y2=y-r*sin(角度值*PI/180)
 
 --------------------------------------------------------------
 参数说明
 --------------------------------------------------------------
 @param (CGPoint) center
 
 圆圈在IOS视图中的中心坐标，即该圆视图的center属性
 
 @param (CGFloat) angle
 角度值，是0～360之间的值。
 注意：
 （1）请使用下面坐标图形进行理解。
 （2）角度是逆时针转的，从x轴中心(0,0)往右是0度角（或360度角），往左是180度角，往上是90度角，往下是270度角。
 
 (y)
 ^
 |
 |
 |
 |
 -----------------> (x)
 |(0,0)
 |
 |
 |
 
 @param (CGFloat) radius
 圆周半径
 */

@end
