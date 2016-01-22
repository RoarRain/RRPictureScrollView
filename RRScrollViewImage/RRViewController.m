//
//  RRViewController.m
//  RRScrollViewImage
//
//  Created by roarrain on 16/1/16.
//  Copyright © 2016年 roarrain. All rights reserved.
//

#import "RRViewController.h"
#import "RRPictureScrollView.h"
#import "RRPushViewController.h"


@interface RRViewController()<RRPictureScrollViewDelegate>

@end

@implementation RRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RRPictureScrollView";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
   
//

//    ----------------华丽的分割线---------------
    
    UIImage *image = [UIImage imageNamed:@"img_01"];
    RRPictureScrollView *rr = [RRPictureScrollView creatRRScroolViewWithFrame:CGRectMake(0,0,self.view.frame.size.width, 150) placeholderImage:image];

    rr.backgroundColor = [UIColor greenColor];
   

    rr.imageArray = @[@"image1.jpg",@"image2.jpg",@"image3.jpg",@"image4.jpg"];
//    rr.autoScroll = NO;
    rr.currentPageIndicatorTintColor = [UIColor redColor];
    rr.pageIndicatorTintColor = [UIColor blueColor];
  
    rr.delegate = self;
    [self.view addSubview:rr];
    
    
//    ----------------华丽的分割线---------------
    
    RRPictureScrollView *rr2 = [[RRPictureScrollView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 150)];
    rr2.imageArray = @[
      @"http://52hzy.cn/scrollviewimage/image10.jpg",
      @"http://52hzy.cn/scrollviewimage/image9.jpg",
      @"http://52hzy.cn/scrollviewimage/image8.jpg",
      @"http://52hzy.cn/scrollviewimage/image7.jpg"
    ];
    rr2.titlesArray = @[@"RRPictureScrollView",@"谢谢你的支持",@"欢迎Star",@"一直在努力"];
    rr2.titleLableFontColor = [UIColor greenColor];
    rr2.titleLableAlpha = 0.8;
    [self.view addSubview:rr2];
    
    
    [rr2 setRRPictureScroolViewSelectItemBlock:^(NSInteger idx) {
         RRPushViewController *pushView = [[RRPushViewController alloc]init];
        [self.navigationController pushViewController:pushView animated:YES];
    }];
    
  
    
}


- (void)rrPictureScrollView:(RRPictureScrollView *)pictureScrollView selectPageAtIndex:(NSInteger)pageIndex{

    RRPushViewController *pushView = [[RRPushViewController alloc]init];
    [self.navigationController pushViewController:pushView animated:YES];}

@end
