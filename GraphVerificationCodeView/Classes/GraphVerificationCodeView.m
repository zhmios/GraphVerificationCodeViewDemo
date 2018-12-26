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
@property (nonatomic, strong) NSMutableArray *charArray;
@property (nonatomic, strong) NSArray *numbers;
@property (nonatomic, strong) NSArray *upperCase;
@property (nonatomic, strong) NSArray *lowerCase;

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

- (NSArray *)numbers{
    
    if (!_numbers) {
        _numbers = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _numbers;
}

- (NSArray *)upperCase{
    
    if (!_upperCase) {
        _upperCase = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
    }
    return _upperCase;
}

- (NSArray *)lowerCase{
    
    if (!_lowerCase) {
        _lowerCase = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
    }
    return _lowerCase;
}

- (NSMutableArray *)charArray {
    if (!_charArray) {
        
        _charArray = [[NSMutableArray alloc] init];
    }
    return _charArray;
}

- (void)makeDataSource{
    
    [self.charArray removeAllObjects];
    switch (self.type) {
            case GraphVerificationCodeTypeMixture:
            
            [self.charArray addObjectsFromArray:self.numbers];
            [self.charArray addObjectsFromArray:self.lowerCase];
            [self.charArray addObjectsFromArray:self.upperCase];
            
            break;
            
            case  GraphVerificationCodeTypeNumber:
            
            [self.charArray addObjectsFromArray:self.numbers];
            
            
            break;
            
            case GraphVerificationCodeTypeLetter:
            
          
            [self.charArray addObjectsFromArray:self.lowerCase];
            [self.charArray addObjectsFromArray:self.upperCase];
            
            break;
            
            case GraphVerificationCodeTypeUpperCase:
            
             [self.charArray addObjectsFromArray:self.upperCase];
            
            break;
            
            case GraphVerificationCodeTypeLowerCase:
            
            [self.charArray addObjectsFromArray:self.lowerCase];
            
            break;
        default:
            break;
    }
    
    
}

- (void)initGraphVerificationCodeWithCount:(NSInteger)count{
    if (count > 0) {
       self.count = count;
    }
    self.textMinEdge = 1.0;
    [self makeDataSource];
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
    [self.codeArr removeAllObjects];
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
    [self makeDataSource];
    [self generateCode];
    
}
- (void)setShowType:(NSInteger)showType{
    _showType = showType;
    self.type = showType;
   
}

- (void)setType:(GraphVerificationCodeType)type{
    _type = type;
    [self makeDataSource];
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
        
        CGRect textRect = CGRectMake(i * w / self.count + arc4random() % (int)(w / self.count + 1 - codeSize.width), arc4random() % (int)(h + 1 - codeSize.height), codeSize.width, codeSize.height);
        UIColor *textColor = [UIColor colorWithRed:arc4random()%100/255.0 green:arc4random()%150/255.0 blue:arc4random()%200/255.0 alpha:1];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [itemText drawInRect:textRect withAttributes:@{NSForegroundColorAttributeName :textColor,NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName :itemFont}];
        
    }
}

@end
