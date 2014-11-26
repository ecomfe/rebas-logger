Logger

一个Node层的Log模块，依赖Log4js。
可以按照时间/文件尺寸等方式分割日志文件。

===

## Installation

下载模块
```sh
git clone http://gitlab.baidu.com/saber/logger.git logger
cd logger
git checkout 'develop'
npm install
```
## API

### Methods

#### setConfig(config, options)

设置全局配置
* *config* **{Object|string}** 设置全局配置或配置文件路径
* *options* **{Object=}** 设置其他配置项
    * **{string=}** options.cwd 日志路径 默认为'./logs'

#### getLogger(category, errorLevel)

获得不同类型Logger实例

* *category* **{string=}** log分类 可与配置文件中“appenders.category”对应
* *errorLevel* **{errorLevel=}** 可log的error_level 可与配置文件中“levels”对应

### 配置文件详解

