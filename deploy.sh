#!/bin/bash

# @Author: knowthis
# @Date:   2018-11-05 16:28:03
# @Email:  admin@xbpig.cn
# @Filename: deploy.sh
# @Last modified by:   knowthis
# @Last modified time: 2018-11-08 13:57:47

if [ $1 ];then
    branch=$1
else
    branch='release'
fi
currentPath=$PWD;
currentTime=`date '+%Y%m%d_%H_%M_%S'`
codeUrl=git@xxx.git
codeBase=/
output=build

msg() {
    if [ $2 ];then
        color=$2
    else
        color='33'
    fi
    echo '\033['${color}'m ===> '$1'\033[0m'
}
delDir() {
    if [ -d $currentPath/home ];then
        rm -rf $currentPath/home
    fi
}
createDir() {
    mkdir $currentPath/$currentTime
}
getCode() {
    msg '开始拉取代码'
    msg '代码仓库'$codeUrl
    delDir
    git clone $codeUrl home -b $1 --depth=1;
    createDir
    buildCode
    cp -R $currentPath/home$codeBase/$output/** $currentPath/$currentTime/
    # delDir
    msg '结束拉取代码'
}
buildCode() {
    msg '开始编译代码'
    cd $currentPath/home$codeBase;
    yarn; 
    yarn build;
    cd $currentPath;
    msg '结束编译'
}
deployCode() {
    msg '开始创建软链接'
    # if [ -d $currentPath/dist ];then
    #     mkdir $currentPath/dist
    # fi
    ln  -svfn $currentPath/$currentTime/  dist;
    ls -al
    msg '结束创建软链接'
}

init() {
    msg '开始部署'
    msg '当前路径是'$currentPath
    msg '当前分支是'${branch}
    msg '当前时间是'${currentTime}
    getCode ${branch}
    deployCode
}
init
