//
//  ViewController.m
//  iOSExample
//
//  Created by sq on 15/3/13.
//  Copyright (c) 2015年 lofter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",NSStringFromCGPoint(self.myScrollView.contentOffset));
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
    
    self.myScrollView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    [self.myScrollView setContentOffset:CGPointMake(0, -10)];
    NSLog(@"%@",NSStringFromCGPoint(self.myScrollView.contentOffset));
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
