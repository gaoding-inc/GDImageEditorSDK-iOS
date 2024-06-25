//
//  GDDemoUtils.m
//  GDImageEditorSDK_Example
//
//  Created by JPlay on 2024/5/20.
//  Copyright © 2024 zmz. All rights reserved.
//

#import "GDDemoUtils.h"

@implementation GDDemoUtils

+ (NSArray *)urlsFromJsonStirng:(NSString *)jsonString {
    // 将 JSON 字符串转换为 NSData 对象
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    // 反序列化 JSON 数据
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"JSON 反序列化失败: %@", error.localizedDescription);
    } else {
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            return jsonObject;
        }
    }
    
    return @[];
}

+ (void)setAK:(NSString *)ak {
    [self setCustomValue:ak forKey:@"GDImageEditor_ak"];
}

+ (NSString *)ak {
    NSString *ak = [self customValueForKey:@"GDImageEditor_ak"];
    return ak ?: @"";
}

+ (void)setSK:(NSString *)sk {
    [self setCustomValue:sk forKey:@"GDImageEditor_sk"];
}

+ (NSString *)sk {
    NSString *sk = [self customValueForKey:@"GDImageEditor_sk"];
    return sk ?: @"";
}

+ (void)setUID:(NSString *)uid {
    [self setCustomValue:uid forKey:@"GDImageEditor_uid"];
}

+ (NSString *)uid {
    NSString *uid = [self customValueForKey:@"GDImageEditor_uid"];
    return uid ?: @"";
}

+ (void)setTemplateId:(NSString *)templateId {
    [self setCustomValue:templateId forKey:@"GDImageEditor_templateId"];
}

+ (NSString *)templateId {
    NSString *templateId = [self customValueForKey:@"GDImageEditor_templateId"];
    return templateId ?: @"112724";
}

+ (void)setWorkId:(NSString *)workId {
    [self setCustomValue:workId forKey:@"GDImageEditor_workId"];
}

+ (NSString *)workId {
    NSString *workId = [self customValueForKey:@"GDImageEditor_workId"];
    return workId ?: @"0";
}

+ (void)setEditorMode:(NSString *)editorMode {
    [self setCustomValue:editorMode forKey:@"GDImageEditor_editorMode"];
}

+ (NSString *)editorMode {
    NSString *editorMode = [self customValueForKey:@"GDImageEditor_editorMode"];
    return editorMode ?: @"template";
}


// MARK: - Private

+ (void)setCustomValue:(id)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)customValueForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
