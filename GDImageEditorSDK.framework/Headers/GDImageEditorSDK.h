//
//  GDImageEditorSDK.h
//  GDImageEditorSDK
//
//  Created by 心檠 on 2021/6/16.
//

#import <GDImageEditorSDK/GDImageEditorSDKDelegate.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *GDImageEditorCompanyMode; /// 海报模板模式（默认）

// 三大页面
typedef NSString * GDImageEditorPage;

extern GDImageEditorPage GDImageEditorPageTemplates;    /// 模板中心页
extern GDImageEditorPage GDImageEditorPageDesign;       /// 编辑器页
extern GDImageEditorPage GDImageEditorPageComplete;     /// 作图完成页

// 完成页回到首页事件 onClose
extern NSString *GDSDKCloseDefault;                     /// 回到sdk外
extern NSString *GDSDKCloseBackToTemplates;             /// 回到模板中心

@interface GDImageEditorSDK : NSObject

/// 代理
@property (nonatomic, weak) id<GDImageEditorSDKDelegate> delegate;

/// 打开页面
/// - Parameters:
///   - page: 页面关键字
///   - params: 所有参数
- (void)openPage:(GDImageEditorPage)page params:(NSDictionary *_Nullable)params;

/// 关闭页面
- (void)dissmiss;

/// 清理缓存（备注：当切换用户后，务必清理缓存）
- (void)clearCache;

/// 编辑器VC
- (UIViewController *)editorViewController;

/// SDK版本
+ (NSString *)version;

/// 渠道id
@property (nonatomic, copy) NSString *thirdCateId DEPRECATED_MSG_ATTRIBUTE("deprecated. Use `openPage:params:` instead.");

/**
 打开稿定提供的模板中心
 */
- (void)openTemplateCenter DEPRECATED_MSG_ATTRIBUTE("deprecated. Use `openPage:params:` instead.");

/**
 打开编辑器页面
 @param id 模板id或workId
 @param mode user或company （workId时值必须为 user。模板时值必须为 company）
 */
- (void)openImageEditorWithId:(NSString *)id
                         mode:(NSString *)mode DEPRECATED_MSG_ATTRIBUTE("deprecated. Use `openPage:params:` instead.");

/**
 打开作图结果页
 @param remoteImageURL 远端图片地址
 @param workId 作图记录id
 @param sourceId 源模板id
 */
- (void)openCompletePage:(NSString *)remoteImageURL
                  workId:(NSString *)workId
                sourceId:(NSString *)sourceId DEPRECATED_MSG_ATTRIBUTE("deprecated. Use `openPage:params:` instead.");

@end

NS_ASSUME_NONNULL_END
