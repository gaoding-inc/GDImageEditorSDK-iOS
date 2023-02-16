//
//  ViewController.m
//  GDImageEditorSDK-Demo
//
//  Created by 心檠 on 2023/1/9.
//  Copyright © 2023 zmz. All rights reserved.
//

#import "ViewController.h"
#import <GDImageEditorSDK/GDImageEditorSDK.h>

@interface ViewController () <GDImageEditorSDKDelegate>

@end

@implementation ViewController

- (IBAction)useGDTemplateCenter:(id)sender {
    GDImageEditorSDK *sdk = [GDImageEditorSDK new];
    sdk.delegate = self;
    [sdk openPage:GDImageEditorPageTemplates params:@{
        @"thirdCateId": @"80"
    }];
}

- (IBAction)clearCache:(id)sender {
    GDImageEditorSDK *sdk = [GDImageEditorSDK new];
    [sdk clearCache];
}

// MARK: - 鉴权

- (NSDictionary *)paramForFetchAuthCode:(GDImageEditorSDK *)editor {
    return @{
        @"AK": @"8DF7FEF5DFFFACDEF0F287266D0B8B21",
        @"SK": @"50BE03427C039AD53391586BF9D7A907",
    };
}

// MARK: - SDK事件

- (void)imageEditor:(GDImageEditorSDK *)editor onTemplateClick:(NSString *)templateId mode:(NSString *)mode {
    [editor openPage:GDImageEditorPageDesign params:@{
        @"id": templateId,
        @"mode": mode
    }];
}

- (void)imageEditor:(GDImageEditorSDK *)editor onEditCompleted:(NSString *)imageURL workId:(NSString *)workId sourceId:(NSString *)sourceId {
    BOOL useGDCompletePage = YES;
    if (useGDCompletePage) {
        [editor openPage:GDImageEditorPageComplete params:@{
            @"image" : imageURL ?: @"",
            @"workId" : workId ?: @"",
            @"sourceId" : sourceId ?: @"",
        }];
    } else {
        // 不使用稿定作图完成页，自己完成后续下载操作
        NSURLSession *session = [NSURLSession sharedSession];
        // ...
        // ...
    }
}

- (void)imageEditor:(GDImageEditorSDK *)editor onDownloadEditResult:(NSString *)imageURL {
    // 后续下载操作
    NSURLSession *session = [NSURLSession sharedSession];
    // ...
    // ...
}

- (id)imageEditor:(GDImageEditorSDK *)editor onMessage:(GDImageEditorMessage)message {
    if ([message.type isEqualToString:@"xxxx"]) {
        return @"xxxx";
    }
    // ... else ...
    // ... else ...
    return nil;
}

// MARK: - 生命周期

- (void)willEnterImageEditor:(GDImageEditorSDK *)editor {
    // 将要进入SDK
}

- (void)willLeaveImageEditor:(GDImageEditorSDK *)editor {
    // 将要离开SDK
}

@end
