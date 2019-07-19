//
//  SourceEditorManager.h
//  FastCode
//
//  Created by junjie xian on 2018/3/10.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

@interface SourceEditorManager : NSObject

+ (instancetype)sharedInstance;

//invocation处理的唯一入口
- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
