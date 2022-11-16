# HealthChartView
健康类型项目，心电图，心率图，睡眠图，血氧，血压，HRV

#### 使用方式

1. 手动导入，直接将项目里面ChartView模块下的文件拖入项目即可

2. cocoapods 导入

   ```ruby
   pod 'HealthChartView', :git => 'https://github.com/YOrange834/HealthChartView.git'
   ```



#### 已经完成的功能：

**心电图，血氧，血压，睡眠图,HRV**

#### 截图

#### ![预览图](https://github.com/YOrange834/HealthChartView/blob/master/res/%E6%9C%AA%E6%A0%87%E9%A2%98-1.jpg)

![睡眠图](https://github.com/YOrange834/HealthChartView/blob/master/res/sleep.png)

#### 实时心电图

更加完善的心电图模块可以移步到这里 https://github.com/YOrange834/YOECGChartView

![实时心电图](https://github.com/YOrange834/HealthChartView/blob/master/res/Untitled.gif)

![测试图片](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1ebb7507a64045a5b15db0b68a0f3462~tplv-k3u1fbpfcp-watermark.image)

#### 主要功能解析

* Base
  * YOBaseChartView  集成了一些画X轴和Y轴的函数，还有处理一些滑动时间
  * Axis 主要配置获取X轴和Y轴的一些坐标参数

* Boold
  * YOBooldPressure 主要用于定义坐标轴，充当画布的功能
  * view 主要用于画图标
