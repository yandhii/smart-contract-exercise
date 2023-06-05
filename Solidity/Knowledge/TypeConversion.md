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

For a string:  ```string str = "abcd"``` in Solidity will right padded by EVM to 32 bytes word => ```0x6162636400000000000000000000000000000000000000000000000000000000 ```  

For a uint: ```uint256 value = 1_633_837_924``` (= 0x61626364 in hex) will left padded by EVM to 32 bytes word =>
```0x0000000000000000000000000000000000000000000000000000000061626364```  

Even the total bytes are same for two variable, they still have different padding method.  
```
// 0x00000000…01
uint8 a = 1;
// 0x01000000….
bytes1 b = 0x01;
```  

### 3. Type conversion in Solidity
#### 3.1 Conversion from uintM to uintN  
smaller to larger (M < N): left-padding M-N bits for uintM
e.g. ```uint64``` to ```uint128```
```
uint16 a = 0x1234;
uint32 b = uint32(a); // b = 0x00001234
```  

larger to smaller (M > N): left-truncating M-N bits for uintM
```uint32``` to ```uint16```
```uint32 a = 0x12345678;
uint16 b = uint16(a); // b = 0x5678
```

left-truncating = do module N for uintM
```uint32 a = 100000;
uint16 public b = uint16(a); //b = a % 65536
uint8 public c = uint8(a); //c = a % 256
```
For a uint32 variable a, we want to convert it to smaller type, so we use the remainder get by % as the converted value.
For uint16/ uint8, maximum value is 2**16-1/ 2**8-1. The upper bound is 2**16, 2**8, respectively.
So why use the upper bound not real maximum value?  
I.e., assume we have ```uint32 a=256```, if we want to convert it to ```uint8```, intuitively we get 0 for uint8 type because uint8's real maximum value is 255.
If we use 255 for modulo operation, eventually we will get a=1 with ```uint8```, which is incorrect. So we need to use upper bound value for modulo.  

### 3.2 Conver from bytesM to bytesN
