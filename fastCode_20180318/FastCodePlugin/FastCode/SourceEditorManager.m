//
//  SourceEditorManager.m
//  FastCode
//
//  Created by junjie xian on 2018/3/10.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import "SourceEditorManager.h"
#import "FastCodeManager.h"

@implementation SourceEditorManager

+(instancetype)sharedInstance
{
    static SourceEditorManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SourceEditorManager new];
    });
    
    return instance;
}

- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation
{
    NSLog(@"identifier=%@", invocation.commandIdentifier); //identifier在插件自身的info.plist中登记
    
    //目前只有快速插入代码的identifier，所以只有一个if分支，对应处理类为FastCodeManager。以后如果需要增加indentifier，则添加新的else if分支和对应处理类即可
    if ([invocation.commandIdentifier isEqualToString:@"FastCodePlugin.FastCode"]) {
        [[FastCodeManager sharedInstance] handleInvocation:invocation];
    }
}

@end
