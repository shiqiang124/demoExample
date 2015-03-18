//
//  PKLoadMoreTableViewController.m
//  iOSExample
//
//  Created by sq on 15/3/16.
//  Copyright (c) 2015年 lofter. All rights reserved.
//

#import "PKLoadMoreTableViewController.h"
#import "EGORefreshTableHeaderView.h"

static CGFloat const kLoadMoreHeight    = 45.f;
static CGFloat const kPullHeaderHeight  = 65.f;

@interface PKLoadMoreTableViewController ()<EGORefreshTableHeaderDelegate>

@property(nonatomic,strong) EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic,strong) UIActivityIndicatorView *loadMoreView;

@property(nonatomic,assign) BOOL isLoadingPull;
@property(nonatomic,assign) BOOL isLoadingMore;

@end

@implementation PKLoadMoreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];//禁止默认加入scrollview inset
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.pkListItems = [[NSMutableArray alloc] init];
    
    if (!self.refreshHeaderView) {
        if(self.pkCanLoadPull){
            self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
            self.refreshHeaderView.egoDelegate = self;
            [self.tableView addSubview:self.refreshHeaderView];
        }else{
            if(self.pkCustomPullView){
                [self.tableView addSubview:self.pkCustomPullView];
            }
        }
       
    }
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        if(self.pkCanLoadPull){
            self.refreshHeaderView.customCntInsetTop = self.pkInsetTop;
        }
        
        self.tableView.contentInset = UIEdgeInsetsMake(-self.pkInsetTop, 0.0f, 0.0f, 0.0f);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(-self.pkInsetTop, 0.0f, 0.0f, 0.0f);
    }
    
    if(self.pkCanLoadPull){
        [self.refreshHeaderView refreshLastUpdatedDate];
    }
}


#pragma mark -
#pragma mark UITableViewDataSource
//子类不能重写
//增加一行加载更多,必须设置 self.pkNumberOfSections值
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.pkCanLoadMore){
        return self.pkNumberOfSections + 1;
    }else{
        return self.pkNumberOfSections;
    }
}

//子类不能重写
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    if(section == self.pkNumberOfSections){
        //最后一个section的时候,那么返回的Num是1
        if(self.pkCanLoadMore){
            if(self.isLoadingPull){
                return 0;//正在下拉加载中就不要显示加载更多了
            }else{
                return 1;
            }
        }else{
            return 0;
        }
        
    }else{
        //显示数据的行
        return [self.pkListItems count];
    }
}

/**
 *  父类加载更多，子类 self.numberOfSections =1 的时候调用到这里
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if(indexPath.section == self.pkNumberOfSections)  {
        //最后一个section的时候
        static NSString *CellIdentifier = @"LoadingMoreCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            CGFloat cellWidth = CGRectGetWidth(cell.frame);
            NSLog(@"%f",cellWidth);
            
            self.loadMoreView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            self.loadMoreView.frame = CGRectMake((cellWidth-20)/2, (kLoadMoreHeight-20)/2, 20.0f, 20.0f);
            [self.loadMoreView startAnimating];
            
            [cell.contentView addSubview:self.loadMoreView];
        }
        [self.loadMoreView startAnimating];
        
        [self pkWillLoadMore];
        return cell;
    }
    
    return nil;
}
#pragma mark -
#pragma mark Data Source Loading more/ Reloading Methods


- (void)pkWillRefresh
{
    self.isLoadingPull = YES;
}

- (void)pkWillLoadMore{
    self.isLoadingMore = YES;
}

- (void)pkDidRefresh
{
    self.isLoadingPull = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.tableView reloadData];
    
}
- (void)pkDidLoadMore
{
    self.isLoadingMore = NO;
    [self.tableView reloadData];
}

- (void)pkAutoLoading
{
    [UIView animateWithDuration:0.1 animations:^{
            CGPoint autoLoadOffset = self.tableView.contentOffset;
            autoLoadOffset.y = self.pkInsetTop-kPullHeaderHeight-1;
            self.tableView.contentOffset = autoLoadOffset;
        } completion:^(BOOL finished) {
            [self scrollViewDidEndDragging:self.tableView willDecelerate:NO];
        }];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //下拉
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //松开
    [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    [self pkWillRefresh];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    
    return self.isLoadingPull; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    
    return [NSDate date]; // should return date data source was last changed
    
}



@end
