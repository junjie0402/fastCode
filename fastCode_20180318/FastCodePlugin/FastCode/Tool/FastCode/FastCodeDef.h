//
//  FastCodeDef.h
//  FastCodePlugin
//
//  Created by junjie xian on 2018/3/11.
//  Copyright © 2018年 junjie xian. All rights reserved.
//

#ifndef FastCodeDef_h
#define FastCodeDef_h

//1、界面相关

//UILabel
#define FastCodeDef_UI_UILabel_Key [@"uilabel" lowercaseString]
#define FastCodeDef_UI_UILabel_Value @"\
UILabel *autoLabel = [[UILabel alloc] init];\n\
autoLabel.text = <#text#>;\n\
autoLabel.textColor = RGB2UICOLOR(<#R#>, <#G#>, <#B#>);\n\
autoLabel.font = [UIFont systemFontOfSize:<#(CGFloat)#>];\n\
autoLabel.backgroundColor = [UIColor clearColor];\n\
[autoLabel sizeToFit];\n\
autoLabel.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);\n\
[<#self.view#> addSubview:autoLabel];\n\
<#self.autoLabel#> = autoLabel;"

//UIButton
#define FastCodeDef_UI_UIButton_Key [@"uibutton" lowercaseString]
#define FastCodeDef_UI_UIButton_Value @"\
UIButton *autoButton = [UIButton buttonWithType:UIButtonTypeCustom];\n\
autoButton.layer.cornerRadius = <#CGFloat#>;\n\
[autoButton setTitle:<#title#> forState:UIControlStateNormal];\n\
autoButton.titleLabel.font = [UIFont systemFontOfSize:<#(CGFloat)#>];\n\
[autoButton setTitleColor:RGB2UICOLOR(<#R#>, <#G#>, <#B#>) forState:UIControlStateNormal];\n\
autoButton.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);\n\
autoButton.backgroundColor = RGB2UICOLOR(<#R#>, <#G#>, <#B#>);\n\
[autoButton addTarget:self action:@selector(<#SEL#>) forControlEvents:UIControlEventTouchUpInside];\n\
[<#self.view#> addSubview:autoButton];\n\
<#self.autoButton#> = autoButton;"

//UIImageView
#define FastCodeDef_UI_UIImageView_Key [@"uiimageview" lowercaseString]
#define FastCodeDef_UI_UIImageView_Value @"\
UIImageView *autoImageView = [[UIImageView alloc] init];\n\
autoImageView.userInteractionEnabled = NO;\n\
autoImageView.layer.cornerRadius = <#CGFloat#>;\n\
autoImageView.image = [UIImage loadImage:<#imagePath#>];\n\
autoImageView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);\n\
[<#self.view#> addSubview:autoImageView];\n\
<#self.autoImageView#> = autoImageView;"

//UITabelView
#define FastCodeDef_UI_UITabelView_Key [@"uitableview" lowercaseString]
#define FastCodeDef_UI_UITabelView_Value @"\
UITabelView *autoTableView = [[UITableView alloc] init];\n\
autoTableView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);\n\
autoTableView.backgroundColor = RGB2UICOLOR(<#R#>, <#G#>, <#B#>);\n\
autoTableView.dataSource = self;\n\
autoTableView.delegate = self;\n\
autoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];\n\
[<#self.view#> addSubview:autoTableView];\n\
<#self.autoTableView#> = autoTableView;"

//UIView
#define FastCodeDef_UI_UIView_Key [@"uiview" lowercaseString]
#define FastCodeDef_UI_UIView_Value @"\
UIView *autoView = [[UIView alloc] init];\n\
autoView.backgroundColor = RGB2UICOLOR(<#R#>, <#G#>, <#B#>)\n\
autoView.frame = CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>);\n\
[<#self.view#> addSubview:autoView];"

//2、Property
//2.1界面类Property
#define FastCodeDef_Property_UILabel_Key [@"pl" lowercaseString]
#define FastCodeDef_Property_UILabel_Value @"@property (nonatomic, strong) UILabel *"

#define FastCodeDef_Property_UIButton_Key [@"pb" lowercaseString]
#define FastCodeDef_Property_UIButton_Value @"@property (nonatomic, strong) UIButton *"

#define FastCodeDef_Property_UIImageView_Key [@"pi" lowercaseString]
#define FastCodeDef_Property_UIImageView_Value @"@property (nonatomic, strong) UIImageView *"

#define FastCodeDef_Property_UITableView_Key [@"pt" lowercaseString]
#define FastCodeDef_Property_UITableView_Value @"@property (nonatomic, strong) UITableView *"

//2.2基本类型Property
#define FastCodeDef_Property_INT64_Key [@"pll" lowercaseString]
#define FastCodeDef_Property_INT64_Value @"@property (nonatomic, assign) INT64 "

#define FastCodeDef_Property_UINT64_Key [@"pull" lowercaseString]
#define FastCodeDef_Property_UINT64_Value @"@property (nonatomic, assign) UINT64 "

#define FastCodeDef_Property_INT32_Key [@"pint" lowercaseString]
#define FastCodeDef_Property_INT32_Value @"@property (nonatomic, assign) INT32 "

#define FastCodeDef_Property_UINT32_Key [@"puint" lowercaseString]
#define FastCodeDef_Property_UINT32_Value @"@property (nonatomic, assign) UINT32 "

//其它
//tableview delegate datasource
#define FastCodeDef_UITableView_DataSource_Key [@"td" lowercaseString]
#define FastCodeDef_UITableView_DataSource_Value @"\
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView\n\
{\n\
    return <#numberOfSections#>;\n\
}\n\
\n\
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section\n\
{\n\
    return <#numberOfRowsInSection#>;\n\
}\n\
\n\
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath\n\
{\n\
    static NSString *cellIdentifier = <#cellIdentifier#>;\n\
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#cellIdentifier#>];\n\
    if (cell == nil) {\n\
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];\n\
    }\n\
    \n\
    return cell;\n\
}\n\
\n\
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath\n\
{\n\
    return;\n\
}\n"

#endif /* FastCodeDef_h */
