# Type Conversion in Solidity
## 1. Big-Endian and Small-Endian
### Big-Endian: An order that stores first byte of the binary presentation of data first.
### Small-Endian: An order that stores last byte of the binary presentation of data first.
#### e.g. ```a = 0x12345678```  
Big-Endian: ```12 34 56 78```  
Small-Endian: ```78 56 34 12```
## 2. Bytes data layout in Solidity
### EVM uses 32 bytes words to manipulate the data, it stores all data in Big-Endian format.  
However, differnt data types have differnet storage layout (where the high order bits are placed).
### 2.1 Padding rules
#### Left-padded: for ```intN```/ ```uintN```/ ```address``` and other types.
Right-padded: for ```string```/ ```bytes``` and ```bytesN```.
Actualy, left-padded = right aligned, right-padded = left aligned.
e.g. ```string str = "abcd"``` in Solidity will right padded by EVM to 32 bytes word => ``0x6162636400000000000000000000000000000000000000000000000000000000 ```
