//
//  ListCell.m
//  WaterFallDemo
//
//  Created by luckyCoderCai on 2018/7/5.
//  Copyright © 2018年 Cai. All rights reserved.
//

#import "ListCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import "ListModel.h"

#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

@interface ListCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *horView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ListCell

#pragma mark -
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UIView *)horView
{
    if (!_horView) {
        _horView = [[UIView alloc] init];
        _horView.backgroundColor = [UIColor greenColor];
    }
    return _horView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = [UIColor orangeColor];
        _iconImgView.layer.masksToBounds = YES;
        _iconImgView.layer.cornerRadius = 2;
    }
    return _iconImgView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    }
    return self;
}

- (void)setModel:(ListModel *)model
{
    _model = model;
    
    ///布局 我直接用的remark 比较暴力， 性能没有update好，如果有时间 你可以修改为update
    if (model.leftBOOL) {
        [self createLeftViews];
        self.horView.backgroundColor = [UIColor greenColor];
    } else {
        [self createRightViews];
        self.horView.backgroundColor = [UIColor orangeColor];
    }
    
    self.titleLabel.text = model.title;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@""]];
    self.timeLabel.text = model.time;
}

- (void)createLeftViews
{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.horView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.iconImgView];
    [self.bgView addSubview:self.timeLabel];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-10);
        make.top.equalTo(@0);
        make.height.mas_equalTo(_model.height - 50).priorityHigh();
        make.bottom.equalTo(@-50);
    }];
    
    [self.horView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(@0);
        make.height.equalTo(@4);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.trailing.equalTo(@-5);
        make.top.equalTo(self.horView.mas_bottom).mas_offset(10);
    }];
    
    [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake((SCREEN_Width/2.0 - 15 - 10 - 20), (SCREEN_Width/2.0 - 15 - 10 - 20) * 3/5));
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.iconImgView.mas_bottom).mas_offset(10);
    }];
}

- (void)createRightViews
{
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.horView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.iconImgView];
    [self.bgView addSubview:self.timeLabel];
    
    [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-10);
        make.top.equalTo(@50);
        make.height.mas_equalTo(_model.height - 50).priorityHigh();
        make.bottom.equalTo(@0);
    }];
    
    [self.horView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.and.top.equalTo(@0);
        make.height.equalTo(@4);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@5);
        make.trailing.equalTo(@-5);
        make.top.equalTo(self.horView.mas_bottom).mas_offset(10);
    }];
    
    [self.iconImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@10);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake((SCREEN_Width/2.0 - 15 - 10 - 20), (SCREEN_Width/2.0 - 15 - 10 - 20) * 3/5));
    }];
    
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-10);
        make.top.equalTo(self.iconImgView.mas_bottom).mas_offset(10);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
