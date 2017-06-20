//
//  ViewController.m
//  OC&&JS
//
//  Created by 杜海龙 on 2017/6/20.
//  Copyright © 2017年 杜海龙. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate        = self;
    self.webView.backgroundColor = [UIColor lightGrayColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.101/Html-JS/2drotate.html"]]];
    [self.view addSubview:self.webView];
}



#pragma mark - WebView Delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finsh");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//lazy
-(UIWebView *)webView{
    if (_webView==nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,
                                                               0,
                                                               self.view.frame.size.width,
                                                               self.view.frame.size.height)];
    }
    return _webView;
}


@end
