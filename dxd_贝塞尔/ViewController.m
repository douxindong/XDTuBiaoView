//
//  ViewController.m
//  dxd_贝塞尔
//
//  Created by 窦心东 on 2017/4/20.
//  Copyright © 2017年 窦心东. All rights reserved.
//

#import "ViewController.h"
#import "beisaierView.h"
#import "XDBarView.h"
@interface ViewController ()

{
    beisaierView *ber;
}
/** XDBarView */
@property (nonatomic,strong) XDBarView *barview;
@end

#define barViewHeight HEAL_HEIGHT(200)
@implementation ViewController
-(XDBarView *)barview{
    if (_barview == nil) {
        _barview = [[XDBarView alloc] initWithFrame:CGRectMake(0,300,SCREEN_WIDTH, barViewHeight)];
        _barview.defaultColor = ColorWithRGB(218, 218, 218);
        _barview.SelectColor = ColorWithHEAL;
                _barview.modelArray = @[@{@"colname":@"1",@"cptimes":@"100"},@{@"colname":@"2",@"cptimes":@"200"},@{@"colname":@"3",@"cptimes":@"300"},@{@"colname":@"4",@"cptimes":@"400"},@{@"colname":@"1",@"cptimes":@"100"},@{@"colname":@"2",@"cptimes":@"200"},@{@"colname":@"3",@"cptimes":@"300"},@{@"colname":@"4",@"cptimes":@"400"}];
        _barview.barWith = HEAL_WIDTH(60);
        _barview.cellHeight = HEAL_HEIGHT(80);
        
        
    }
    return _barview;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
 
    switch (_index) {
        case ZhuZhuangTu:
        {
            self.title = @"柱状图";
            [self ZhuZhuangTu_demo];
        }
            break;
        case LeiDaTu:
        {
             self.title = @"雷达图";
            [self LeiDaTu_demo];
        }
            break;
        default:
            break;
    }
    //打广告
    [self Da_Guang_Gao];
    
}
- (void)LeiDaTu_demo{
    ber = [[beisaierView alloc] initWithFrame:CGRectMake(30, 100, 350, 350)];
    ber.backgroundColor = [UIColor whiteColor];
    ber.header_image = [UIImage imageNamed:@"HEAL.jpg"];
    ber.headerimageWidth = 40;
    ber.value_array = @[@"40",@"50",@"80",@"50",@"90",@"50",@"70",@"90",@"30"];
    ber.title_array = @[@"阴虚",@"痰湿",@"温热",@"血瘀",@"气郁",@"特禀",@"平和",@"气虚",@"阳虚"];
    [self.view addSubview:ber];
}

- (void)ZhuZhuangTu_demo{
    [self.view addSubview:self.barview];
    
    //柱子被惦记的回调
    [self.barview selectedWithTableViewPathRowBlock:^(NSString *colname, NSInteger row) {
        
        NSLog(@"%ld点击了柱子colname == %@",(long)row,colname);
        
    }];
    
    //进来先点击的柱子 需要延迟一下  结合网络请求最好了
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSIndexPath * path = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.barview newinitSelectedWithTableViewPath:path];
    });
}
- (void)Da_Guang_Gao{

    CGFloat margin = 10;
    NSArray *imagearray = @[@"appStore.png",@"wechat.png",@"HEAL.jpg"];
    NSArray *imagearraytitle = @[@"appstore下载",@"微信公众号",@"HEAL小程序"];
    for (int i = 0; i<imagearray.count; i++) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imagearray[i]]];
        imageview.frame = CGRectMake(margin+i*(120+margin), 500, 120, 120);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10+i*(120+margin),  CGRectGetMaxY(imageview.frame)+30, 120, 40)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = imagearraytitle[i];
        [self.view addSubview:label];
        [self.view addSubview:imageview];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
