# disable functions

## 函数列表

* `disk_total_space`
* `disk_free_space`
* `diskfreespace`
* `passthru`
* `exec`
* `system`
* `chroot`
* `scandir`
* `chgrp`
* `chown`
* `shell_exec`
* `phpinfo`
* `posix_getcwd`
* `getcwd`

---

* `dir`
* `opendir`
* `readdir`
* `scandir`
* `fopen`
* `unlink`
* `delete`
* `copy`
* `mkdir`
* `rmdir`
* `rename`
* `file`
* `file_get_contents`
* `fputs`
* `fwrite`
* `chgrp`
* `chmod`
* `popen`
* `curl_exec`
* `curl_multi_exec`
* `parse_ini_file`
* `show_source`
* `proc_open`
* `proc_get_status`
* `ini_set`
* `ini_alter`
* `ini_restore`
* `dl`
* `openlog`
* `syslog`
* `readlink`
* `symlink`
* `popepassthru`
* `stream_socket_server`
* `escapeshellcmd`
* `dll`
* `popen`
* `checkdnsrr`
* `checkdnsrr`
* `getservbyname`
* `getservbyport`
* `posix_ctermid`
* `posix_get_last_error`
* `posix_getegid`
* `posix_geteuid`
* `posix_getgid`
* `posix_getgrgid`
* `posix_getgrnam`
* `posix_getgroups`
* `posix_getlogin`
* `posix_getpgid`
* `posix_getpgrp`
* `posix_getpid`
* `posix_getppid`
* `posix_getpwnam`
* `posix_getpwuid`
* `posix_getrlimit`
* `posix_getsid`
* `posix_getuid`
* `posix_isatty`
* `posix_kill`
* `posix_mkfifo`
* `posix_setegid`
* `posix_seteuid`
* `posix_setgid` 
* `posix_setpgid`
* `posix_setsid`
* `posix_setuid`
* `posix_strerror`
* `posix_times`
* `posix_ttyname`
* `posix_uname`

## 函数

### `disk_total_space`

#### 定义

`float disk_total_space ( string $directory )`

返回一个目录的磁盘总大小.

#### 示例

```php
var_dump(disk_total_space("/"));

输出: float(67371577344) 
```

### `disk_free_space` 和 `diskfreespace`

#### 定义

`float disk_free_space ( string $directory )`

返回目录中的可用空间.

#### 示例

```php
var_dump(disk_free_space("/"));

输出: float(58478755840)
```

### `passthru`

#### 定义

`void passthru ( string $command [, int &$return_var ] )`

来执行外部命令`command`的.

当所执行的`Unix`命令输出二进制数据,并且需要**直接传送**到浏览器的时候,需要用此函数来替代`exec()`或`system()`函数.

`CLI`中也会输出命令的执行结果.

#### 参数

* `command`: 要执行的命令.
* `return_var`: 如果提供 return_var 参数， Unix 命令的返回状态会被记录到此参数.

#### 示例

```shell
marmot-sourcecode git:(dev) ✗ cat test.sh
#!/bin/bash
echo 'run from command test.sh';
exit 2;

marmot-sourcecode git:(dev) ✗ ./test.sh
1
marmot-sourcecode git:(dev) ✗ echo $?
2
```

在`php`代码里面写入:

```php
passthru('./test.sh', $err);
echo '<br />';
var_dump($err);

通过浏览器输入地址, 输出脚本的执行结果:

run from command test.sh
int(2)
```

### `exec`

#### 定义

`string exec ( string $command [, array &$output [, int &$return_var ]] )`

`exec()`执行`command`参数所指定的命令.

如果你需要获取未经处理的全部输出数据, 请使用`passthru()`函数.

#### 参数

* `command`: 要执行的命令.
* `output`: 如果提供了该参数, 会用命令执行的输出填充此数组, 每行输出填充数组中的一个元素.数组中的数据不包含行尾的空白字符,例如`\n`字. 如果`output`有数据, 会在数组末尾追加内容. 如果不想追加, 在传入`exec()`函数之前对数组使用`unset()`函数.
* `return_var`: 命令执行后的返回状态会被写入到此变量.

#### 示例

在`php`代码里面写入:

```php
exec('./test.sh', $output, $err);
var_dump($output);
echo '<br />';
var_dump($err);

通过浏览器输入地址, 输出脚本的执行结果:

array(1) { [0]=> string(24) "run from command test.sh" }
int(2)
```

### `system`

#### 定义

`string system ( string $command [, int &$return_var ] )`

同`C`版本的`system()`函数一样, 本函数执行`command`参数所指定的命令,并且输出执行结果.

如果`PHP`运行在服务器模块中,`system()`函数还会尝试在每行输出完毕之后,自动刷新`web`服务器的输出缓存.

#### 参数
 
* `command`: 要执行的命令.
* `return_var`: 则外部命令执行后的返回状态将会被设置到此变量中.

#### 示例

```php
$output = system('./test.sh', $err);
echo '<br />';
var_dump($err);
 
通过浏览器输入地址, 输出脚本的执行结果:
run from command test.sh
int(2)

$output 变量也会保存输出的结果
```

### `chroot`

#### 定义

