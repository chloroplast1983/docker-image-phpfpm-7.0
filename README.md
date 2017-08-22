# docker-image-phpfpm-7.0

---

#### 1.0

基本环境

#### 1.1

升级redis扩展为3.1.2,通过 pecl 安装.

升级mongoDb扩展为1.2.8,通过 pecl 安装

去除 cli 下面的 pthreads 扩展.

#### 1.2

添加`marmot`扩展, 增加内置函数:

* `string marmot_decode(string $data)`: 解密函数
* `string marmot_encode(string $data)`: 加密函数