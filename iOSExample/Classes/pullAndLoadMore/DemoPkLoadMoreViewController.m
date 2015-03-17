//
//  DemoPkLoadMoreViewController.m
//  iOSExample
//
//  Created by sq on 15/3/17.
//  Copyright (c) 2015年 lofter. All rights reserved.
//

#import "DemoPkLoadMoreViewController.h"

@interface DemoPkLoadMoreViewController ()
@property (nonatomic, assign) NSInteger pageIndex;//当前页
@end

@implementation DemoPkLoadMoreViewController


- (void)viewDidLoad {
    self.pkCanLoadMore = YES;
    self.pkCanLoadPull = YES;
    self.pkNumberOfSections = 1;
    self.pkInsetTop = -64.f;
    //self.pkCustomPullView=;
    
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self pkWillLoadMore];
}

#pragma mark - UITableViewDataSource
// table with with built in cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == self.pkNumberOfSections)  {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Row %ld", (long)indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    long row  = indexPath.row;
    NSLog(@"row:%ld",row);
    return nil;
}
#pragma mark - overrite super
-(void) pkWillRefresh {
    [super pkWillRefresh];
    
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSMutableArray *list = [NSMutableArray arrayWithObjects:@{@"a":@"baby",@"b":@"1989"}, nil];
        self.pkListItems = list;
        self.pageIndex = 0;
        self.pkCanLoadMore = YES;
        [self pkDidRefresh];
    });
}

-(void) pkWillLoadMore {
    [super pkWillLoadMore];
    
    double delayInSeconds = 1.f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //这里的回调等同于api的回调
        [self.pkListItems addObject:@{@"a":@"baby",@"b":@"more"}];
        
        self.pageIndex ++;
        if(self.pageIndex >= 10) {
            //如果知道没有更多数据可取的情况
            self.pkCanLoadMore = NO;
        }
        [self pkDidLoadMore];
        
        
    });
}


@end