`bool chroot ( string $directory )`

将当前进程的根目录改变为`directory`.

本函数仅在系统支持且运行于`CLI`,`CGI`或嵌入`SAPI`版本时才能正确工作. 此外本函数还需要`root`权限.

#### 示例

我编译镜像提示该函数未定义.

### `scandir`

#### 定义

列出指定路径中的文件和目录.

`array scandir ( string $directory [, int $sorting_order [, resource $context ]] )`

#### 参数

* `directory`: 要被浏览的目录.
* `sorting_order`: 默认的排序顺序是按字母圣墟排列. 如果使用了可选参数`sorting_order`(设为 1), 则排序顺序是按字母降序排列.
* `context`: 规定目录句柄的环境.`context`是可修改目录流的行为的一套选项.**?我也不清楚**

#### 示例

```php
var_dump(scandir('./'));

运行, 浏览器输出
array(45) {
  [0]=>
  string(1) "."
  [1]=>
  string(2) ".."
  [2]=>
  string(9) ".DS_Store"
  [3]=>
  string(4) ".git"
  [4]=>
  string(10) ".gitignore"
  [5]=>
  string(13) ".test.php.swp"
  [6]=>
  string(11) "Application"
  [7]=>
  string(3) "Cli"
  [8]=>
  string(8) "Core.php"
  [9]=>
  string(14) "Dockerfile.dev"
  [10]=>
  string(4) "Docs"
  [11]=>
  string(12) "EventHandler"
  [12]=>
  string(11) "Jenkinsfile"
  [13]=>
  string(9) "README.md"
  [14]=>
 ...
```

### `chgrp`

#### 定义

改变文件所属的组.

`bool chgrp ( string $filename , mixed $group )`

尝试将文件`filename`所属的组改成`group`.

只有超级用户可以任意修改文件的组,其它用户可能只能将文件的组改成该用户自己所在的组.

#### 参数

* `filename`: 文件的路径.
* `group`: 组的名称或数字.

#### 示例

```shell
创建一个用户
root@cca544d074cd:/var/www/html# useradd tom
root@cca544d074cd:/var/www/html# id tom
uid=1000(tom) gid=1000(tom) groups=1000(tom)

创建一个文件, 属主和属组都是 tom
root@cca544d074cd:/var/www/html# touch tom_file
root@cca544d074cd:/var/www/html# chown tom:tom tom_file
root@cca544d074cd:/var/www/html# ls -l tom_file
-rw-r--r-- 1 tom tom 0 Sep  7 06:16 tom_file
```

`php`运行`chgrp`

```php
chgrp('./tom_file', 'www-data');
```

```shell
发现文件的属组已经被修改了
root@cca544d074cd:/var/www/html# ls -l tom_file
-rw-r--r-- 1 tom www-data 0 Sep  7 06:16 tom_file
```

### `chown`

#### 定义

改变文件的所有者.

`bool chown ( string $filename , mixed $user )`

#### 参数

* `filename`: 文件路径.
* `user`: 用户名或数字.

#### 示例

```shell
root@98bf7ad95cd4:/var/www/html# useradd tom
root@98bf7ad95cd4:/var/www/html# touch tom_file
root@98bf7ad95cd4:/var/www/html# chown tom:tom tom_file
root@98bf7ad95cd4:/var/www/html# ls -l tom_file
-rw-r--r-- 1 tom tom 0 Sep  7 08:15 tom_file
```

`php`运行`chown`

```php
33是www-data用户的uid
chown('./tom_file', 33);
```

```shell
发现文件的属主已经被修改了
root@98bf7ad95cd4:/var/www/html# ls -l tom_file
-rw-r--r-- 1 www-data tom 0 Sep  7 08:15 tom_file
```

### `shell_exec`

#### 定义

通过`shell`环境执行命令, 并且将完整的输出以字符串的方式返回.

`string shell_exec ( string $cmd )`

命令执行的输出. 如果执行过程中发生错误或者进程不产生输出, 则返回`NULL`.

#### 参数

* `cmd`: 要执行的命令

#### 示例

```php
$output = shell_exec('ls -lart');
echo "<pre>$output</pre>";

输出:
total 284
drwxr-xr-x  3 root     root       4096 Oct  1  2016 ..
drwxr-xr-x  8 www-data www-data    272 May 26 09:49 tests
-rw-r--r--  1 www-data www-data   1340 May 26 09:49 phpunit.xml
-rw-r--r--  1 www-data www-data     18 May 26 09:49 phpinfo.php
-rwxr-xr-x  1 www-data www-data    763 May 26 09:49 phpcs.xml
drwxr-xr-x  4 www-data www-data    136 May 26 09:49 deployment
...
```

### `phpinfo`

禁用`phpinfo`函数, 需要查阅配置信息需要运行`php -i`查看.

```shell
root@cca544d074cd:/var/www/html# php -i | grep "expose_php"
expose_php => Off => Off
```

### `getcwd` 和 `posix_getcwd`

#### 定义

取得当前工作目录.

`string getcwd ( void )`

#### 示例

```php
var_dump(getcwd());

输出:
string(13) "/var/www/html" 
```

### `xxx`

#### 定义

#### 参数

#### 示例