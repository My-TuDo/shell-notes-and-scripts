# 条件判断

[TOC]

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

### 3.1 文件判断

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

上面代码中，`$FILE`要放在双引号之中，这样可以防止`$FILE`为空导致的bug。因为`$FILE`为空，这时`[ -e $FILE ]`就变成了`[ -e ]`，这会被判断为真。而`[ -e "$FILE" ]`则变成`[ -e "" ]`，这会判断为伪。

### 3.2 字符串判断

以下表达式用来判断字符串。

- `[ string ]`：如果`string`不为空（长度大于0），则判断为真。
- `[ -n string ]`：如果字符串`string`的长度大于零，则判断为真。
- `[ -z string ]`：如果字符串`string`的长度为零，则判断为真。
- `[ string1 = string2 ]`：如果`string1`和`string2`相同，则判断为真。
- `[ string1 == string2 ]` 等同于`[ string1 = string2 ]`。
- `[ string1 != string2 ]`：如果`string1`和`string2`不相同，则判断为真。
- `[ string1 '>' string2 ]`：如果按照字典顺序`string1`排列在`string2`之后，则判断为真。
- `[ string1 '<' string2 ]`：如果按照字典顺序`string1`排列在`string2`之前，则判断为真。

注意，`test`命令内部的`>`和`<`，必须用引号引起来（或者是用反斜杠转义）。否则，它们会被 shell 解释为重定向操作符。

示例：
```bash
#!/bin/bash

ANSWER=maybe

if [ -z "$ANSWER" ]; then
    echo "There is np answer." >&2
    exit 1
fi
if [ "$ANSWER" = "yes" ]; then
    echo "The answer is YES."
elif [ "$ANSWER" = "no" ]; then
    echo "The answer is NO."
elif [ "$ANSWER" = "maybe" ]; then
    echo "Then answer is MAYBE."
else
    echo "Then answer is UNKNOWW."
fi
```
[点击前往Shell文件](./Shell/005.sh)

上面代码中，首先判断`$ANSWER`是否为空。若为空，终止脚本，并把退出状态设置为1。这里的`echo`命令把错误信息`There is np answer`重定向为`2(标准错误)`,这是处理错误的常用方法。如果`$ANSWER`不为空，则进行后续判断：是否为`YES`、`NO`还是`MAYBE`。

注意，进行字符串判断时，需要将变量置于双引号下，否则字符串替换变量时，`test`命令可能会报错，提示参数过多。如果不放在双引号之中,比如`[ -n $ANSWER ]`，命令就会变成`[ -n ]`，这是会判断为真。放在双引号之中，命令就会变成`[ -n "" ]`，就会判断为伪。

### 3.3 整数判断

下面的表达式用于判断整数。

- `[ integer1 -eq integer2 ]`：如果`integer1`等于`integer2`，则为`true`。
- `[ integer1 -ne integer2 ]`：如果`integer1`不等于`integer2`，则为`true`。
- `[ integer1 -le integer2 ]`：如果`integer1`小于或等于`integer2`，则为`true`。
- `[ integer1 -lt integer2 ]`：如果`integer1`小于`integer2`，则为`true`。
- `[ integer1 -ge integer2 ]`：如果`integer1`大于或等于`integer2`，则为`true`。
- `[ integer1 -gt integer2 ]`：如果`integer1`大于`integer2`，则为`true`。

例子：
```bash
#!/bin/bash

INT=-5

if [ -z "$INT" ]; then
    echo "INT is empty" >&2
    exit 1
fi
if [ $INT -eq 0 ]; then
    echo "INT is zero."
else
    if [ $INT -lt 0 ]; then
        echo "INT is negative."
    else
        echo "INT is positive."
    fi
    if [ $((INT % 2)) -eq 0 ]; then
        echo "INT is even."
    else 
        echo "INT is odd."
    fi
fi
```