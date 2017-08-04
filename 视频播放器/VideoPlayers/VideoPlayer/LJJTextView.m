//
//  LJJTextView.m
//  视频播放器
//
//  Created by 1 on 2017/8/3.
//  Copyright © 2017年 junjie.liu. All rights reserved.
//

#import "LJJTextView.h"
#import "UIButton+ButtonEx.h"
#import "Masonry.h"

@interface LJJTextView () <UITextFieldDelegate>

@property (nonatomic, strong) UIButton *outBtn;
@property (nonatomic, strong) UITextField *fieldText;
@property (nonatomic, strong) UIButton *sendBtn;

@end

@implementation LJJTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }
    return self;
}

- (void)outBtnAction:(UIButton *)sender{
    [self.fieldText resignFirstResponder];
    NSNotification *notification =[NSNotification notificationWithName:@"outBtnAction" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];

}

- (void)sendBtnAction:(UIButton *)sender{
    [self.fieldText resignFirstResponder];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:self.fieldText.text forKey:@"key"];
    NSNotification *notification =[NSNotification notificationWithName:@"sendBtnAction" object:dic userInfo:nil];
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)createUI {
    
    self.outBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonTitleString(@"取消").buttonTitleColor([UIColor whiteColor]).buttonSizeFont(14).buttonAction(self,@selector(outBtnAction:));
    }];
    [self addSubview:self.outBtn];
    
    self.fieldText = [[UITextField alloc]init];
    self.fieldText.placeholder = @"发送弹幕内容";
    self.fieldText.delegate = self;
    self.fieldText.textColor = [UIColor cyanColor];
    UIColor *color = [UIColor cyanColor];
    self.fieldText.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.fieldText.placeholder attributes:@{NSForegroundColorAttributeName: color}];
    [self addSubview:self.fieldText];
    [self.fieldText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.sendBtn = [UIButton buttonInitWith:^(UIButton *btn) {
        btn.buttonTitleString(@"发送").buttonTitleColor([UIColor whiteColor]).buttonSizeFont(14).buttonAction(self,@selector(sendBtnAction:));
    }];
    [self addSubview:self.sendBtn];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.fieldText) {
        if (textField.text.length > 10) {
            textField.text = [textField.text substringToIndex:10];
        }
    }
}
- (void)layoutSubviews {
    [self.fieldText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.right.mas_equalTo(-80);
        make.top.mas_equalTo(40);
        make.height.mas_equalTo(60);
    }];
    [self.outBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.fieldText.mas_left).offset(0);
        make.centerY.mas_equalTo(self.fieldText.mas_centerY).offset(0);
        make.height.mas_equalTo(60);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fieldText.mas_right).offset(0);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.fieldText.mas_centerY).offset(0);
        make.height.mas_equalTo(60);
    }];
}

@end
