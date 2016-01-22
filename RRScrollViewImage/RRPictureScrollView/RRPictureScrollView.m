//
//  RRPictureScrollView.m
//  RRScrollViewImage
//
//  Created by roarrain on 16/1/18.
//  Copyright © 2016年 roarrain. All rights reserved.
//

#import "RRPictureScrollView.h"
#import "UIImageView+WebCache.h"

#define SCROLLVIEWFRAMEWITH self.frame.size.width
#define SCROLLVIEWFRAMEHEIGHT self.frame.size.height

@interface RRPictureScrollView () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) UILabel *titleLable;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *centerImageView;
@property(nonatomic, strong) UIImageView *rightImageView;
@property(nonatomic, strong) UIImage *placeholderImage;
@property(nonatomic, assign) NSInteger pageNum;
@property(nonatomic, assign) NSInteger imageCount;
@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic, assign) NSInteger currentIndex;

@end

@implementation RRPictureScrollView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    [self creatScroll];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame With:(UIImage *)placeholderImage {
  if (self = [super initWithFrame:frame]) {

    [self creatScroll];
    [self setPlaceholderImage:placeholderImage];
  }
  return self;
}

+ (instancetype)creatRRScroolViewWithFrame:(CGRect)frame
                          placeholderImage:(UIImage *)placeholderImage {

  return
      [[RRPictureScrollView alloc] initWithFrame:frame With:placeholderImage];
}

- (void)creatScroll {
  if (!_scrollView) {

    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];

    _scrollView.pagingEnabled = YES;

    _scrollView.showsHorizontalScrollIndicator = NO;

    _scrollView.showsVerticalScrollIndicator = NO;

    _scrollView.delegate = self;

    _scrollView.contentSize =
        CGSizeMake(SCROLLVIEWFRAMEWITH * 3, SCROLLVIEWFRAMEHEIGHT);

    _scrollView.contentOffset = CGPointMake(SCROLLVIEWFRAMEWITH, 0);

    _scrollView.bounces = NO;

    [self addSubview:_scrollView];

    _TimeInterval = 3.0f;
  }
}
- (void)creatPageContolWithStylr:(PageControlStyle)pageControlStyle {

  if (_pageControl) {

    [_pageControl removeFromSuperview];
  }

  _pageControl = [[UIPageControl alloc] init];

  _pageControl.numberOfPages = _imageCount;

  CGSize size = [_pageControl sizeForNumberOfPages:_imageCount];

  switch (pageControlStyle) {

  case PageControlStyleLeft:

    _pageControl.frame = CGRectMake(30, SCROLLVIEWFRAMEHEIGHT - size.height + 5,
                                    size.width, size.height);

    break;

  case PageControlStyleCenter:

    _pageControl.center = CGPointMake(SCROLLVIEWFRAMEWITH / 2,
                                      SCROLLVIEWFRAMEHEIGHT - size.height + 25);

    break;

  case PageControlStyleRight:

    _pageControl.frame = CGRectMake(SCROLLVIEWFRAMEWITH - size.width - 30,
                                    SCROLLVIEWFRAMEHEIGHT - size.height + 5,
                                    size.width, size.height);

    break;

  default:

    break;
  }

  [self addSubview:self.pageControl];
}

- (void)creatTileLable {

  _titleLable =
      [[UILabel alloc] initWithFrame:CGRectMake(0, SCROLLVIEWFRAMEHEIGHT - 30,
                                                SCROLLVIEWFRAMEWITH, 30)];

  _titleLable.backgroundColor = [UIColor grayColor];

  _titleLable.alpha = 0.5f;

  _titleLable.text = [NSString stringWithFormat:@"  %@", _titlesArray[0]];

  [self addSubview:self.titleLable];
}

- (void)setImageArray:(NSArray *)imageArray {

  if (imageArray.count == 0) {

    return;
  }

  _imageArray = imageArray;

  _imageCount = imageArray.count;

  [self configScrollView];

  [self creatPageContolWithStylr:PageControlStyleCenter];

  [self setAutoScroll:YES];
}
- (void)setTitlesArray:(NSArray *)titlesArray {

  if (titlesArray.count == 0)
    return;
  if (_imageCount) {
    if (_imageCount > titlesArray.count) {
      NSMutableArray *tit = [NSMutableArray arrayWithArray:titlesArray];
      for (int i = 0; i < _imageCount - titlesArray.count; i++) {
        [tit addObject:@""];
      }
    } else {
      _titlesArray = titlesArray;
    }

    [self creatTileLable];
    [self creatPageContolWithStylr:PageControlStyleRight];
  }
}
- (void)setPlaceholderImage:(UIImage *)placeholderImage {
  _placeholderImage = placeholderImage;
}
- (void)setAutoScroll:(BOOL)autoScroll {

  _autoScroll = autoScroll;

  if (_autoScroll) {
    if (!_timer) {
      [self creatTimer];
    }
  } else {
    if (_timer) {
      [_timer invalidate];
      _timer = nil;
    }
  }
}

- (void)creatTimer {

  if (!_autoScroll)
    return;
  if (!_timer) {
    NSTimer *timer = [NSTimer timerWithTimeInterval:_TimeInterval
                                             target:self
                                           selector:@selector(timerFire)
                                           userInfo:nil
                                            repeats:YES];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    _timer = timer;
    [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
  }
}
- (void)setTimeInterval:(NSInteger)TimeInterval {
  _TimeInterval = TimeInterval;
}
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
  if (_pageControl) {

    _pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
  }
}
- (void)setCurrentPageIndicatorTintColor:
    (UIColor *)currentPageIndicatorTintColor {
  if (_pageControl) {

    _pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
  }
}
- (void)setPageControStyle:(PageControlStyle)pageControStyle {

  [self creatPageContolWithStylr:pageControStyle];
}

