

## 安装

Olla4iOS can be installed using CocaoPods
> pod Olla4iOS


## Olla4iOS 框架使用演示

### 一个列表的配置过程

以制作微信首页为例：




也许你会说，我们的列表哪有这么简单，表急，下面我们看看，一些典型的开发问题，如何通过Olla4iOS框架来处理。

### Static  Header Cells
比如新浪微博首页顶部的广告或者微博“消息”这个列表上最上面3个Cell分别固定是“@我的”，@“评论”，@“赞”，剩下的是chat session 列表。


### 数据model和 UI bind 时还需要转换计算
也就是，model层的定义不满足UI展现需求时。比如：
  
1. model中的数据类型是NSDate而UI展示需要NSString类型  
2. 微信中置顶的chat sessions Cell有特殊的背景色区分


### 定制自己的refreshView

1. 实现自己的CoustomRefreshView, 实现IOllaRefreshView协议方法。
2. 在tableController里面重写：
```
- (class)refreshViewClass{
    return [CoustomRefreshView class];
}
```

### Static TableView
比如微博的“发现”页面 (PS:我专门选择了一个复杂一点的页面)


### 数据变化时UI响应变化

比如：  
1. 微信首页上消息变化时  
2. 点赞  
  

## 接下来

目前Olla4iOS基本上只干了2件事情： 
  
1. 封装了列表的基本逻辑  
2. foundation里面一堆的helper类，也可以独立出来单独使用    
   
我还会继续维护和优化Olla4iOS框架。当然，这些改进和优化都会来自我在实际业务开发中的理解。


>我理解的做一个app的过程

- 第一步：软件结构设计，定义各个模块以及他们之间的调用关系
 例如:model,api(cyber),dao,datasource,views,controllers(集合列表用),viewControllers，util
- 第二步：SB/XIB 搭建所有UI和跳转逻辑
- 第三步：各个模块开发,最起码做到api,dao,datasource单元测试

目前，Olla4iOS框架还比较简单，我本身对软件结构设计的理解还比较浅陋，没准那天我有了新的理解，会重新组织整个业务框架结构。
  
如果你有任何关于结构设计的想法，欢迎与我联系。


## Contact

[@移动开发小冉](http://weibo.com/ranwj)
