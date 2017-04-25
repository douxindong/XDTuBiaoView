//
//  XDControl.m
//  
//
//  Created by douxindong on 16/4/27.
//  Copyright © 2016年 HEAL All rights reserved.
//

#import "XDControl.h"
#define IOS7   [[UIDevice currentDevice]systemVersion].floatValue>=7.0
@implementation XDControl



+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text
{
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    //限制行数
    label.numberOfLines=0;
    //对齐方式
    label.textAlignment=NSTextAlignmentLeft;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont systemFontOfSize:font];
    //单词折行
    label.lineBreakMode=NSLineBreakByWordWrapping;
    //默认字体颜色是白色
    label.textColor=[UIColor blackColor];
    //自适应（行数~字体大小按照设置大小进行设置）
    label.adjustsFontSizeToFitWidth=YES;
    label.text=text;
    return label;
}
/**
 *  创建自适应高度的Label
 *
 *  @param x               x
 *  @param y               y
 *  @param width           width
 *  @param height          height
 *  @param text            text
 *  @param numberOflines   numberOflines
 *  @param fontName        字体名
 *  @param fontSize        字体大小
 *  @param backgroundColor 背景色
 *  @param view            添加到哪个view
 *  @param sizeMake        设置最大高度和宽度
 *  @return label
 */
+(UILabel*)createAutoLabelframeOrginX:(CGFloat)x OrginY:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height text:(NSString *)text numberOfLines:(NSInteger)numberOflines fontWithName:(NSString *)fontName size:(CGFloat)fontSize BackgroundColor:(UIColor *)backgroundColor  TextColor:(UIColor *)textColor sizeMaxMake:(CGSize)sizeMake{
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(x,y,width,height)];
    NSString * tstring =text;
    lable.numberOfLines =numberOflines;
    UIFont * tfont = [UIFont fontWithName:fontName size:fontSize];
    lable.font = tfont;
    lable.lineBreakMode =NSLineBreakByTruncatingTail ;
    lable.text = tstring ;
    [lable setBackgroundColor:backgroundColor];
    //默认字体颜色是白色
    lable.textColor = textColor;
    //高度估计文本大概要显示几行，宽度根据需求自己定义。 MAXFLOAT 可以算出具体要多高
    CGSize size =sizeMake;
    // label可设置的最大高度和宽度
    //        CGSize size = CGSizeMake(300.f, MAXFLOAT);
    //    获取当前文本的属性
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    //ios7方法，获取文本需要的size，限制宽度
    CGSize  actualsize =[tstring boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    
    // ios7之前使用方法获取文本需要的size，7.0已弃用下面的方法。此方法要求font，与breakmode与之前设置的完全一致
    //    CGSize actualsize = [tstring sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    //   更新UILabel的frame
    lable.frame =CGRectMake(x,y, actualsize.width, actualsize.height);
    return lable;
}
/**
 *  创建普通 button
 */
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.showsTouchWhenHighlighted = YES;
    return button;
    
    
}
/**
 *  创建拉伸不变形 button
 */
