//
//  ViewController.m
//  AutomaticSliderScrollView
//
//  Created by Office on 2018/6/22.
//  Copyright © 2018年 侯东明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)NSInteger oldTag;
@property(nonatomic,strong)UILabel *bottomLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 40)];
    _scrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:_scrollView];
    NSArray *array =[[NSArray alloc]initWithObjects:@"全部",@"今日上新",@"家居",@"食品",@"女装",@"男装",@"内衣",@"美妆",@"数码家电",@"母婴",@"鞋包配饰",@"文体其他",@"明日预告", nil];
    for (int i=0; i<array.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        if (i ==0) {
            button.frame =CGRectMake(10, 10,[self autoForWidth:array[i] height:20 NSFont:14], 20);
            [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            _oldTag =600;
            _bottomLabel =[[UILabel alloc]initWithFrame:CGRectMake(button.frame.origin.x, 39, button.frame.size.width, 1)];
            _bottomLabel.backgroundColor =[UIColor brownColor];
            [_scrollView addSubview:_bottomLabel];
        }else{
            UIButton *button1 =[self.view viewWithTag:600+i-1];
            
            button.frame =CGRectMake(button1.frame.origin.x+button1.frame.size.width+20, 10,[self autoForWidth:array[i] height:20 NSFont:14], 20);
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        [button setTitle:array[i] forState:UIControlStateNormal];
    
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        button.tag =600+i;
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
//        CGRect frame =button.frame;
//        frame.size.width =[self autoForWidth:array[i] height:20 NSFont:14];
//        button.frame =frame;
        if (i ==array.count-1) {
            _scrollView.contentSize =CGSizeMake(button.frame.origin.x+button.frame.size.width+10, 0);
        }
        
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
//根据文字自适应宽度
- (CGFloat)autoForWidth:(NSString *)textString height:(CGFloat)height NSFont:(CGFloat)font{
    CGFloat width = [textString boundingRectWithSize:CGSizeMake(1000, height) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.width;
    return width;
}
//点击button
- (void)selectButton:(UIButton *)sender{
    [sender setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    if (_oldTag) {
        UIButton *oldButton =[self.view viewWithTag:_oldTag];
        [oldButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _oldTag =sender.tag;
    }else{
        _oldTag =sender.tag;
    }
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame =self.bottomLabel.frame;
        frame.origin.x =sender.frame.origin.x;
        frame.size.width =sender.frame.size.width;
        self.bottomLabel.frame =frame;
    }];
    if (sender.tag >=603) {
        UIButton *button =[self.view viewWithTag:sender.tag-3];
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset =CGPointMake(button.frame.origin.x+button.frame.size.width+10, 0);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.contentOffset =CGPointMake(0, 0);
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
