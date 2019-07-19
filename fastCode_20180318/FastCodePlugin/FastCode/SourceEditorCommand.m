//
//  SourceEditorCommand.m
//  FastCode
//
//  Created by junjie xian on 2018/3/10.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "SourceEditorManager.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    //回调中添加自己的处理
    [[SourceEditorManager sharedInstance] handleInvocation:invocation];    
    
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    completionHandler(nil);
}

@end
