pragma solidity ^0.5.0;

//import "https://github.com/kohshiba/ERC-X/blob/master/contracts/ERCX/Contract/ERCXFull.sol";

contract boxProperty {
    //constructor() ERCXFull("DealerlessRentals", "RENT") public {}
    address public owner;
    uint256 deposit;
    uint256 rent;
    address public tenant;
    string public house;
    struct LeasePeriod {
        uint256 fromTimestamp;
        uint256 toTimestamp;
    }

    enum State {
        Available,
        Created,
        Approved,
        Started,
        Terminated
    }
    State public state;
    LeasePeriod leasePeriod;

    modifier onlyTenant() {
        require(msg.sender != tenant, "Not a Tenant!");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender != owner, "Not an owner!");
        _;
    }

    modifier inState(State _state) {
        require(state == _state, "State is !");
        _;
    }

    constructor(
        address _owner,
        uint256 _rent,
        uint256 _deposit
    ) public {
        owner = _owner;
        rent = _rent;
        deposit = _deposit;
        state = State.Available;
    }

    function isAvailable() public view returns (bool) {
        if (state == State.Available) {
            return true;
        }
        return false;
    }

    function createTenantRightAgreement(
        address _tenant,
        uint256 fromTimestamp,
        uint256 toTimestamp
    ) public inState(State.Available) {
        tenant = _tenant;
        leasePeriod.toTimestamp = toTimestamp;
        leasePeriod.fromTimestamp = fromTimestamp;
        state = State.Created;
    }

    function setStatusApproved() public inState(State.Approved) onlyOwner {
        require(owner != address(0x0), "Property not available for rentals!");
        state = State.Approved;
    }

    function confirmAgreement() public inState(State.Approved) onlyTenant {
        state = State.Started;
    }

    function clearTenant() public {
        tenant = address(0x0);
    }

    function Tenant_address() public view returns (address) {
        return tenant;
    }
}