+(UIButton*)createLaShenButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title Fontsize:(CGFloat)fontSize
{
    
    NSInteger leftCapWidth = [UIImage imageNamed:imageName].size.width * 0.5f;// 左端盖宽度
    NSInteger topCapHeight = [UIImage imageNamed:imageName].size.height * 0.5f;// 顶端盖高度
    UIImage *images = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    //设置背景图片，可以使文字与图片共存
    [button setBackgroundImage:images forState:UIControlStateNormal];
    //图片与文字如果需要同时存在，就需要图片足够小 详见人人项目按钮设置
    // [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}

+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName
{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:imageName];
    imageView.userInteractionEnabled=YES;
    return imageView ;
}
+(UIView*)viewWithFrame:(CGRect)frame
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    
    return view ;
    
}
+(UIView*)createViewWithFrame:(CGRect)frame BackgroundColor:(UIColor *)color
{
    UIView*view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor = color;
    return view ;
    
}
#pragma  mark 适配器方法
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName
{
    UITextField*textField=[[UITextField alloc]initWithFrame:frame];
    //灰色提示框
    textField.placeholder=placeholder;
    [textField setValue:ColorWithHEAL_LIGHT_GREY forKeyPath:@"_placeholderLabel.textColor"];
    //文字对齐方式
    textField.textAlignment=NSTextAlignmentLeft;
    textField.secureTextEntry=YESorNO;
    //边框
    //textField.borderStyle=UITextBorderStyleLine;
    //键盘
    textField.keyboardType=UIKeyboardTypeEmailAddress;
    //关闭首字母大写
    textField.autocapitalizationType=NO;
    //清除按钮
    textField.clearButtonMode=YES;
    //左图片
    textField.leftView=imageView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    //右图片
    textField.rightView=rightImageView;
    //编辑状态下一直存在
    textField.rightViewMode=UITextFieldViewModeWhileEditing;
    //自定义键盘
    //textField.inputView
    //字体
    textField.font=[UIFont systemFontOfSize:font];
    //字体颜色
    textField.textColor=[UIColor whiteColor];
    
    textField.background=[UIImage imageNamed:imageName];
    return  textField;
    
}
+(CGSize)strSize:(NSString *)str withMaxSize:(CGSize)size withFont:(UIFont *)font withLineBreakMode:(NSLineBreakMode)mode
{
    CGSize s;
    if (IOS7)
    {
        s = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    else
    {
        s = [str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return s;
}
/**
 *  调整图片尺寸和大小
 *
 *  @param sourceImage  原始图片
 *  @param maxImageSize 新图片最大尺寸
 *  @param maxSize      新图片最大存储大小
 *
 *  @return 新图片imageData
 */
+ (NSData *)Limit_reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize
{
    
    if (maxSize <= 0.0) maxSize = 1024.0;
    if (maxImageSize <= 0.0) maxImageSize = 1024.0;
    
    //先调整分辨率
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / maxImageSize;
    CGFloat tempWidth = newSize.width / maxImageSize;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    CGFloat sizeOriginKB = imageData.length / 1024.0;
    
    CGFloat resizeRate = 0.9;
    while (sizeOriginKB > maxSize && resizeRate > 0.1) {
        imageData = UIImageJPEGRepresentation(newImage,resizeRate);
        sizeOriginKB = imageData.length / 1024.0;
        resizeRate -= 0.1;
    }
    
    return imageData;
}

/** 设置进度条上的上下内容 */
+ (NSMutableAttributedString *)AttributedStringsetRange1:(NSString *)range1 withColor1:(UIColor *)color1 Font1:(UIFont *)font1 andRange2:(NSString *)range2 withColor2:(UIColor *)color2 Font2:(UIFont *)font2 andRange3:(NSString *)range3 withColor3:(UIColor *)color3 Font3:(UIFont *)font3 isenter:(BOOL)bools/*《是否换行》*/{
    NSString * noteStra;
    if (bools) {
        noteStra = [NSString stringWithFormat:@"%@\n%@\n%@",range1?range1:@"1",range2?range2:@"1",range3?range3:@"1"];//承接参数
    }else{
        noteStra = [NSString stringWithFormat:@"%@  %@  %@",range1?range1:@"1",range2?range2:@"1",range3?range3:@"1"];//承接参数
    }
    
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:noteStra];
    NSRange redRange1 = NSMakeRange([[noteStr string] rangeOfString:range1].location, [[noteStr string] rangeOfString:range1].length);
    NSRange redRange2 = NSMakeRange([[noteStr string] rangeOfString:range2].location, [[noteStr string] rangeOfString:range2].length);//承接参数
    NSRange redRange3 = NSMakeRange([[noteStr string] rangeOfString:range3].location, [[noteStr string] rangeOfString:range3].length);
    [noteStr addAttribute:NSFontAttributeName value:font1 range:redRange1];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color1 range:redRange1];
    [noteStr addAttribute:NSFontAttributeName value:font2 range:redRange2];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color2 range:redRange2];
    [noteStr addAttribute:NSFontAttributeName value:font3 range:redRange3];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color3 range:redRange3];
    return noteStr;
}
/** 设置进度条上的上下内容 */
+ (NSMutableAttributedString *)AttributedStringsetRange1:(NSString *)range1 withColor1:(UIColor *)color1 Font1:(UIFont *)font1 andRange2:(NSString *)range2 withColor2:(UIColor *)color2 Font2:(UIFont *)font2 Fontone2s:(UIFont *)fontone2s andRange3:(NSString *)range3 withColor3:(UIColor *)color3 Font3:(UIFont *)font3 isOneEnter:(BOOL)bools/*《是否换行》*/{
    
    if(range2 == nil)return [[NSMutableAttributedString alloc] initWithString:@""];
    
    NSString * noteStra;
    
    if (bools) {
        
        noteStra = [NSString stringWithFormat:@"%@\n\n%@ %@",range1?range1:@"1",range2?range2:@"1",range3?range3:@"1"];//承接参数
        
    }else{
        
        noteStra = [NSString stringWithFormat:@"%@\n\n%@\n\n%@",range1?range1:@"1",range2?range2:@"1",range3?range3:@"1"];//承接参数
        
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:noteStra];
    NSRange redRange1 = NSMakeRange([[noteStr string] rangeOfString:range1].location, [[noteStr string] rangeOfString:range1].length);
    NSRange redRange2 = NSMakeRange([[noteStr string] rangeOfString:range2].location, [[noteStr string] rangeOfString:range2].length);//承接参数
    NSRange redRange3 = NSMakeRange([[noteStr string] rangeOfString:range3].location, [[noteStr string] rangeOfString:range3].length);
    
    [noteStr addAttribute:NSFontAttributeName value:font1 range:redRange1];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color1 range:redRange1];
    [noteStr addAttribute:NSFontAttributeName value:bools?fontone2s:font2 range:redRange2];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color2 range:redRange2];
    [noteStr addAttribute:NSFontAttributeName value:font3 range:redRange3];
    [noteStr addAttribute:NSForegroundColorAttributeName value:color3 range:redRange3];
    return noteStr;
}
+(void)animationAlert:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
}
+ (NSString *)changeStar:(NSString *)beString{
//    NSString *a = beString;
//    NSString *string=[a stringByReplacingOccurrencesOfString:[a substringWithRange:NSMakeRange(3,4)]withString:@"****"];
//    NSLog(@"b:%@",string);
    return beString;
}


@end