- (void)setTitleLableFont:(UIFont *)titleLableFont {
  if (_titleLable) {
    _titleLable.font = titleLableFont;
  }
}
- (void)setTitleLableFontColor:(UIColor *)titleLableFontColor {
  if (_titleLable) {
    _titleLable.textColor = titleLableFontColor;
  }
}

- (void)setTitleLableAlpha:(CGFloat)titleLableAlpha {
  if (_titleLable) {
    _titleLable.alpha = titleLableAlpha;
  }
}
- (void)configScrollView {

  _leftImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(SCROLLVIEWFRAMEWITH * 0, 0, SCROLLVIEWFRAMEWITH,
                               SCROLLVIEWFRAMEHEIGHT)];

  _centerImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(SCROLLVIEWFRAMEWITH * 1, 0, SCROLLVIEWFRAMEWITH,
                               SCROLLVIEWFRAMEHEIGHT)];

  _rightImageView = [[UIImageView alloc]
      initWithFrame:CGRectMake(SCROLLVIEWFRAMEWITH * 2, 0, SCROLLVIEWFRAMEWITH,
                               SCROLLVIEWFRAMEHEIGHT)];

  _centerImageView.userInteractionEnabled = YES;

  [_centerImageView
      addGestureRecognizer:[[UITapGestureRecognizer alloc]
                               initWithTarget:self
                                       action:@selector(tapImageView)]];

  [self.scrollView addSubview:_leftImageView];
  [self.scrollView addSubview:_centerImageView];
  [self.scrollView addSubview:_rightImageView];

  if (_imageCount == 1) {

    [self setImageWithCount:0 AndCenterImageCount:0 AndRightImageCount:0];

  } else {

    [self setImageWithCount:self.imageArray.count - 1
        AndCenterImageCount:0
         AndRightImageCount:1];
  }
}

#pragma mark--UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  if (_autoScroll) {
    [_timer invalidate];
    _timer = nil;
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(BOOL)decelerate

{
  if (_autoScroll) {
    [self creatTimer];
  }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

  if (scrollView.contentOffset.x == 0) {

    if (_imageCount == 1) {

      [self setImageWithCount:0 AndCenterImageCount:0 AndRightImageCount:0];

    } else {
      if (_currentIndex == 0) {

        _currentIndex = self.imageArray.count - 1;

        [self setImageWithCount:_currentIndex - 1
            AndCenterImageCount:_currentIndex
             AndRightImageCount:0];

      } else {

        _currentIndex--;

        if (_currentIndex == 0) {

          [self setImageWithCount:self.imageArray.count - 1
              AndCenterImageCount:_currentIndex
               AndRightImageCount:_currentIndex + 1];

        } else {

          [self setImageWithCount:_currentIndex - 1

              AndCenterImageCount:_currentIndex

               AndRightImageCount:_currentIndex + 1];
        }
      }
    }

    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);

  } else if (scrollView.contentOffset.x == scrollView.bounds.size.width * 2) {

    if (_imageCount == 1) {

      [self setImageWithCount:0 AndCenterImageCount:0 AndRightImageCount:0];

    } else {
      if (_currentIndex == self.imageArray.count - 1) {

        _currentIndex = 0;

        [self setImageWithCount:self.imageArray.count - 1

            AndCenterImageCount:_currentIndex

             AndRightImageCount:_currentIndex + 1];

      } else {

        _currentIndex++;

        if (_currentIndex == self.imageArray.count - 1) {

          [self setImageWithCount:_currentIndex - 1

              AndCenterImageCount:_currentIndex

               AndRightImageCount:0];

        } else {

          [self setImageWithCount:_currentIndex - 1

              AndCenterImageCount:_currentIndex

               AndRightImageCount:_currentIndex + 1];
        }
      }
    }
    scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
  }
}

- (void)setImageWithCount:(NSInteger)leftImageCount
      AndCenterImageCount:(NSInteger)centerImageCount
       AndRightImageCount:(NSInteger)rightImageCount {

  _pageControl.currentPage = centerImageCount;

  _titleLable.text =
      [NSString stringWithFormat:@"  %@", _titlesArray[centerImageCount]];
  [self configImageWithStr:_imageArray[leftImageCount]
             WithImageView:_leftImageView];
  [self configImageWithStr:_imageArray[centerImageCount]
             WithImageView:_centerImageView];
  [self configImageWithStr:_imageArray[rightImageCount]
             WithImageView:_rightImageView];
}
- (void)configImageWithStr:(NSString *)imageStr
             WithImageView:(UIImageView *)imageV {
  if ([imageStr hasPrefix:@"http://"]) {
    [imageV sd_setImageWithURL:[NSURL URLWithString:imageStr]
              placeholderImage:_placeholderImage];
  } else {
    imageV.image = [UIImage imageNamed:imageStr];
  }
}

- (void)timerFire {
  if (_scrollView) {
    [self.scrollView
        setContentOffset:CGPointMake(self.scrollView.bounds.size.width * 2, 0)
                animated:YES];
  }
}

- (void)tapImageView {
  if ([_delegate respondsToSelector:@selector(rrPictureScrollView:
                                                selectPageAtIndex:)]) {
    [_delegate rrPictureScrollView:self selectPageAtIndex:_currentIndex + 1];
  }
  if (self.RRPictureScroolViewSelectItemBlock) {
    self.RRPictureScroolViewSelectItemBlock(_currentIndex + 1);
  }
}
@end
