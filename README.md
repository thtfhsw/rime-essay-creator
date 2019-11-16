# 一、概述
	参照QQ输入法【分类词库】功能，增加一键打包生成八股文词频库。
	允许用户在网络下载QQ、搜狗、Rime中州韵、百度输入法词库，放到指定目录后，一键打包生成Rime八股文词频库。
	本词库可以使用在Rime的五笔、郑码等方案上，可以极大提升输入准确度。
	QQ输入法允许用户根据所处城市/行业/习惯下载对应的词库来提升输入法的准确度。	
		比如我要出差去城市A，在网上下载对应的城市A的词库后，城市的街道、景点都可以快速输入并显示出来。
	本功能可以降低用户更换输入法时的学习成本，提升用户体验。
------------

# 二、具体说明

## 2.1、需要.net 4.6支持
	本功能使用了.net 4.6，如果是Win7系统，需要自行下载安装。

## 2.2、「深蓝词库转换」工具特别版本
	本功能在建立在深蓝词库转换2.6基础上，本人对自定义格式的字符集功能进行了代码上的改写。
	因此，不要自行升级「深蓝词库转换」工具。

## 2.3、生成八股文词频库的方法如下：
	①分类词库下载完成后，点击运行"\!一键生成八股文词库.cmd"。
		系统会生成的essay.txt文件，并自动复制到Rime输入法的data目录下。
	②请用户重新部署Rime输入法，词库才会生效。
	③请用户手工修改对应输入法的.dict.yaml开启使用八股文，即设置'use_preset_vocabulary : true'。
	④八股文词频库是一个和编码无关的词组库。
		因此可以跨输入法使用，可以使用在Rime的五笔、郑码等方案上，可以极大提升输入准确度。

## 2.4、所有细胞词库都请人工检查
	所有下载的词库都需要人工检查，并确保词库的正确性，本版本的生成程序没有任何检查功能，也不会任何容错处理。
	一个错误的词库，会导致同类的词库都受影响。
	具体方法是：使用"\深蓝词库转换.exe"程序，逐个打开下载的词库。
	然后输出选择【Rime中州韵】，点击转换。转换成功后，还要拉到生成内容的结尾处，确定最后一行不是乱码。
	如果是，说明词库有问题，不能使用。

## 2.5、第一次使用请注意
	如果您是第一次使用这个功能，由于每个使用者所在的城市均不同，请先将'\00-搜狗@所在城市.scel\'下的词库删除。
	然后下载自己所在城市的搜狗细胞词库。
	这个目录单独出来，就是给方便大家删除的。

## 2.6、支持以下输入法的词库：
### 2.6.1 支持搜狗细胞词库
	强烈推荐，制作程序对这类词库的兼容性最好（测试时100%兼容）。
	㈠下载网址：pinyin.sogou.com/dict
	㈡下载的细胞词库放到'\10-搜狗细胞词库.scel\'目录下即可。
### 2.6.2 支持Rime小狼毫字典词库
	对于有特殊需求的Rime词库可以存放在这个目录下，格式请参考这个目录下的已有文件。
### 2.6.3 支持百度输入法词库
	不过百度词库兼容性很差，有20%的失败率。请注意手工检察词库是否正确。
	㈠下载网址：shurufa.baidu.com/dict
	㈡下载的词库放到'\20-百度分类词库.bdict\'目录下即可。
### 2.6.4 支持QQ输入法的分类词库
	不过QQ分类词库有4种格式，需要用户自行分类，针对不同的格式做不同处理，否则会导致生成操作失败。
	非常不推荐使用QQ分类词库，初学者不要尝试。
	㈠下载网址：cdict.qq.pinyin.cn
	㈡早期的QQ词库（2018年以前），扩展名称是'XX.qcel'。
		其实是搜狗细胞词库，将扩展名修改为'.scel'，放到搜狗细胞词库目录下即可。
	㈢下载的QQ词库如果扩展名是'.qpyd'，放到'\30-QQ分类词库.qpyd\'目录下即可。
	㈣2019年的QQ词库使用了新的算法（扩展名称也是'XX.qcel'）。
		转换工具不支持，如果是这类词库，请直接删除。
	㈤还有一种是加密格式的QQ词库，我没有研究，暂时不支持。
