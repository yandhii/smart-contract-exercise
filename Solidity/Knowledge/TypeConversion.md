# Type Conversion in Solidity
## 1. Big-Endian and Small-Endian
### Big-Endian: An order that stores first byte of the binary presentation of data first.
### Small-Endian: An order that stores last byte of the binary presentation of data first.
#### e.g. ```a = 0x12345678```  
Big-Endian: ```12 34 56 78```  
Small-Endian: ```78 56 34 12```
## 2. Bytes data layout in Solidity
### EVM uses 32 bytes words to manipulate the data, it stores all data in Big-Endian format.
h
