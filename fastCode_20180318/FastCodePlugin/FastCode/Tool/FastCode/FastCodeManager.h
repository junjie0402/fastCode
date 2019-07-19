//
//  FastCodeManager.h
//  FastCode
//
//  Created by junjie xian on 2018/3/10.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

@interface FastCodeManager : NSObject

+ (instancetype)sharedInstance;

/*
 * handleInvocation : 目前只会处理没有任何选中态的情况，例如同时选中多个字符或者多行字符，这里是不做处理的。
 */
- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
