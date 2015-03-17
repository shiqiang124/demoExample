//
//  PKLoadMoreTableViewController.h
//  iOSExample
//
//  Created by sq on 15/3/16.
//  Copyright (c) 2015年 lofter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PKLoadMoreTableViewController : UITableViewController

@property(nonatomic,assign) BOOL pkCanLoadPull;
@property(nonatomic,assign) BOOL pkCanLoadMore;
@property(nonatomic,assign) CGFloat pkInsetTop;//如果是iOS7并且有 status和nav的时候需要设置,有status和nav的时候设置-64
@property(nonatomic,assign) NSInteger pkNumberOfSections;//加载更多的多加一个section
@property(nonatomic,strong) NSMutableArray *pkListItems;

//可选的
@property(nonatomic,strong) UIView *pkCustomPullView;//当不能下拉刷新的时候可以自定义顶部view


//子类需要重写的方法
- (void)pkWillRefresh;
- (void)pkWillLoadMore;


//供子类完成请求api后调用的方法,不需要重写
- (void)pkDidRefresh;
- (void)pkDidLoadMore;


//可选的调用方法
- (void)pkAutoLoading;

@end
