//
//  GDImageEditorSDKDelegate.h
//  Pods
//
//  Created by 心檠 on 2021/6/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct GDImageEditorMessage {
    NSString *type;
    id data;
};
typedef struct __attribute__((objc_boxable)) GDImageEditorMessage GDImageEditorMessage;

@class GDImageEditorSDK;

@protocol GDImageEditorSDKDelegate <NSObject>

@optional

// MARK: - 鉴权

/// 默认鉴权
/// @param editor 编辑器
- (NSString *)uidForFetchAuthCode:(GDImageEditorSDK *)editor;

/// 不走默认鉴权，定制化查询授权码
/// @param editor 编辑器
/// @param responseCallback 授权码结果
- (void)imageEditor:(GDImageEditorSDK *)editor fetchAuthCodeWithResponseCallback:(void(^)(NSString *code))responseCallback;

// MARK: - SDK生命周期

/// 将要进入编辑器
/// @param editor 编辑器
- (void)willEnterImageEditor:(GDImageEditorSDK *)editor;

/// 已经进入编辑器
/// @param editor 编辑器
- (void)didEnterImageEditor:(GDImageEditorSDK *)editor;

/// 将要离开编辑器
/// @param editor 编辑器
- (void)willLeaveImageEditor:(GDImageEditorSDK *)editor;

/// 已经离开编辑器
/// @param editor 编辑器
- (void)didLeaveImageEditor:(GDImageEditorSDK *)editor;

// MARK: - SDK事件

/// 模板中心点击模板
/// @param editor 编辑器
/// @param templateId id
- (void)imageEditor:(GDImageEditorSDK *)editor onTemplateClick:(NSString *)templateId mode:(NSString *)mode;

/// 作图完成回调
/// @param editor 编辑器
/// @param imageURL 图片结果地址
/// @param workId 作图记录id
/// @param sourceId 源模板id
- (void)imageEditor:(GDImageEditorSDK *)editor onEditCompleted:(NSString *)imageURL workId:(NSString *)workId
           sourceId:(NSString *)sourceId;

/// 作图完成页点击保存到手机
/// @param editor 编辑器
/// @param imageURL 图片结果地址
- (void)imageEditor:(GDImageEditorSDK *)editor onDownloadEditResult:(NSString *)imageURL;

// MARK: - 通用事件

/// 通用JS消息
/// - Parameters:
///   - editor: 编辑器
///   - message: 消息内容
/// @return 返回给JS处理结果
- (id)imageEditor:(GDImageEditorSDK *)editor onMessage:(GDImageEditorMessage)message;

@end

NS_ASSUME_NONNULL_END
