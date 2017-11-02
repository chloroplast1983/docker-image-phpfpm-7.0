# docker-image-phpfpm-7.0

---

后端微服务`phpfpm`镜像.

## 1.0

基本环境

## 1.1

升级redis扩展为3.1.2,通过 pecl 安装.

升级mongoDb扩展为1.2.8,通过 pecl 安装

去除 cli 下面的 pthreads 扩展.

## 1.2

添加`marmot`扩展, 增加内置函数:

* `string marmot_decode(string $data)`: 解密函数
* `string marmot_encode(string $data)`: 加密函数

## 1.3 

修改`www.conf`配置,增加启动进程数量.

## 1.4

约束mongo(1.2.10),redis(3.1.3)版本号, 添加时区

## 废弃

独立前端服务使用的`phpfpm`镜像, 该镜像只为后端服务配置使用.

创建公共的`core.ini`配置文件.

### 不需要的模块

* `gd`: 图像库
* `sqlite3`
* 不需要`--enable-maintainer-zts` 
* 不需要`session`, `--disable-session`

### 关闭`allow_url_fopen`

* `allow_url_include`: 默认关闭. 允许程序`include()`一个远程的文件(可以是`php`代码).
* `allow_url_fopen`: 可以从远程服务器和网站获取数据. 需要使用`curl`来代替`file_get_contents`函数.

### `upload.ini`

在`Dockerfile`中不创建该文件, 所有内容集中在`core.ini`文件中

### `open_basedir`

`open_basedir`将php所能打开的文件限制在指定的目录树中, 包括文件本身. 当程序要使用例如`fopen()`或`file_get_contents()`打开一个文件时, 这个文件的位置将会被检查.当文件在指定的目录树之外,程序将拒绝打开.

```shell
open_basedir = /var/www/html
#设定上传文件的临时目录,但是我们已经关闭了上传文件 file_uploads, 所以这里设置只是用于安全设置
upload_tmp_dir = /var/www/html/cache/tmp
```

### `file_uploads`

因为后端服务不需要上传文件, 所以`file_uploads`设置为关闭.

### 输出错误日志, 默认禁止输出在浏览器

```shell
#不显示错误信息(不输出到页面或屏幕上)
display_errors = off
#输出所有错误
error_reporting = E_ALL
#记录错误信息(保存到日志文件中)
log_errors = on
```

可以手动在程序里面开启`ini_set('display_errors', on);`

### 禁用函数

[禁用函数列表](./versions/1.3/disableFunctions.md)

这里都是模拟在浏览器里测试, 不是在`CLI`模式下.

### 禁止显示版本信息

`expose_php = Off`
