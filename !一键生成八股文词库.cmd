@echo off 
rem ��ע����л�ȡ���뷨��Ŀ¼WeaselRoot
for /f "tokens=1,2,* " %%i in ('REG QUERY HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Rime\Weasel  /v WeaselRoot ^| find /i "WeaselRoot"') do (set WeaselRoot=%%k)

rem ��ע����л�ȡ�û�����Ŀ¼AppDataPath
for /f "tokens=1,2,* " %%i in ('REG QUERY HKEY_CURRENT_USER\Software\Rime\Weasel  /v RimeUserDir ^| find /i "RimeUserDir"') do (set AppDataPath=%%k)

rem pause
cls

rem �ж��Ƿ������Ŀ¼

rem �ж��Ƿ����Rime��Ŀ¼����������ڣ������� ErrorNotWeaselRoot
if not exist %WeaselRoot% (goto ErrorNotWeaselRoot)

rem �ж��Ƿ����Rime�û�����Ŀ¼����������ڣ������� ErrorNotAppDataPath
if not exist %AppDataPath% (goto ErrorNotAppDataPath)

goto BeginCreate

:ErrorNotWeaselRoot
rem ���Rime��Ŀ¼������,��ʾ�û�
@echo/
@echo ======================================================
@echo ==== ���ɰ˹��Ŀ�ʧ�ܣ�
@echo ==== ���ܶ�λRime������Ŀ¼�������°�װRime���뷨��
@echo ==== 
@echo ======================================================
@echo/
exit

:ErrorNotAppDataPath
rem ���Rime�û�����Ŀ¼������,��ʾ�û�
@echo/
@echo ======================================================
@echo ==== ���ɰ˹��Ŀ�ʧ�ܣ�
@echo ==== ���ܶ�λRime���û�����Ŀ¼�������°�װRime���뷨��
@echo ==== 
@echo ======================================================
@echo/
exit

:BeginCreate
rem ��ʼ����
cls

rem ϵͳ�������ã����ܳ��ֿո�
rem �ѹ�ϸ���ʿ�.scel
set rime.scel.txt="%Temp%\rime.scel.txt"
rem QQƴ��ϸ���ʿ�.qpyd
set rime.qpyd.txt="%Temp%\rime.qpyd.txt"
rem �ٶȷ���ʿ�.bdict
set rime.bdict.txt="%Temp%\rime.bdict.txt"
rem Rime�ʵ��.txt
set rime.dict.txt="%Temp%\rime.dict.txt"

set rime.all.txt="%Temp%\essay.all.txt"
rem Ĭ�����ɵİ˹��Ŀ���gbk��
set rime.output.txt="%Temp%\essay.gbk.txt"

rem ת�������ɵİ˹��Ŀ���utf8
set rime.output.txt.ut8="%WeaselRoot%\data\essay.txt"

@echo/
@echo ======================================================
@echo ==== ��ʼ�˹��Ŀ����ɣ�֧�����¸�ʽ��
@echo ==== 1���ѹ�ϸ���ʿ�.scel��ʽ���뽫�ʿ��ļ�����\10-�ѹ�ϸ���ʿ�.scel\Ŀ¼�¡� ������ַ��pinyin.sogou.com/dict
@echo ==== 2���ٶȷ���ʿ�.bdict��ʽ���뽫�ʿ��ļ�����\20-�ٶȷ���ʿ�.bdict\Ŀ¼�¡� ������ַ��shurufa.baidu.com/dict
@echo ==== 3��QQ����ʿ�.qpyd���뽫�ʿ��ļ�����\30-QQ����ʿ�.qpyd\Ŀ¼�¡� ������ַ��cdict.qq.pinyin.cn��
@echo ==== 4��Rime�����.txt��ʽ���뽫�ʿ��ļ�����\90-Rime�����.txt\Ŀ¼��
@echo ==== 
@echo ==== 5�����ɵ��ļ��ǣ�%rime.output.txt.ut8%
@echo ======================================================
@echo/


rem pause

rem ת���ʿ�ΪRIME��
@echo/
@echo ��һ������ʼ���ѹ�ϸ���ʿ⡿����
@echo/
�����ʿ�ת��.exe -i:scel ".\10-�ѹ�ϸ���ʿ�.scel\*.scel" ".\00-�ѹ�@���ڳ���.scel\*.scel" -o:rime %rime.scel.txt%

@echo/
@echo �ڶ�������ʼ���ٶȷ���ʿ⡿����
@echo/
�����ʿ�ת��.exe -i:bdict ".\20-�ٶȷ���ʿ�.bdict\*.bdict" -o:rime %rime.bdict.txt% 

@echo/
@echo ����������ʼ��QQ����ʿ⡿����
@echo/
�����ʿ�ת��.exe -i:qpyd ".\30-QQ����ʿ�.qpyd\*.qpyd" -o:rime %rime.qpyd.txt% 

@echo/
@echo ���Ĳ�����ʼ�ϲ�������
@echo/
�����ʿ�ת��.exe -i:rime ".\90-Rime�����.txt\*.txt" -o:rime %rime.dict.txt% 

rem ��������ļ���ʽ������	��Ƶ
set paramFile="-f:213,	ynyy"
rem �����������Ϊƴ��/Windows
set parmCode="-ct:pinyin -os:windows"

rem ���ԭ��������ļ�����ɾ����������
if exist %rime.output.txt.ut8% (del /q %rime.output.txt.ut8%)

rem �ϲ�RIME�⣬�����հ˹��Ĺ������
@echo/
@echo ���岽����ʼ����Զ���˹��Ĵʿ�
@echo/
�����ʿ�ת��.exe "-te:utf-8" -i:rime %rime.scel.txt% %rime.bdict.txt% %rime.qpyd.txt% %rime.dict.txt% -o:self %rime.output.txt.ut8% %paramFile% %parmCode%

rem ����ʱ���룩����ת������GBK�İ˹���ת��ΪUT8����
rem iconv.exe -f gbk -t utf-8 %rime.output.txt% > %rime.output.txt.ut8%

rem ɾ�����е���ʱ�ļ�
del /q %rime.scel.txt% %rime.bdict.txt% %rime.qpyd.txt% %rime.output.txt% 


@echo/
@echo ======================================================
@echo ==== ���ɰ˹��Ŀ���ϣ��ϲ����ɵĴ�Ƶ���ļ�Ϊ��%rime.output.txt.ut8%
@echo ==== 
@echo ======================================================
@echo ==== Ϊ��ȷ����ʹ�õ����뷨֧�ְ˹��Ĵ�Ƶ�⣬��ȷ�����²�����
@echo ==== 
@echo ==== 1�����������뷨���ֵ��ļ�"XXX.dict.yaml"������ļ���%WeaselRoot%\dataĿ¼�¡��ԖL�����뷨Ϊ��������luna_pinyin.dict.yaml�ļ���
@echo ==== 
@echo ==== 2��ȷ��dict.yaml�ļ�������������Ч use_preset_vocabulary: true��û��������ã����������
@echo ==== 
@echo ==== 3���˹��Ĵ�Ƶ������뷨�����޹أ�������֧����ʡ�֣�롢ƴ����˫ƴ
@echo ==== 
@echo ======================================================
@echo/


rem �����һ������-o�������ݶ���ֱ�����
if not "%1"=="-o" (pause) 

:EndCreate
rem ����
