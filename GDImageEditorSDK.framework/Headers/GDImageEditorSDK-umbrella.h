#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GDImageEditorSDK.h"
#import "GDImageEditorSDKDelegate.h"
#import "SVProgressHUD.h"

FOUNDATION_EXPORT double GDImageEditorSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char GDImageEditorSDKVersionString[];

