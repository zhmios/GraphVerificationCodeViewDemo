//
//  GraphVerificationCodeView.m
//  Demo
//
//  Created by zhm on 2018/12/26.
//  Copyright © 2018 dongfangyoubo. All rights reserved.
//

#import "GraphVerificationCodeView.h"

//随即色
#define kRandomColor [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1]
//随机背景色
#define NNRandomColor [UIColor colorWithRed:arc4random() % 100 / 100.0 green:arc4random() % 100 / 100.0 blue:arc4random() % 100 / 100.0 alpha: 0.5]


@interface GraphVerificationCodeView ()

@property (nonatomic, strong) NSMutableArray *codeArr;
@property(nonatomic, strong) NSArray *charArray;

@end

@implementation GraphVerificationCodeView

- (instancetype)initWithFrame:(CGRect)frame withCount:(NSInteger)count{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGraphVerificationCodeWithCount:count];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        [self initGraphVerificationCodeWithCount:0];
    }
    return self;
}

- (NSMutableArray *)codeArr{
    if (!_codeArr) {
        _codeArr = [[NSMutableArray alloc] init];
    }
    return _codeArr;
}
- (NSArray *)charArray {
    if (!_charArray) {
        _charArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    }
    return _charArray;
}

- (void)initGraphVerificationCodeWithCount:(NSInteger)count{
    if (count > 0) {
       self.count = count;
    }
    self.backgroundColor = NNRandomColor;
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    if (self.codeArr.count > 0) {
        [self.codeArr removeAllObjects];
    }
    [self generateCode];
    [self setNeedsDisplayInRect:self.bounds];
    
}

- (void)generateCode{
    
    //生成随机码
    for (int i = 0; i < self.count; i++) {
        NSInteger index = arc4random() % ([self.charArray count]);
        NSString *getStr = [self.charArray objectAtIndex:index];
        [self.codeArr addObject:getStr];
    }
    _code = [self.codeArr componentsJoinedByString:@""];
   
}

- (void)setCount:(NSInteger)count{
    _count = count;
    [self generateCode];
    
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    self.backgroundColor = NNRandomColor;
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    int lineCount = 2 + (arc4random() % 4);
    for (int i = 0; i < lineCount; i ++) {
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(arc4random()%(int)(w+1), arc4random()%(int)(h+1))];
        [bezierPath addLineToPoint:CGPointMake(arc4random()%(int)(w+1), arc4random()%(int)(h+1))];
        [kRandomColor setStroke];
        bezierPath.lineWidth = 1.0;
        [bezierPath stroke];
    }
    
    for (int i = 0; i < self.count; i ++) {
        NSString *itemText = self.codeArr[i];
        CGAffineTransform matrix =CGAffineTransformMake(1, 0, tanf(5 * (CGFloat)M_PI / 180), 1, 0, 0);
        //倾斜角度
        UIFontDescriptor *desc = [ UIFontDescriptor fontDescriptorWithName :[UIFont systemFontOfSize:20].fontName matrix :matrix];
        UIFont *itemFont = [UIFont fontWithDescriptor:desc size:20];
        CGSize codeSize = [itemText sizeWithAttributes:@{NSFontAttributeName:itemFont}];
        CGFloat edgeDistance = 1;
        CGRect textRect = CGRectMake(i * w / self.count + arc4random() % (int)(w / self.count + edgeDistance - codeSize.width), arc4random() % (int)(h+edgeDistance - codeSize.height), codeSize.width, codeSize.height);
        UIColor *textColor = [UIColor colorWithRed:arc4random()%100/255.0 green:arc4random()%150/255.0 blue:arc4random()%200/255.0 alpha:1];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [itemText drawInRect:textRect withAttributes:@{NSForegroundColorAttributeName :textColor,NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName :itemFont}];
        
    }
}

@end
