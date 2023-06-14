# storage变量不能被返回
这是这是因为 storage 中的数据是永久存储在区块链上的，如果直接返回指向 storage 的指针类型变量，那么这个变量可能会被在函数外部被修改，导致函数返回的结果不可预测，这会给合约的安全性带来风险。
```solidity
function doSomething(uint[] storage rags) internal returns(uint[] storage data) {}
```
