//
//  GraphVerificationCodeView.h
//  Demo
//
//  Created by zhm on 2018/12/26.
//  Copyright © 2018 dongfangyoubo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GraphVerificationCodeType) {
    GraphVerificationCodeTypeMixture = 0,
    GraphVerificationCodeTypeNumber,
    GraphVerificationCodeTypeLetter,
    GraphVerificationCodeTypeUpperCase,
    GraphVerificationCodeTypeLowerCase,
};

IB_DESIGNABLE @interface GraphVerificationCodeView : UIView

/**
 验证码数目
 */

@property(nonatomic,assign)IBInspectable NSInteger count;
/**
 数据源类型
 */
@property(nonatomic,assign)IBInspectable NSInteger showType;

@property(nonatomic,assign)GraphVerificationCodeType type;


/**
 验证码
 */
@property(nonatomic,strong)NSString *code;

- (instancetype)initWithFrame:(CGRect)frame withCount:(NSInteger)count;

@end


