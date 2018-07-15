//
//  DemoController.m
//  WaterFallDemo
//
//  Created by luckyCoderCai on 2018/7/5.
//  Copyright © 2018年 Cai. All rights reserved.
//

#import "DemoController.h"
#import <Masonry/Masonry.h>
#import "ListTableView.h"
#import "ListModel.h"

#define SCREEN_Width    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_Height   ([UIScreen mainScreen].bounds.size.height)

@interface DemoController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *leftDataArray;
@property (nonatomic, strong) NSMutableArray *rightDataArray;
@property (nonatomic, strong) ListTableView *leftTableView;
@property (nonatomic, strong) ListTableView *rightTableView;

@end

@implementation DemoController

#pragma mark -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        _scrollView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    }
    return _scrollView;
}

- (NSMutableArray *)leftDataArray
{
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableArray *)rightDataArray
{
    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}

- (ListTableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [[ListTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _leftTableView.scrollEnabled = NO;
    }
    return _leftTableView;
}

- (ListTableView *)rightTableView
{
    if (!_rightTableView) {
        _rightTableView = [[ListTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rightTableView.scrollEnabled = NO;
    }
    return _rightTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    //需要先获取数据 然后创建 否则无数据 无法计算高度
    [self createView];
}

- (void)loadData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"List.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *temArr = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock: ^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        [temArr addObject:[ListModel listWithDict:dict]];
    }];
    
    NSMutableArray *leftArr = [NSMutableArray array];
    NSMutableArray *rightArr = [NSMutableArray array];
    [temArr enumerateObjectsUsingBlock:^(ListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //这里的数值与cell中布局相关 若修改 需同步修改
        CGFloat height = 4 + 10 + [self labelRectWithSize:CGSizeMake(SCREEN_Width/2.0 - 25 - 10, CGFLOAT_MAX) LabelText:obj.title Font:[UIFont systemFontOfSize:12]] + 10 + (SCREEN_Width/2.0 - 15 - 10 - 20) * 3/5 + 35 + 50;
        obj.height = height;
        
        if (idx % 2 == 0) {
            obj.leftBOOL = YES;
            [leftArr addObject:obj];
        } else {
            obj.leftBOOL = NO;
            [rightArr addObject:obj];
        }
    }];
    
    self.leftDataArray = leftArr;
    self.rightDataArray = rightArr;
    
    self.leftTableView.dataArray = self.leftDataArray;
    [self.leftTableView reloadData];
    self.rightTableView.dataArray = self.rightDataArray;
    [self.rightTableView reloadData];
}

- (void)createView
{
    __block CGFloat leftHeight = 0;
    __block CGFloat rightHeight = 0;
    [self.leftDataArray enumerateObjectsUsingBlock:^(ListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        leftHeight += obj.height;
    }];
    [self.rightDataArray enumerateObjectsUsingBlock:^(ListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        rightHeight += obj.height;
    }];
    
    //没有用iPhone X跑 是否适配放到工程里相应做修改
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_Width, (leftHeight > rightHeight)?leftHeight:rightHeight + 200);
    [self.view addSubview:self.scrollView];
    
    if (@available(iOS 11.0, *)) {
        self.leftTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.rightTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    //对于这种两个tableView高度不一致的 废弃了使用scrollViewDidScroll:方法 使其偏移一致的做法 加了个scrollView作为父视图
    [self.scrollView addSubview:self.leftTableView];
    [self.scrollView addSubview:self.rightTableView];
    
    self.leftTableView.frame = CGRectMake(0, 0, SCREEN_Width/2.0, (leftHeight > rightHeight)?leftHeight:rightHeight);
    self.rightTableView.frame = CGRectMake(SCREEN_Width/2.0, 0, SCREEN_Width/2.0, (leftHeight > rightHeight)?leftHeight:rightHeight);
    
    ///懒得写懒加载了 若需要 自行修改为全局懒加载
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor blackColor];
    [self.scrollView addSubview:line];
    line.frame = CGRectMake(SCREEN_Width/2.0 - 0.5/2, -30, 0.5, (leftHeight > rightHeight)?leftHeight:rightHeight);
    
    //这里无法写懒加载 若需要做相应修改
    __block CGFloat leftDotHeight = 0;
    [self.leftDataArray enumerateObjectsUsingBlock:^(ListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/2.0 - 10/2, leftDotHeight - 2, 10, 10)];
        //        imgView.image = [UIImage imageNamed:@""];
        imgView.backgroundColor = [UIColor greenColor];
        [self.scrollView addSubview:imgView];
        
        leftDotHeight += obj.height;
    }];
    
    __block CGFloat rightDotHeight = 0;
    [self.rightDataArray enumerateObjectsUsingBlock:^(ListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/2.0 - 10/2, 50 + rightDotHeight - 2, 10, 10)];
        //        imgView.image = [UIImage imageNamed:@""];
        imgView.backgroundColor = [UIColor orangeColor];
        [self.scrollView addSubview:imgView];
        
        rightDotHeight += obj.height;
    }];
    
}

#pragma mark - 文本自定义高度
- (CGFloat)labelRectWithSize:(CGSize)size
                   LabelText:(NSString *)labelText
                        Font:(UIFont *)font {
    
    NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize rect = [labelText boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return rect.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
