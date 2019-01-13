# fe-deploy
前端简易部署脚本，远程拉取 git 仓库

## 脚本背景
由于自己部署前端代码到服务器的时候，每次都需要自己登陆到服务器，拉取 git 仓库特别麻烦。所以就产生这个简化自己的操作

## 使用方式
自己使用的是nginx，这里假设你会了 nginx。

1、假设你部署的路径/home/wwwroot/xx.com/dist

如下是常见的 nginx 的前端配置

```
	server {
        listen       80;
        server_name active.xxx.cn;

		root /home/wwwroot/xx.com/dist;
		index index.html
    }
```
2、 在/home/wwwroot/xx.com下放置本仓库下的 deloy.sh
3、修改 deploy.sh 里面 codeUrl 为你的仓库地址
4、你git仓库的部署公钥，需要加入你服务器的公钥。
5、在你的代码的 package.json加入以下

```
"scripts": {
    "test": "npm run test",
    "deploy": "ssh [username]@[ip] 'cd /home/wwwroot/xx.com/ && sh deploy.sh'",
    "deploy:master": "ssh [username]@[ip] 'cd /home/wwwroot/trial_fe/ && sh deploy.sh master'"
  },
```

## 使用的原理
使用软链实现无缝切换新旧版本，

## todo
在不影响开发仓库的情况回滚代码






