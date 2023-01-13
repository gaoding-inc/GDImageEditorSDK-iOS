//
//  NSString+GDEncrypt.h
//  GDImageEditorSDK_Example
//
//  Created by 心檠 on 2021/7/19.
//  Copyright © 2021 zmz. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (GDEncrypt)

- (NSString *)hmacBase64ResultWithKey:(NSString *)key usingAlg:(CCHmacAlgorithm)alg;

@end

NS_ASSUME_NONNULL_END
