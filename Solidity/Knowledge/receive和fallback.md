# fallback: 必须是external，不一定是payable
```fallback() external {}```
如果合约不知道该如何响应发送给它的数据，如调用不存在的函数时，将调用fallback函数。
# receive:必须是external且payable的
```receive() external payable {}```
# 使用场景
当你创建一个receive函数时，是在**接受没有数据的交易的Ether**。

当你创建一个fallback函数时，它通常是**为了处理函数签名错误**。

# 触发场景
                       msg.data是否为空
                       y/               \n
                       /                  \
                    receive是否存在        fallback
                    y/     \n               
                   /         \
               receive       fallback
