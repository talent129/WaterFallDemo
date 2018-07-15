//
//  ListCell.h
//  WaterFallDemo
//
//  Created by luckyCoderCai on 2018/7/5.
//  Copyright © 2018年 Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
@interface ListCell : UITableViewCell

@property (nonatomic, strong) ListModel *model;

@end
