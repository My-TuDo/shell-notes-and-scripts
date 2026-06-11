# 条件判断

## 1. if 结构

```bash
if commands;then
    commands
[elif commands;then
    commands...]
[else 
    commands...]
fi
```
例子：
```test
if test $USER = "foo";then
    echo "Hello foo."
else
    echo "You are not foo."
fi
```
[点击前往Shell文件](./Shell/001.sh)

`if` 关键字后面可以跟任意数量的命令。这时，所有命令都会执行，但是判断真伪的只看最后一个命令，即使前面的命令都失败了，只要最后一个命令返回`0`，就会执行`then`部分。
```bash
if false;true
then
    echo 'hello world.'
fi
```
[点击前往Shell文件](./Shell/002.sh)

`elif`可以存在多个，因为有其他语言基础，不多废话。

## 2. test 命令

`if`结构的判断条件，一般用`test`命令的有三种形式：
```bash
# 写法一：
test expression

# 写法二：
[ expression ]

# 写法三：
[[ expression ]]
```
上面三种写法是等价的，不同的是写法三支持正则判断。

上面的`expression`是一个表达式，式子为真，`test`命令执行成功（返回值为`0`）；表达式为伪，`test`命令执行失败（返回值为`1`）。需要注意的是，第二种和第三种写法的`[`和`]`与内部的表达式之间必须有空格。
```bash
test -f /etc/hosts
echo $?
# 输出为0

[ -f /etc/hosts ]
echo $?
# 输出为0
```
上面两种`test`写法等价，判断`/etc/hosts`文件是否存在。

实际上，`[`字符是`test`命令的一种简写形式，可以看作一个独立的命令，这也解释了为什么它后面要有空格。

下面三种`test`命令的形式，用在`if`结构中，判断一个文件是否存在。
```bash
# 写法一
if  test -e ./02-conditional-statement/notes.md; then
    echo "Found notes.md"
fi

# 写法二
if [ -e ./02-conditional-statement/notes.md ]; then
    echo "Found notes.md"
fi

# 写法三
if [[ -e ./02-conditional-statement/notes.md ]]; then
    echo "Found notes.md"
fi
```
[点击前往Shell文件](./Shell/003-test.sh)

## 3. 判断表达式

`if`关键字后面，跟着一个命令。这个命令可以是`test`命令，也可以是其他命令根据命令的返回值`0`判断表达式成立，否则表达式不成立。因为这些命令主要式为了得到返回值，所以也可以视为表达式。

### 文件判断

以下表达式用来判断文件状态。

- `[ -b file ]`：如果 file 存在并且是一个块（设备）文件，则为`true`。
- `[ -c file ]`：如果 file 存在并且是一个字符（设备）文件，则为`true`。
- `[ -d file ]`：如果 file 存在并且是一个目录，则为`true`。
- `[ -e file ]`：如果 file 存在，则为`true`。
- `[ -f file ]`：如果 file 存在并且是一个普通文件，则为`true`。
- `[ -g file ]`：如果 file 存在并且设置了组 ID，则为`true`。
- `[ -G file ]`：如果 file 存在并且属于有效的组 ID，则为`true`。
- `[ -h file ]`：如果 file 存在并且是符号链接，则为`true`。
- `[ -k file ]`：如果 file 存在并且设置了它的“sticky bit”，则为`true`。
- `[ -L file ]`：如果 file 存在并且是一个符号链接，则为`true`。
- `[ -N file ]`：如果 file 存在并且自上次读取后已被修改，则为`true`。
- `[ -O file ]`：如果 file 存在并且属于有效的用户 ID，则为`true`。
- `[ -p file ]`：如果 file 存在并且是一个命名管道，则为`true`。
- `[ -r file ]`：如果 file 存在并且可读（当前用户有可读权限），则为`true`。
- `[ -s file ]`：如果 file 存在且其长度大于零，则为`true`。
- `[ -S file ]`：如果 file 存在且是一个网络 socket，则为`true`。
- `[ -t fd ]`：如果 fd 是一个文件描述符，并且重定向到终端，则为`true`。 这可以用来判断是否重定向了标准输入／输出／错误。
- `[ -u file ]`：如果 file 存在并且设置了 setuid 位，则为`true`。
- `[ -w file ]`：如果 file 存在并且可写（当前用户拥有可写权限），则为`true`。
- `[ -x file ]`：如果 file 存在并且可执行（有效用户有执行／搜索权限），则为`true`。
- `[ FILE1 -nt FILE2 ]`：如果 FILE1 比 FILE2 的更新时间更近，或者 FILE1 存在而 FILE2 不存在，则为`true`。
- `[ FILE1 -ot FILE2 ]`：如果 FILE1 比 FILE2 的更新时间更旧，或者 FILE2 存在而 FILE1 不存在，则为`true`。
- `[ FILE1 -ef FILE2 ]`：如果 FILE1 和 FILE2 引用相同的设备和 inode 编号，则为`true`。

示例：
```bash
#!/bin/bash

FILE=~/.bashrc

if [ -e "$FILE" ]; then
    if [ -f "$FILE" ]; then
        echo "$FILE is a regular file."
    fi
    if [ -d "$FILE" ]; then
        echo "$FILE is a directory."
    fi
    if [ -r "$FILE" ]; then
        echo "$FILE is readable."
    fi
    if [ -w "$FILE" ]; then
        echo "$FILE is writable."
    fi
    if [ -x "$FILE" ]; then
        echo "$FILE is executable/searchable."
    fi
else
    echo "$FILE does not exist."
    exit 1
fi
```
[点击前往Shell文件](./Shell/004.sh)