//
//  ViewController.m
//  YMPayHandlerDemo
//
//  Created by 张锐 on 2016/10/21.
//  Copyright © 2016年 张锐. All rights reserved.
//

#import "ViewController.h"
#import "YimaiPayManager.h"

@interface ViewController ()

@property (nonatomic,strong) UIButton *wxPayButton;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.wxPayButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.wxPayButton.frame = CGRectMake(100, 100, 200, 30);
}

#pragma mark - private methods

- (void)wxPayButtonClick{

    NSLog(@"微信按钮支付点击");
    [[YimaiPayManager sharedManager]wxPay];
}

#pragma mark - setters & getters

- (UIButton *)wxPayButton{

    if (_wxPayButton == nil) {
        _wxPayButton = [[UIButton alloc]init];
        [_wxPayButton setTitle:@"点击调起微信支付" forState:UIControlStateNormal];
        [_wxPayButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _wxPayButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_wxPayButton addTarget:self action:@selector(wxPayButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxPayButton;
}

@end
