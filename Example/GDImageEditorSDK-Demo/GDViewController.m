//
//  GDViewController.m
//  GDImageEditorSDK
//
//  Created by zmz on 06/16/2021.
//  Copyright (c) 2021 zmz. All rights reserved.
//

#import "GDViewController.h"
#import <GDImageEditorSDK/GDImageEditorSDK.h>
#import <GDImageEditorSDK/SVProgressHUD.h>
#import <Photos/Photos.h>
#import "GDDemoUtils.h"

@interface GDViewController () <GDImageEditorSDKDelegate>

@property (weak, nonatomic) IBOutlet UITextField *AKTextField;
@property (weak, nonatomic) IBOutlet UITextField *SKTextField;
@property (weak, nonatomic) IBOutlet UITextField *UIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *templateIDTextField;
@property (weak, nonatomic) IBOutlet UITextField *workIDTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegmenetedControl;
@property (weak, nonatomic) IBOutlet UITextView *resultsTextView;

@property (nonatomic, strong) GDImageEditorSDK *sdk;

@property (nonatomic, strong) dispatch_queue_t synchronizationQueue;

@property (nonatomic, assign) NSInteger assetsCount;

@end

@implementation GDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:215/255.0 green:232/255.0 blue:269/255.0 alpha:1];
    self.AKTextField.text = [GDDemoUtils ak];
    self.SKTextField.text = [GDDemoUtils sk];
    self.UIDTextField.text = [GDDemoUtils uid];
    self.templateIDTextField.text = [GDDemoUtils templateId];
    self.workIDTextField.text = [GDDemoUtils workId];
    self.modeSegmenetedControl.selectedSegmentIndex = [[GDDemoUtils editorMode] isEqualToString:@"template"] ? 0 : 1;
    _synchronizationQueue = dispatch_queue_create("com.yourapp.imageDownloadQueue", DISPATCH_QUEUE_SERIAL);
}

- (IBAction)openGDTemplateCenter:(id)sender {
    [self saveData];
    [self.sdk openPage:GDImageEditorPageTemplates params:@{}];
}

- (IBAction)openEditor:(id)sender {
    [self saveData];
    NSString *editorMode = [GDDemoUtils editorMode];
    NSString *inputId = [[GDDemoUtils editorMode] isEqualToString:@"user"] ? [GDDemoUtils workId] : [GDDemoUtils templateId];
    [self.sdk openPage:GDImageEditorPageDesign params:@{
        @"id": inputId,
        @"mode": editorMode,
        // @"config_code": @"需要开发者填写", // 有使用后台配置的话，开发者自己填写
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [self saveData];
}

- (IBAction)editorModeChanged:(id)sender {
    if (self.modeSegmenetedControl == sender) {
        switch (self.modeSegmenetedControl.selectedSegmentIndex) {
            case 0:
                [GDDemoUtils setEditorMode:@"template"];
                break;
            case 1:
                [GDDemoUtils setEditorMode:@"user"];
                break;
            default:
                break;
        }
    }
}

// MARK: - GDImageEditorSDKDelegate

- (NSDictionary *)configInfo {
    return @{
        @"forbidFunctionList": @[],
        @"saveBtnName": @"定制按钮",
    };
}

- (void)imageEditor:(GDImageEditorSDK *)editor
          onMessage:(GDImageEditorMessage)message
             params:(NSDictionary *)params
           callback:(void(^)(id result))callback {
    
    // 选择模板回调
    if ([message.type isEqualToString:@"template.select"]) {
        [editor openPage:GDImageEditorPageDesign params:@{
            @"id": params[@"data"][@"id"],
            @"mode": @"template",
            // @"config_code": @"需要开发者填写", // 有使用后台配置的话，开发者自己填写
        }];
        callback(nil);
        return;
    }
    
    // 保存回调
    if ([message.type isEqualToString:@"editor.save.complete"]) {
        
        // 将作图记录 ID 写到 workIDTextField，方便二次编辑
        self.workIDTextField.text = params[@"data"][@"workId"];
        callback(@YES);
        return;
    }
    
    // 出图回调
    if ([message.type isEqualToString:@"editor.export.complete"]) {
        NSString *urlsJsonString = params[@"data"][@"urls"];
        NSArray *ulrs = [GDDemoUtils urlsFromJsonStirng:urlsJsonString];
        [self downloadAndSaveImageUrls:ulrs];
        [self.sdk dissmissAll];
        callback(nil);
        return;
    }
    
    callback(nil);
}

- (NSDictionary *)paramsForFetchAuthCode:(GDImageEditorSDK *)editor {
    return @{
        @"AK": [GDDemoUtils ak],
        @"SK": [GDDemoUtils sk],
        @"uid": [GDDemoUtils uid],
    };
}

// MARK: - Private

- (void)saveData {
    [GDDemoUtils setAK:self.AKTextField.text];
    [GDDemoUtils setSK:self.SKTextField.text];
    [GDDemoUtils setUID:self.UIDTextField.text];
    [GDDemoUtils setTemplateId:self.templateIDTextField.text];
    [GDDemoUtils setWorkId:self.workIDTextField.text];
}

- (void)downloadAndSaveImageUrls:(NSArray<NSString *> *)urls {
    self.resultsTextView.text = @"";
    
    [SVProgressHUD showWithStatus:@"下载中..."];
    self.assetsCount  = urls.count;
    for (NSString *url in urls) {
        if ([url.lastPathComponent containsString:@"gif"] ||
            [url.lastPathComponent containsString:@"mp4"]) {
        self.resultsTextView.text = [self.resultsTextView.text stringByAppendingString:url];
            self.resultsTextView.text = [self.resultsTextView.text stringByAppendingString:@"\n\n"];
            [self decrementCounterAndCheckForAllDone];
        continue;
        }
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        // 创建一个数据任务
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:url]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error) {
                // 处理错误
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self decrementCounterAndCheckForAllDone];
                    [SVProgressHUD showErrorWithStatus:@"下载失败"];
                });
            } else {
                // 将下载的数据转换为UIImage
                UIImage *downloadedImage = [UIImage imageWithData:data];
                
                // 在主线程更新UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 将下载的图片保存到相册
                    UIImageWriteToSavedPhotosAlbum(downloadedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
                    [self decrementCounterAndCheckForAllDone];
                });
            }
        }];
        
        // 启动任务
        [dataTask resume];
    }
}

- (void)decrementCounterAndCheckForAllDone {
    dispatch_async(self.synchronizationQueue, ^{
        self.assetsCount--;
        if (self.assetsCount == 0) {
            // 回到主线程显示完成提示
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"图片已存入相册，视频和 GIF 的 url 放在下方，请复制到浏览器中查看"];
            });
        }
    });
}


- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存图片到相册失败：%@", error.localizedDescription);
    } else {
        NSLog(@"保存图片到相册成功");
    }
}

// MARK: - Custom Accessors

- (GDImageEditorSDK *)sdk {
    if (!_sdk) {
        self.sdk = [[GDImageEditorSDK alloc] init];
        self.sdk.delegate = self;
    }
    return _sdk;
}

@end
