# springboot-package-example

spring boot 应用多环境打包部署，增量更新、自动化shell脚本

> spring-boot-maven-plugin插件默认构建的可执行 jar 体积比较大。当项目成熟稳定后所有的依赖基本也就不会有变化了。
> 后期迭代维护更新只需要构建出业务相关的代码。然后上传服务器替换相应的 jar 包即可。此方式构建出的 jar 包体积大幅度减小，
> 极大的提高工作效率。同时该方式遵循 spring boot 规范要求，将配置文件外部化放置。可直接修改配置文件重启生效。

工程目录结构

```
springboot-package-example
├── README.md
├── build.sh
├── logs
├── pom.xml
└── src
    ├── assembly
    │   └── assembly.xml
    └── main
        ├── java
        │   └── net
        │       └── ameizi
        │           └── springboot
        │               └── pack
        │                   └── example
        │                       └── SpringPackageExampleApplication.java
        ├── resources
        │   ├── application-dev.yml
        │   ├── application-local.yml
        │   ├── application-prod.yml
        │   ├── application-test.yml
        │   ├── application-uat.yml
        │   ├── application.yml
        │   ├── mapper
        │   ├── static
        │   └── templates
        └── scripts
            └── bootstrap.sh
```

打包构建

```bash
$ springboot-package-example    master !1  ./build.sh test # 测试环境
$ springboot-package-example    master !1  ./build.sh uat # uat环境
$ springboot-package-example    master !1  ./build.sh prod # prod环境
```

最终构建好的文件为 `springboot-package-example-1.0.0-uat.zip`,解压后的目录结构如下所示：

```
drwxr-xr-x amz staff  256 B  Mon May 18 14:57:22 2020  .
drwxr-xr-x amz staff  384 B  Mon May 18 14:57:55 2020  ..
drwxr-xr-x amz staff   96 B  Mon May 18 11:27:02 2020  bin
drwxr-xr-x amz staff  128 B  Mon May 18 14:57:18 2020  config
drwxr-xr-x amz staff  1.3 KB Mon May 18 14:57:20 2020  lib
drwxr-xr-x amz staff   96 B  Mon May 18 14:09:06 2020  logs
.rw-r--r-- amz staff  1.8 KB Mon May 18 14:57:14 2020  README.md
.rwxr-xr-x amz staff 98.9 KB Mon May 18 14:57:22 2020  springboot-package-example-1.0.0.jar
```

目录结构说明：

| bin                                  | 程序运行脚本                                     |
| ------------------------------------ | ------------------------------------------------ |
| config                               | 外部化配置文件                                   |
| lib                                  | 第三方依赖                                       |
| logs                                 | 日志存放文件                                     |
| README.md                            | 使用说明                                         |
| springboot-package-example-1.0.0.jar | 目标应用程序。程序有修改时，只需要替换该文件即可 |

启动应用

```bash
$ springboot-package-example-1.0.0    master !1  ./bin/bootstrap.sh start
$ springboot-package-example-1.0.0    master !1  ./bin/bootstrap.sh stop
```

代码有修改时只需要重新打包后替换`springboot-package-example-1.0.0.jar`即可。

