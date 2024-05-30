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

/// 默认鉴权 (AK/SK/uid)
/// - uid: 接入方系统内用户唯一标识，稿定系统根据该标识创建关联账号。
/// @param editor 编辑器
- (NSDictionary *)paramsForFetchAuthCode:(GDImageEditorSDK *)editor;

/// 不走默认鉴权，自定义查询授权码
/// @param callback 授权码结果
- (void)fetchAuthCodeWithCallback:(void(^)(NSString *code, NSString *userId, NSError *error))callback;

// MARK: - 数据交互

/// 自定义数据配置
- (NSDictionary *)configInfo;

/// 回调信息
/// - Parameters:
///   - editor: 编辑器
///   - message: 消息内容
///   - params:  参数
///   - callback: 消息处理完毕，调用通知JS
- (void)imageEditor:(GDImageEditorSDK *)editor
          onMessage:(GDImageEditorMessage)message
             params:(NSDictionary *)params
           callback:(void(^)(id _Nullable result))callback;

@end

NS_ASSUME_NONNULL_END
