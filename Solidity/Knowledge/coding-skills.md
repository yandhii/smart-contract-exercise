# storage变量不能被返回
这是这是因为 storage 中的数据是永久存储在区块链上的，如果直接返回指向 storage 的指针类型变量，那么这个变量可能会被在函数外部被修改，导致函数返回的结果不可预测，这会给合约的安全性带来风险。
```solidity
function doSomething(uint[] storage rags) internal returns(uint[] storage data) {}
```
# 函数调用
## 内部函数调用
当前合约中的函数可以直接（“从内部”）调用，也可以递归调用。  
这些函数调用在EVM内部被转化为简单的跳转。 这样做的效果是，当前的内存不会被清空，也就是说， 将内存引用传递给内部调用的函数是非常有效的。 但只有同一合约实例的函数可以被内部调用。  
**应该避免过度的递归调用**: 因为每个内部函数的调用都会占用至少一个堆栈槽，而可用的堆栈槽只有1024个。
## 外部函数调用: this.func() 和 C.func()
函数可以使用 this.g(8); 和 c.g(2);符号来调用， 其中 c 是一个合约实例， g 是属于 c 的函数。 通过这两种方式调用函数 g 会导致它被 “外部” 调用， 使用消息调用而不是直接通过跳转。   
**注意对 this 的函数调用不能在构造函数中使用，因为实际的合约还没有被创建。**  
其他合约的函数必须被外部调用。**对于一个外部调用， 所有的函数参数都必须被拷贝到内存中**。

备注

从一个合约到另一个合约的函数调用并不创建自己的交易，它是作为整个交易的一部分的消息调用。
### {value: 10, gas: 10000}
当调用其他合约的函数时，可以用特殊的选项 {value: 10, gas: 10000} 指定随调用发送的Wei或气体（gas）数量。 请注意，不鼓励明确指定气体值，因为操作码的气体成本可能在未来发生变化。 您发送给合约的任何Wei都会被添加到该合约的总余额中：
```solidity
contract InfoFeed {
    function info() public payable returns (uint ret) { return 42; }
}

contract Consumer {
    InfoFeed feed;
    function setFeed(InfoFeed addr) public { feed = addr; }
    function callFeed() public { feed.info{value: 10, gas: 800}(); }
}
```
注意 feed.info{value: 10, gas: 800} 只在本地设置 value 和随函数调用发送的 gas 数量， 最后的括号执行实际调用。  
所以 feed.info{value: 10, gas: 800} 不会调用函数， value 和 gas 的设置也会丢失， 只有 feed.info{value: 10, gas: 800}() 执行了函数调用。
