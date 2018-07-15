//
//  ListModel.m
//  WaterFallDemo
//
//  Created by luckyCoderCai on 2018/7/5.
//  Copyright © 2018年 Cai. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

/**
 *  字典转模型
 */
+ (instancetype)listWithDict:(NSDictionary *)dict {
    id model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
