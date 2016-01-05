//
//  ViewController.m
//  头部视图缩放
//
//  Copyright © 2015年 王洋. All rights reserved.
//

#import "ViewController.h"

#define HEADERIMAGE_HEIGHT 200
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UIImageView * headerImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self createTableView];
    
    [self createHeaderImage];
    
}

/** 创建tableView */
-(void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.contentInset=UIEdgeInsetsMake(HEADERIMAGE_HEIGHT, 0, 0, 0);
}

/** 创建头部视图 */
-(void)createHeaderImage
{
    self.headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -HEADERIMAGE_HEIGHT, WIDTH, HEADERIMAGE_HEIGHT)];
    
    self.headerImageView.image = [UIImage imageNamed:@"5.jpg"];
    
    [self.tableView addSubview:self.headerImageView];
}

#pragma mark =====核心=====
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断tableView的滑动
    if (scrollView==self.tableView)
    {
        //获得tableView滑动的距离
        CGFloat y = scrollView.contentOffset.y;
        CGFloat x = (y + HEADERIMAGE_HEIGHT)/2;
        //判断滑动的距离小于图片本身的高度时变化
        if (y<-HEADERIMAGE_HEIGHT)
        {
            CGRect rect = self.headerImageView.frame;
            rect.origin.y = y;
            rect.size.height = -y;
            rect.origin.x = x;
            rect.size.width=WIDTH+fabs(x)*2;
            self.headerImageView.frame=rect;
        }

    }
}



#pragma mark =====tableView协议方法=====
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseID=@"reuse";
    
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%zd行",indexPath.row];
    
    return cell;
    
}






@end
