//
//  RRPictureScrollView.h
//  RRScrollViewImage
//
//  Created by roarrain on 16/1/18.
//  Copyright © 2016年 roarrain. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    PageControlStyle
 */
typedef enum {
  PageControlStyleLeft,
  PageControlStyleCenter,
  PageControlStyleRight
} PageControlStyle;

@class RRPictureScrollView;

@protocol RRPictureScrollViewDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param pictureScrollView RRPictureScrollView
 *  @param pageIndex         pageIndex
 */
- (void)rrPictureScrollView:(RRPictureScrollView *)pictureScrollView selectPageAtIndex:(NSInteger)pageIndex;

@end

@interface RRPictureScrollView : UIView

/**
 *  是否自动轮播，默认为YES
 */
@property(nonatomic, assign) BOOL autoScroll;
/**
 *  设置定时器间隔 默认3s
 */
@property(nonatomic, assign) NSInteger TimeInterval;
/**
 *  RRPictureScrollViewDelegate
 */
@property(nonatomic, assign) id<RRPictureScrollViewDelegate> delegate;
/**
 *  RRPictureScroolViewSelectItemBlock
 */
@property(nonatomic, copy) void (^RRPictureScroolViewSelectItemBlock)
    (NSInteger idx);

/**
 *  图片名字或者URL数组
 */
@property(nonatomic, copy) NSArray *imageArray;
/**
 *  图片名称数组
 *  如果设置了title  pageControStyle将默认变为 右边PageControlStyleRight
 */
@property(nonatomic, copy) NSArray *titlesArray;

/**
 *pageControStyle 默认是 PageControlStyleCenter
 */
@property(nonatomic, assign) PageControlStyle pageControStyle;
/**
 *  dot color
 */
@property(nonatomic, strong) UIColor *pageIndicatorTintColor;
/**
 *  当前页面dot color
 */
@property(nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 *  titleLableFont
 */
@property(nonatomic, strong) UIFont *titleLableFont;
/**
 *  titleLableFontColor
 */
@property(nonatomic, strong) UIColor *titleLableFontColor;
/**
 *  titleLable透明度 默认0.5
 */
@property(nonatomic, assign) CGFloat titleLableAlpha;

/**
 *  初始化带有占位图片RRPictureScrollView
 *
 *  @param frame            frame
 *  @param placeholderImage 占位图
 *
 *  @return RRPictureScrollView
 */
+ (instancetype)creatRRScroolViewWithFrame:(CGRect)frame placeholderImage:(UIImage *)placeholderImage;

@end
