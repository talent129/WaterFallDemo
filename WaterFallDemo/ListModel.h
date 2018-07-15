//
//  ListModel.h
//  WaterFallDemo
//
//  Created by luckyCoderCai on 2018/7/5.
//  Copyright © 2018年 Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ListModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *time;

@property (nonatomic, assign) BOOL leftBOOL;
@property (nonatomic, assign) CGFloat height;//一个cell高度

+ (instancetype)listWithDict:(NSDictionary *)dict; //字典转模型

@end
