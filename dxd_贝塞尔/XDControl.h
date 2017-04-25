//
//  XDControl.h
//
//
//  Created by douxindong on 16/4/27.
//  Copyright © 2016年 HEAL All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CheckshifouNeedToLoginBlock)();//
typedef void(^LoginSusess_Or_NoNeedLoginBlock)();//
typedef void(^Success_Block)(BOOL needornoSet_RootVC,id responseObject);
typedef void(^Failure_Block)(NSError *error);
@interface XDControl : NSObject

@property (nonatomic,copy) void(^CheckshifouNeedToLoginBlock) ();
@property (nonatomic,copy) void(^LoginSusess_Or_NoNeedLoginBlock) ();

@property (nonatomic,copy) void(^Success_Block) (BOOL needornoSet_RootVC,id responseObject);
@property (nonatomic,copy) void(^Failure_Block) (NSError *error);
- (void)LoginWithParameters:(NSDictionary *)parameters Success_Block:(Success_Block)Success Failure_Block:(Failure_Block)Failure;
+ (void)CheckshifouNeedToLoginBlock:(CheckshifouNeedToLoginBlock)block1 LoginSusess_Or_NoNeedLoginBlock:(LoginSusess_Or_NoNeedLoginBlock)block2;
#pragma mark --创建自适应Label
+(UILabel*)createAutoLabelframeOrginX:(CGFloat)x OrginY:(CGFloat)y Width:(CGFloat)width Height:(CGFloat)height text:(NSString *)text numberOfLines:(NSInteger)numberOflines fontWithName:(NSString *)fontName size:(CGFloat)fontSize BackgroundColor:(UIColor *)backgroundColor  TextColor:(UIColor *)textColor sizeMaxMake:(CGSize)sizeMake;
#pragma mark --创建Label
+(UILabel*)createLabelWithFrame:(CGRect)frame Font:(int)font Text:(NSString*)text;
#pragma mark --创建View
+(UIView*)viewWithFrame:(CGRect)frame;
#pragma mark --创建View
+(UIView*)createViewWithFrame:(CGRect)frame BackgroundColor:(UIColor *)color;
#pragma mark --创建imageView
+(UIImageView*)createImageViewWithFrame:(CGRect)frame ImageName:(NSString*)imageName;
#pragma mark --创建拉伸不变形 button
+(UIButton*)createLaShenButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title Fontsize:(CGFloat)fontSize;
#pragma mark --创建button
+(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title;
#pragma mark --创建UITextField
+(UITextField*)createTextFieldWithFrame:(CGRect)frame placeholder:(NSString*)placeholder passWord:(BOOL)YESorNO leftImageView:(UIImageView*)imageView rightImageView:(UIImageView*)rightImageView Font:(float)font backgRoundImageName:(NSString*)imageName;
+(CGSize)strSize:(NSString *)str withMaxSize:(CGSize)size withFont:(UIFont *)font withLineBreakMode:(NSLineBreakMode)mode;
#pragma mark --限制图片的最小值和最大值
+ (NSData *)Limit_reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;
#pragma mark --返回汉语json串
#pragma mark -- 设置进度条上的上下内容 
+ (NSMutableAttributedString *)AttributedStringsetRange1:(NSString *)range1 withColor1:(UIColor *)color1 Font1:(UIFont *)font1 andRange2:(NSString *)range2 withColor2:(UIColor *)color2 Font2:(UIFont *)font2 andRange3:(NSString *)range3 withColor3:(UIColor *)color3 Font3:(UIFont *)font3 isenter:(BOOL)bools;
#pragma mark -- 动画
+(void)animationAlert:(UIView *)view;
+(UIImage *)getPlayItemWithUrl:(NSString *)urlStr;
+(void)SetImageView:(UIImageView *)imageView ImageWithUrl:(NSString *)imageView_url placeholderImage:(UIImage *)placeholder;
#pragma mark -- 账号转隐藏******
+ (NSString *)changeStar:(NSString *)beString;

+ (void)showMBProgress:(UIView *)view;
+ (void)hideMBProgress:(UIView *)view;
/** 设置进度条上的上下内容 */
+ (NSMutableAttributedString *)AttributedStringsetRange1:(NSString *)range1 withColor1:(UIColor *)color1 Font1:(UIFont *)font1 andRange2:(NSString *)range2 withColor2:(UIColor *)color2 Font2:(UIFont *)font2 Fontone2s:(UIFont *)fontone2s andRange3:(NSString *)range3 withColor3:(UIColor *)color3 Font3:(UIFont *)font3 isOneEnter:(BOOL)bools/*《是否换行》*/;

+(BOOL)saveHealAcct:(NSString *)account andPwd:(NSString *)password;
+ (NSString *)loadPwdFrmoeKeyChinaWithAccount:(NSString *)account;
//HEAL 勿改重要！！！！！！！！！！！！！！！！！！！！！！！！
+ (NSString *)Pasword_Md5_salt:(NSString *)pasword;
@end
