rebas-logger
===

一个Node层的Log模块，依赖[Log4js](https://github.com/nomiddlename/log4js-node)。可以按照时间/文件尺寸等方式分割日志文件。

## Installation

下载模块
```sh
git clone https://github.com/ecomfe/rebas-logger.git
cd rebas-logger
git checkout 'master'
npm install
```
## API

默认情况下会使用一个category为_log_的按时间拆分的日志作为输出。

### Methods

#### setConfig(filename)

设置配置文件，以增量添加的方式增加配置项

* *filename* **{string=}** 设置全局配置文件路径


#### getLogger(options)

获得不同类型Logger实例

* *options* **{Object=|string=}** options 如果为string则为errorLevel, 默认category为内置'_log_'
    * *category* **{string=}** log分类 可与配置文件中“appenders.category”对应
    * *errorLevel* **{errorLevel=}** 可log的error_level 可与配置文件中“levels”对应

```javascript
var log = require('rebas-logger');

// 如果无配置文件，则不需要调用
log.setConfig('config.json');

var logger = logger.getLogger();

logger.trace('message...');
logger.debug('message...');
logger.info('message...');
logger.warn('message...');
logger.error('message...');
logger.fatal('message...');
```

#### expressLogger()

通过express.use()加载log模块

```javascript
var express = require('express');
var logger = require('rebas-logger');

app = express();
// 如果无配置文件，则不需要调用
logger.setConfig('config.json');

app.use(logger.expressLogger());
```


### 配置文件详解
JSON格式，基于log4js的配置文件，做了字段扩展。

*JSON不支持注释，如果使用以下JSON，请将注释自行去掉。*

```js
{
  "appenders": [ // 添加日志输出的类型
    {
      "type": "dateFile", // 按日期分割
      "filename": "logA", // 文件名前缀，与pattern组成文件全称
      "pattern": "-yyyy-MM-dd hh.log", // 规则匹配
      "alwaysIncludePattern": true, // 文件名是否包含pattern部分
      "category": "express" // log类型 在getLogger中指定的category
    },
    {
      "type": "console", // 控制台输出
      "layout": {
        "type": "pattern",
        "pattern": "[%d] [%p] %c - %m" // %r - time in toLocaleTimeString format
                                       // %p - log level
                                       // %c - log category
                                       // %h - hostname
                                       // %m - log data
                                       // %% - %
                                       // %n - newline
                                       // %x{<tokenname>} - add dynamic tokens to your log. Tokens are specified in the tokens parameter
                                       // %[ and %] - define a colored bloc
      }
    },
    {
      "type": "file",
      "absolute": true, // 是否使用绝对路径
      "filename": "/absolute/path/to/log_file.log",
      "maxLogSize": 20480, // 文件最大size 超过后分割. 单位：byte
      "category": "absolute-logger"          
    }
  ],

  "levels": { // 配置log级别。key为对应的category，value为可显示的级别
    "[all]": "TRACE",
    "express": "ERROR",
    "app": "TRACE"
  },
  "replaceConsole": true // 替换默认console
  "cwd": "./logs" // 日志文件路径
}
```
