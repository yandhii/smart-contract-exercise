// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;
contract EnglishAuction{

    struct Item{
        address owner;
        address itemAddress;
    }

    struct Auction{
        Item item;
        bool activeFlag;
        uint256 startBlock;
        uint256 endBlock;
        uint256 highestBidAmount;
        address highestBidder;
        mapping(address=>uint256) bidFunds;
    }
    
    // address: ipfsHash
    mapping(address => Auction) public auctionStruct;
    event Bid(address bidder, uint256 totalBidAmount, uint256 bidBlock);
    event Finalize(address oldOwner,address newOwner, uint256 finalizedAmount);
    event Withdraw(address bidder, uint256 withdrawAmount);

    modifier notOwner(address _ipfsHash){
        require(msg.sender != auctionStruct[_ipfsHash].item.owner,"Not item owner");
        _;
    }

    modifier notCanceled(address _ipfsHash){
        require(auctionStruct[_ipfsHash].activeFlag,"This auction is canceled");
        _;
    }

    modifier notAfterEnd(address _ipfsHash){
        require(block.number <= auctionStruct[_ipfsHash].endBlock,"This auction is already finished");
        _;
    }

    modifier onlyOwner(address _ipfsHash){
        require(msg.sender == auctionStruct[_ipfsHash].item.owner,"Only owner");
        _;
    }


    modifier noReentrancy(){
        bool lock;
        require(!lock,"No Reentrancy");
        _;
        lock = true;
    }
    /* 
        When u start a bid, input item's IPFS address.
    */
    function setAuction(address _ipfsHash, uint256 _auctionBlockInterval) external onlyOwner(_ipfsHash){
        auctionStruct[_ipfsHash].startBlock = block.number;
        auctionStruct[_ipfsHash].endBlock = auctionStruct[_ipfsHash].startBlock + _auctionBlockInterval;
        auctionStruct[_ipfsHash].activeFlag = true;

        auctionStruct[_ipfsHash].item.itemAddress = _ipfsHash;
    }

    function cancelAuction(address _ipfsHash) external onlyOwner(_ipfsHash) notAfterEnd(_ipfsHash) notCanceled(_ipfsHash){
        auctionStruct[_ipfsHash].activeFlag = false;
    }

    function bid(address _ipfsHash) external payable notOwner(_ipfsHash) notAfterEnd(_ipfsHash) notCanceled(_ipfsHash){
        require(msg.value > 0, "Should transfer more than 0");
        uint256 newBid = auctionStruct[_ipfsHash].bidFunds[msg.sender] + msg.value;
        
        if(newBid <= auctionStruct[_ipfsHash].highestBidAmount){
            revert("Should bid more than highest amount");
        }
        // update auction info
        auctionStruct[_ipfsHash].highestBidAmount = newBid;
        auctionStruct[_ipfsHash].bidFunds[msg.sender] = newBid;
        auctionStruct[_ipfsHash].highestBidder = msg.sender;

        emit Bid(msg.sender, newBid, block.number);
    }

    function finalize(address _ipfsHash) external noReentrancy returns(bool){
        require(auctionStruct[_ipfsHash].highestBidAmount > 0,"Highest bid should > 0");
        require(block.number > auctionStruct[_ipfsHash].endBlock,"This auction has not finished yet");
        address oldOwner = auctionStruct[_ipfsHash].item.owner;
        address newOwner = auctionStruct[_ipfsHash].highestBidder;
        auctionStruct[_ipfsHash].item.owner = newOwner;
        payable(oldOwner).transfer(auctionStruct[_ipfsHash].highestBidAmount);
        emit Finalize(oldOwner, newOwner, auctionStruct[_ipfsHash].highestBidAmount);
        return true;
    }

    function withdraw(address _ipfsHash) external noReentrancy returns(bool){
        if(auctionStruct[_ipfsHash].activeFlag){
            require(block.number > auctionStruct[_ipfsHash].endBlock,"This auction has not finished yet");
        }
        require(auctionStruct[_ipfsHash].bidFunds[msg.sender] > 0, "No balance");
        uint withdrawAmount = auctionStruct[_ipfsHash].bidFunds[msg.sender];
        auctionStruct[_ipfsHash].bidFunds[msg.sender] = 0;
        payable(msg.sender).transfer(withdrawAmount);
        emit Withdraw(msg.sender, withdrawAmount);
        return true;
    }

}
