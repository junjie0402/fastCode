//
//  FastCodeManager.m
//  FastCode
//
//  Created by junjie xian on 2018/3/10.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#import "FastCodeManager.h"
#import "FastCodeHelper.h"

@interface FastCodeManager ()

@property (nonatomic, strong) FastCodeHelper *helper;

@end

@implementation FastCodeManager

+(instancetype)sharedInstance
{
    static FastCodeManager *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FastCodeManager new];
        instance.helper = [FastCodeHelper new];
    });
    
    return instance;
}

//研究选中多行或一行的情况
- (void)multiLineDoResearch:(XCSourceEditorCommandInvocation *)invocation
{
    //NSMutableArray *allLinesArray = invocation.buffer.lines;  //文件所有行
    
    XCSourceTextRange *selectedInfo = invocation.buffer.selections.firstObject;   //selections.firstObject包含选中的第一行start和最后一行end的信息
        
    NSInteger startRow = selectedInfo.start.line;            //选中多行的第一行行号，行号从0开始算起
    NSInteger startColumn = selectedInfo.start.column;       //选中多行的第一行的选中内容的第一个字符的列号，列号从0开始算起
    NSLog(@"\n startRow=%ld,\n startColumn=%ld,\n", \
          (long)startRow, (long)startColumn);
    
    NSInteger endRow = selectedInfo.end.line;                //选中多行的最后一行行号
    NSInteger endColumn = selectedInfo.end.column;           //选中多行的最后一行的选中内容的最后一个字符的列号+1   ！！！
    NSLog(@"\n endRow=%ld,\n endColumn=%ld,\n", \
          (long)endRow, (long)endColumn);
    
    //如果只选中一行的一个或多个字符，则endRow=startRow，且endColumn>startColumn。
    //如果没选中任何内容，则endRow=startRow，startRow为准备插入内容的列号！！！且endColumn=startColumn
}

- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation
{
    //以下这行代码只是做实验
    //[self multiLineDoResearch:invocation];

    //1、首先获取需要替换的字符串
    FastCodeStruct *replaceStruct = [self.helper getReplaceSruct:invocation];
    
    //2、获取替换后的字符串，并将串插入文件的所有行中
    [self.helper replaceString:invocation withReplaceStruct:replaceStruct];
}


@end
