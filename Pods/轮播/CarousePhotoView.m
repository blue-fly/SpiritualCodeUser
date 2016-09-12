//
//  CarousePhotoView.m
//  UI_MRC下封装轮播图
//
//  Created by sxz on 16/3/7.
//  Copyright © 2016年 sun. All rights reserved.
//
#import "CarousePhotoView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#define KWIDTH self.frame.size.width
#define KHEIGHT self.frame.size.height
@interface CarousePhotoView () <UIScrollViewDelegate>
@property(nonatomic, retain)UIScrollView *scrollView;

@property(nonatomic, retain)UIImageView *currentImageView;

@property(nonatomic, retain)UIImageView *frontImageView;

@property(nonatomic, retain)UIImageView *behindImageView;

@property(nonatomic, retain)UIPageControl *pageControl;

@property(nonatomic, assign)NSInteger page;

@property(nonatomic, retain)NSTimer *timer;

@end

@implementation CarousePhotoView

- (void)dealloc{
    [_scrollView release];
    [_currentImageView release];
    [_frontImageView release];
    [_behindImageView release];
    [_imageUrlArr release];
    [_urlArr release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame timeInterval:(CGFloat)timeInterval imageUrlArr:(NSArray <NSURL*> *)imageUrlArr urlArr:(NSArray *)urlArr{
    if (self = [super initWithFrame:frame]) {
        _timeInterval = timeInterval;
        self.imageUrlArr = [NSMutableArray arrayWithArray:imageUrlArr];
        self.urlArr = [NSMutableArray arrayWithArray:urlArr];
        [self createCarousel];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        
    }
    return self;
}


- (void)createCarousel{
    _page = 0;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(KWIDTH * 3, KHEIGHT);
    self.scrollView.contentOffset = CGPointMake(KWIDTH, self.scrollView.contentOffset.y);
    [_scrollView release];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPicture)];
    self.currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH, 0, KWIDTH, KHEIGHT)];
    [self.currentImageView addGestureRecognizer:tap];
    [tap release];
    self.currentImageView.userInteractionEnabled = YES;
    [self.currentImageView sd_setImageWithURL:self.imageUrlArr[0]];
    [self.scrollView addSubview:self.currentImageView];
    [_currentImageView release];
    
    self.frontImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWIDTH, KHEIGHT)];
    [self.frontImageView sd_setImageWithURL:self.imageUrlArr.lastObject];
    [self.scrollView addSubview:self.frontImageView];
    [_frontImageView release];
    
    self.behindImageView = [[UIImageView alloc] initWithFrame:CGRectMake(KWIDTH * 2, 0, KWIDTH, KHEIGHT)];
    [self.behindImageView sd_setImageWithURL:self.imageUrlArr[1]];
    [self.scrollView addSubview:self.behindImageView];
    [_behindImageView release];
    
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.imageUrlArr.count * 15, 20)];
    self.pageControl.center = CGPointMake(self.frame.size.width / 2, self.pageControl.center.y);
    self.pageControl.numberOfPages = self.imageUrlArr.count;
    self.pageControl.currentPage = 0;
    //    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //    self.pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    
    [self addSubview:self.pageControl];
    [_pageControl release];
}


- (void)changeImage{
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + KWIDTH, 0) animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
    _page = (_page + 1) % self.imageUrlArr.count;
    if (_page < self.imageUrlArr.count - 1 && _page > 0) {
        [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
        [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
        [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
        
    }
    else if(_page == self.imageUrlArr.count - 1){
        [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
        [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
        [self.behindImageView sd_setImageWithURL:self.imageUrlArr.firstObject];
    }
    else{
        [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
        [self.frontImageView sd_setImageWithURL:self.imageUrlArr.lastObject];
        [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
    }
    
    self.pageControl.currentPage = _page;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _page = self.pageControl.currentPage;
    if (scrollView.contentOffset.x > KWIDTH) {
        _page = (_page + 1) % self.imageUrlArr.count;
        if (_page < (NSInteger)(self.imageUrlArr.count - 1) && _page > 0) {
            [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
            self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
            [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
            [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
            self.pageControl.currentPage = _page;
        }
        else{
            if(_page == 0){
                [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
                self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
                [self.frontImageView sd_setImageWithURL:self.imageUrlArr.lastObject];
                [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
                self.pageControl.currentPage = 0;
            }
            else if (_page == self.imageUrlArr.count - 1) {
                [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
                self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
                [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
                [self.behindImageView sd_setImageWithURL:self.imageUrlArr.firstObject];
                self.pageControl.currentPage = self.imageUrlArr.count - 1;
                //_page = -1;
            }
            
        }
        
    }
    if (scrollView.contentOffset.x < KWIDTH) {
        _page = (_page - 1 + self.imageUrlArr.count)  % self.imageUrlArr.count;
        if (_page > 0 && _page < (NSInteger)self.imageUrlArr.count - 1) {
            [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
            self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
            [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
            [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
            self.pageControl.currentPage = _page;
        }
        else{
            if (_page == 0) {
                [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
                self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
                [self.frontImageView sd_setImageWithURL:self.imageUrlArr.lastObject];
                [self.behindImageView sd_setImageWithURL:self.imageUrlArr[_page + 1]];
                self.pageControl.currentPage = 0;
            }
            else if (_page >= self.imageUrlArr.count - 1) {
                _page = self.imageUrlArr.count - 1;
                [self.currentImageView sd_setImageWithURL:self.imageUrlArr[_page]];
                self.scrollView.contentOffset = CGPointMake(KWIDTH, 0);
                [self.frontImageView sd_setImageWithURL:self.imageUrlArr[_page - 1]];
                [self.behindImageView sd_setImageWithURL:self.imageUrlArr.firstObject];
                self.pageControl.currentPage = self.imageUrlArr.count - 1;
            }
        }
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}

- (void)clickPicture{
//    NSString *urlStr = self.urlArr[self.page];
//    [self.delegate pushWithUrl:urlStr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
