@echo off 
rem 从注册表中获取输入法根目录WeaselRoot
for /f "tokens=1,2,* " %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Rime\Weasel  /v WeaselRoot ^| find /i "WeaselRoot"') do (set WeaselRoot=%%k)

rem 从注册表中获取用户数据目录AppDataPath
for /f "tokens=1,2,* " %%i in ('REG QUERY HKEY_CURRENT_USER\Software\Rime\Weasel  /v RimeUserDir ^| find /i "RimeUserDir"') do (set AppDataPath=%%k)

rem pause
cls

rem 判断是否存在主目录

rem 判断是否存在Rime根目录，如果不存在，就跳到 ErrorNotWeaselRoot
if not exist %WeaselRoot% (goto ErrorNotWeaselRoot)

rem 判断是否存在Rime用户数据目录，如果不存在，就跳到 ErrorNotAppDataPath
if not exist %AppDataPath% (goto ErrorNotAppDataPath)

goto BeginCreate

:ErrorNotWeaselRoot
rem 如果Rime根目录不存在,提示用户
@echo/
@echo ======================================================
@echo ==== 生成八股文库失败！
@echo ==== 不能定位Rime的运行目录！请重新安装Rime输入法！
@echo ==== 
@echo ======================================================
@echo/
exit

:ErrorNotAppDataPath
rem 如果Rime用户数据目录不存在,提示用户
@echo/
@echo ======================================================
@echo ==== 生成八股文库失败！
@echo ==== 不能定位Rime的用户数据目录！请重新安装Rime输入法！
@echo ==== 
@echo ======================================================
@echo/
exit

:BeginCreate
rem 开始生成
cls

rem 系统环境设置，不能出现空格！
rem 搜狗细胞词库.scel
set rime.scel.txt="%Temp%\rime.scel.txt"
rem QQ拼音细胞词库.qpyd
set rime.qpyd.txt="%Temp%\rime.qpyd.txt"
rem 百度分类词库.bdict
set rime.bdict.txt="%Temp%\rime.bdict.txt"
rem Rime词典库.txt
set rime.dict.txt="%Temp%\rime.dict.txt"

set rime.all.txt="%Temp%\essay.all.txt"
rem 默认生成的八股文库是gbk的
set rime.output.txt="%Temp%\essay.gbk.txt"

rem 转换后生成的八股文库是utf8
set rime.output.txt.ut8="%WeaselRoot%\data\essay.txt"

@echo/
@echo ======================================================
@echo ==== 开始八股文库生成，支持以下格式：
@echo ==== 1、搜狗细胞词库.scel格式，请将词库文件放在\10-搜狗细胞词库.scel\目录下。 下载网址：pinyin.sogou.com/dict
@echo ==== 2、百度分类词库.bdict格式，请将词库文件放在\20-百度分类词库.bdict\目录下。 下载网址：shurufa.baidu.com/dict
@echo ==== 3、QQ分类词库.qpyd，请将词库文件放在\30-QQ分类词库.qpyd\目录下。 下载网址：cdict.qq.pinyin.cn。
@echo ==== 4、Rime词组库.txt格式，请将词库文件放在\90-Rime词组库.txt\目录下
@echo ==== 
@echo ==== 5、生成的文件是：%rime.output.txt.ut8%
@echo ======================================================
@echo/


rem pause

rem 转换词库为RIME库
@echo/
@echo 第一步：开始【搜狗细胞词库】处理
@echo/
深蓝词库转换.exe -i:scel ".\10-搜狗细胞词库.scel\*.scel" ".\00-搜狗@所在城市.scel\*.scel" -o:rime %rime.scel.txt%

@echo/
@echo 第二步：开始【百度分类词库】处理
@echo/
深蓝词库转换.exe -i:bdict ".\20-百度分类词库.bdict\*.bdict" -o:rime %rime.bdict.txt% 

@echo/
@echo 第三步：开始【QQ分类词库】处理
@echo/
深蓝词库转换.exe -i:qpyd ".\30-QQ分类词库.qpyd\*.qpyd" -o:rime %rime.qpyd.txt% 

@echo/
@echo 第四步：开始合并处理结果
@echo/
深蓝词库转换.exe -i:rime ".\90-Rime词组库.txt\*.txt" -o:rime %rime.dict.txt% 

rem 设置输出文件格式：汉字	词频
set paramFile="-f:213,	ynyy"
rem 设置输出编码为拼音/Windows
set parmCode="-ct:pinyin -os:windows"

rem 如果原来有输出文件，就删除他，避免
if exist %rime.output.txt.ut8% (del /q %rime.output.txt.ut8%)

rem 合并RIME库，并按照八股文规格生成
@echo/
@echo 第五步：开始输出自定义八股文词库
@echo/
深蓝词库转换.exe "-te:utf-8" -i:rime %rime.scel.txt% %rime.bdict.txt% %rime.qpyd.txt% %rime.dict.txt% -o:self %rime.output.txt.ut8% %paramFile% %parmCode%

rem （过时代码）内码转换，将GBK的八股文转换为UT8内码
rem iconv.exe -f gbk -t utf-8 %rime.output.txt% > %rime.output.txt.ut8%

rem 删除所有的临时文件
del /q %rime.scel.txt% %rime.bdict.txt% %rime.qpyd.txt% %rime.output.txt% 


@echo/
@echo ======================================================
@echo ==== 生成八股文库完毕！合并生成的词频库文件为：%rime.output.txt.ut8%
@echo ==== 
@echo ======================================================
@echo ==== 为了确保您使用的输入法支持八股文词频库，请确保以下操作：
@echo ==== 
@echo ==== 1、打开您的输入法的字典文件"XXX.dict.yaml"，这个文件在%WeaselRoot%\data目录下。以朙月输入法为例，就是luna_pinyin.dict.yaml文件。
@echo ==== 
@echo ==== 2、确保dict.yaml文件的以下配置生效 use_preset_vocabulary: true，没有这个配置，请自行添加
@echo ==== 
@echo ==== 3、八股文词频库和输入法编码无关，理论上支持五笔、郑码、拼音、双拼
@echo ==== 
@echo ======================================================
@echo/


rem 如果第一参数是-o，不用暂定，直接完成
if not "%1"=="-o" (pause) 

:EndCreate
rem 结束
