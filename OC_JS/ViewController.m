//
//  ViewController.m
//  OC&&JS
//
//  Created by 杜海龙 on 2017/6/20.
//  Copyright © 2017年 杜海龙. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webView.delegate        = self;
    self.webView.backgroundColor = [UIColor lightGrayColor];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.101/Html-JS/js-oc.html"]]];
    [self.view addSubview:self.webView];
}



#pragma mark - WebView Delegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"start");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finsh");
    //JS调用原生OC方法（可以带参数）
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"share"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self evokeOC];
        });
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal.toString);
        }
        NSLog(@"-------End Log-------");
    };
    
    
    //OC调取js方法
    //JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString *textJS = @"showAlert('这里是JS中alert弹出的message','MES')";
    [context evaluateScript:textJS];
}

#pragma mark - OC
- (void)evokeOC{
    
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:nil
                                                                         message:@"OC原声方法"
                                                                  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction        = [UIAlertAction actionWithTitle:@"y"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction *action) {
                                                                
                                    
                                                            }];
    UIAlertAction *cancle          = [UIAlertAction actionWithTitle:@"y"
                                                              style:UIAlertActionStyleCancel
                                                            handler:^(UIAlertAction *action) {
                                                            }];

    [alertDialog addAction:cancle];
    [alertDialog addAction:okAction];
    [self presentViewController:alertDialog animated:YES completion:nil];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
