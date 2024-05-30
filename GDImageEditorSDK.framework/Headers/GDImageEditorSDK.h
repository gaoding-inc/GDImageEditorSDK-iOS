//
//  GDImageEditorSDK.h
//  GDImageEditorSDK
//
//  Created by 心檠 on 2021/6/16.
//

#import <GDImageEditorSDK/GDImageEditorSDKDelegate.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * GDImageEditorPage;

extern GDImageEditorPage GDImageEditorPageTemplates;    /// 模板中心页
extern GDImageEditorPage GDImageEditorPageDesign;       /// 编辑器页

@interface GDImageEditorSDK : NSObject

/// 代理
@property (nonatomic, weak) id<GDImageEditorSDKDelegate> delegate;

/// 打开页面，同时返回被 present 的控制器
/// - Parameters:
///   - page: 页面关键字
///   - params: 参数
- (UIViewController *)openPage:(GDImageEditorPage)page
                        params:(NSDictionary *_Nullable)params;

/// 关闭当前页面
- (void)dissmiss;

/// 关闭所有页面
- (void)dissmissAll;


@end

NS_ASSUME_NONNULL_END
