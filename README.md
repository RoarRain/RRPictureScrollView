# RRPictureScrollView
图片无限轮播RRPictureScrollView

一个简单实用的图片轮播器，支持无限轮播

注：网络图片加载需要SDWebImage 支持

 ![gif](http://52hzy.cn/scrollviewimage/RRScrollView.gif)


      UIImage *image = [UIImage imageNamed:@"img_01"];
  
      //初始化一个带占位图的RRPictureScrollView
  
      RRPictureScrollView *rr = [RRPictureScrollView creatRRScroolViewWithFrame:CGRectMake(0,0,self.view.frame.size.width,               150) placeholderImage:image];
      rr.backgroundColor = [UIColor greenColor];
      rr.imageArray = @[@"image1.jpg",@"image2.jpg",@"image3.jpg",@"image4.jpg"];
      rr.currentPageIndicatorTintColor = [UIColor redColor];
      rr.pageIndicatorTintColor = [UIColor blueColor];
      rr.delegate = self;
      [self.view addSubview:rr];
      
      
      //Block回调
       [rr setRRPictureScroolViewSelectItemBlock:^(NSInteger idx) {
        
         }];
      
      
      //代理回调
      - (void)rrPictureScrollView:(RRPictureScrollView *)pictureScrollView selectPageAtIndex:(NSInteger)pageIndex;
      
      
      
  谢谢支持 有问题可以发邮件给我 RoarRain@163.com
  
  
  
