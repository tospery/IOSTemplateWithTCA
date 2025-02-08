### 将模板工程重组名为新工程的步骤
1、打开Podfile，重命名Target，删除Pods、Podfile.lock和IOSTemplate.xcworkspace

2、打开IOSTemplateWithTCA.xcodeproj，依次重命名工程名和主文件夹

3、关闭工程，执行pod install

4、搜索替换IOSTemplateWithTCA和iostemplatewithtca，Build Settings中筛选iostemplatewithtca进行修改，修改R.swift的Build Phases

5、关闭工程，删除Pods、Podfile.lock和*.xcworkspace后重新pod install

6、再次执行第4步，看看有没遗漏

7、编译运行（检测scheme，如有必要删除IOSTemplateWithTCA的scheme）
