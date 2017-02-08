//
//  ViewController.m
//  XMTableView
//
//  Created by admin on 17/2/8.
//  Copyright © 2017年 XianMing. All rights reserved.
//
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *stateArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TableView的分组展示";
    
    [self initDataSource];
    
    [self initTable];
}

/**
 *  初始化选择行业
 */
- (void)initDataSource
{
    _sectionArray  = [NSMutableArray arrayWithObjects:@"计算机/互联网/通信",
                      @"生产/工艺/制造",
                      @"商业/服务业/个体经营",
                      @"金融/银行/投资/保险",
                      @"文化/广告/传媒",
                      @"娱乐/艺术/表演",
                      @"医疗/护理/制药",
                      @"律师/法务",
                      @"教育/培训",
                      @"学生",nil];
    
    NSArray *one = @[@"工程狮",@"程序猿",@"UI设计师",@"运营人员",@"产品经理",@"策划师",@"市场拓展",@"网站编辑",@"其他"];
    NSArray *two = @[@"管理层",@"技术员",@"检验员",@"质检员",@"就是个工人",@"小组长",@"车间主任",@"其他"];
    NSArray *three = @[@"服务员",@"收银员",@"会计",@"文秘",@"保安大哥",@"销售经理",@"造型师",@"厨师",@"采购员",@"业务经理",@"个体户",@"其他"];
    NSArray *four = @[@"证券分析师",@"操盘手",@"客户经理",@"保险经纪",@"银行职员",@"投资经理",@"理财顾问",@"保险精算师",@"其他"];
    NSArray *five = @[@"作家",@"设计师",@"广告策划",@"主持人",@"编导",@"记者",@"制片人",@"导演",@"草根写手",@"其他"];
    NSArray *six = @[@"歌手",@"模特",@"导演",@"经纪人",@"编剧",@"摄影师",@"音乐人",@"制作人",@"艺术家",@"其实我是一个演员",@"其他"];
    NSArray *seven = @[@"主治医师",@"营养师",@"护士",@"护工",@"美容师",@"医药代表",@"医务工作者",@"药剂师",@"其他"];
    NSArray *eight = @[@"公务员",@"律师",@"警察",@"法官",@"政府工作人员",@"军人",@"其他"];
    NSArray *nine = @[@"幼教",@"教师",@"教授",@"户外拓展",@"讲师",@"教练",@"其他"];
    NSArray *ten = @[@"中学生",@"大学生",@"研究生",@"博士生",@"留学生"];
    
    _dataArray = [NSMutableArray arrayWithObjects:one,two,three,four,five,six,seven,eight,nine,ten, nil];
    _stateArray = [NSMutableArray array];
    
    for (int i = 0; i < _dataArray.count; i++)
    {
        //所有的分区都是闭合
        [_stateArray addObject:@"0"];
    }
}

/**
 *  初始化TableView
 */
- (void)initTable{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewDataSource UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArray.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if ([_stateArray[section] isEqualToString:@"1"]){
        //如果是展开状态
        NSArray *array = [_dataArray objectAtIndex:section];
        return array.count;
    }else{
        //如果是闭合，返回0
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    //    cell.tag =  _dataArray[indexPath.section][indexPath.row];
    cell.tag = indexPath.row;
    return cell;
}

/**
 *  设置section的title
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _sectionArray[section];
}

/**
 *  设置头标题的样式,我这里是手写了一个button,在button上放的图片,文字.可以用别的方式
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 60)];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"case_cell_Line"]];
    
    [button addSubview:line];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, (44-22)/2, 22, 22)];
    [imgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon-%ld",section+1]]];
    [button addSubview:imgView];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, (44-6)/2, 10, 6)];
    
    if ([_stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"icon-sjt"];
        
    }else if ([_stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"icon-xjt"];
        
    }
    [button addSubview:_imgView];
    
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(40, (44-20)/2, 200, 20)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:16]];
    [tlabel setText:_sectionArray[section]];
    [button addSubview:tlabel];
    return button;
}

/**
 *  headButton点击
 */
- (void)buttonPress:(UIButton *)sender
{
    //判断状态值
    if ([_stateArray[sender.tag - 1] isEqualToString:@"1"]){
        //修改
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [_stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:sender.tag - 1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

/**
 *  返回section的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}




@end
