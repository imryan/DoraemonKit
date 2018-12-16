//
//  Doraemoni18NUtil.m
//  DoraemonKit
//
//  Created by xgb on 2018/11/14.
//

#import "Doraemoni18NUtil.h"

/** 中文(大陆) */
NSString *const DoraemonlanguageZHCN = @"zh-CN";
/** 中文(大陆)简体中文 */
NSString *const DoraemonlanguageZHHansCN = @"zh-Hans-CN";
/** 英语(美国) */
NSString *const DoraemonlanguageENUS = @"en-US";
/** 英语(美国) */
NSString *const DoraemonlanguageENCN = @"en-CN";
/** 中文(香港)*/
NSString *const DoraemonlanguageZHHK = @"zh-HK";

NSDictionary *DoraemonLanguageCode_ISO639CodeMap() {
    return @{
             DoraemonlanguageZHCN : @"zh-Hans",
             DoraemonlanguageZHHansCN : @"zh-Hans",
             DoraemonlanguageZHHK : @"zh-Han",
             DoraemonlanguageENUS : @"en",
             DoraemonlanguageENCN : @"en" };
}

@implementation Doraemoni18NUtil

+ (NSString *)localizedString:(NSString *)key {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    if (language.length == 0) {
        return key;
    }
    
    // Fix language key for English (US) in ISO639 code map
    if ([language isEqualToString: @"en"]) {
        language = @"en-US";
    }
    
    NSString *fileNamePrefix = DoraemonLanguageCode_ISO639CodeMap()[language];
    if (fileNamePrefix.length == 0) {
        if ([language hasPrefix:@"zh-"]) {
            fileNamePrefix = @"zh-Hans";
        } else if ([language hasPrefix:@"en-"]) {
            fileNamePrefix = @"en";
        }
    }
    
    NSBundle *tmp = [NSBundle bundleWithPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.bundle/", @"DoraemonKit"]]];
    NSString *path = [tmp pathForResource: fileNamePrefix ofType: @"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath: path];
    NSString *localizedString = [bundle localizedStringForKey: key value: nil table: @"Doraemon"];
    
    if (!localizedString) {
        localizedString = key;
    }
    
    return localizedString;
}

@end
