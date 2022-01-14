pragma solidity ^0.6.0;

Contract PropertyAuction
{
    address public manager;
    address payable public beneficiary;
    address public highestbidder;
    address public highestbid;
    mapping (address=>uint)pending_returns;
    bool public auction_ended;
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
    constructor(address payable _beneficary) public 
    {
        manager=msg.sender;
        beneficiary=_beneficiary;
    }
    //Bid on the auction
    function bid(address payable sender)public payable{
        require(
            msg.value>highestbid,"there is already a higher bid on the property"
        );
        require(! auction_ended, "auctionEnd has already been called.");
    }
    if (highestbid != 0)
     {
            
            pending_returns[highestbidder] += highestbid;
        }
        highestbidder = sender;
        highestbid = msg.value;
        emit HighestBidIncreased(sender, msg.value);
    }
    function withdraw() public returns (bool) {
        uint amount = pending_returns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            pending_returns[msg.sender] = 0;

            if (!msg.sender.send(amount)) {
                // No need to call throw here, just reset the amount owing
                pending_returns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }


}