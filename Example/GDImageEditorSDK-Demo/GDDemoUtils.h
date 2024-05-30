//
//  GDDemoUtils.h
//  GDImageEditorSDK_Example
//
//  Created by JPlay on 2024/5/20.
//  Copyright © 2024 zmz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GDDemoUtils : NSObject

+ (NSArray *)urlsFromJsonStirng:(NSString *)jsonString;

+ (void)setAK:(NSString *)ak;

+ (NSString *)ak;

+ (void)setSK:(NSString *)sk;

+ (NSString *)sk;

+ (void)setUID:(NSString *)uid;

+ (NSString *)uid;

+ (void)setTemplateId:(NSString *)templateId;

+ (NSString *)templateId;

+ (void)setWorkId:(NSString *)workId;

+ (NSString *)workId;

+ (void)setEditorMode:(NSString *)editorMode;

+ (NSString *)editorMode;

@end

NS_ASSUME_NONNULL_END
