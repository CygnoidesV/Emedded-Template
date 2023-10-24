# 测试一级文本 {#test}
[TOC]

## 二级

### 三级

正文

> 测试引用
> 
> 123123

```python
import torch

# 测试注释
device = torch.device("cuda")
print(device)
```

测试latex公式

  The distance between \f$(x_1,y_1)\f$ and \f$(x_2,y_2)\f$ is 
  \f$\sqrt{(x_2-x_1)^2+(y_2-y_1)^2}\f$.

离散期望

\f${E(X)=\sum_{k=1}^\infty {x_k}{p_k}}\f$

**粗体测试**

*斜体测试*

[这是个链接](https://google.com)

<img title="这是个图片" src="image/2023-10-21-21-52-19-image.png" alt="" width="381">

[跳转文档](@ref code_guide_style)

\include example_main.c