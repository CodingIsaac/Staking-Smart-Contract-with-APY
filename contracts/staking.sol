// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/*S
Create a staking smart contract with the follwoing functions
1. Function that allows deposit of the ether to the contract
2. An only owner function that allowd the owner to get the staked contract balance.
3. A function that allows users to get the balance of their stakings.
4. A function that calculates the apy for stakers.
5. A function that allows users to withdraw there staked contract.
6. A contract that charges 15% if a user decides to withdraw before the due date.

so what do we need to achieve this?
Modifier.
Constructor
State Variables.

*/

contract Stake {
    
    address public owner;
    enum stakingStatus {Open, Closed}
    stakingStatus public State;
    struct StakeInfo {
        uint stakedAmount;
        uint noOfDays;
        uint yearLater;
    }
    mapping(address => StakeInfo ) public balance;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the Owner");
        _;
    }
    modifier depValue() {
        require(msg.value > 0, "Insufficient Deposit");
        _;
    }

    receive() external payable {}
    fallback() external payable{}

    constructor() {
        owner = msg.sender;
    }

    // Custom Errors
    ///Number of Staking Days not Met
    // error numberofDays();

    function stakeTokens(uint _days) public payable depValue {
        require(_days > 0, "You can't Stake for Zero Days");
        State == stakingStatus.Open;
        StakeInfo storage SD = balance[msg.sender];
        SD.stakedAmount += msg.value;
        SD.noOfDays = block.timestamp + (_days * 1 days);
        SD.yearLater = block.timestamp + 365 days;

        

    }

// Function to get staking balance 

function getBalance() view public returns(uint userBalance) {
    userBalance = address(this).balance;

}

// Function to calculate APY
function calculateAPY(uint _noOfDays, uint _year, uint _stakedAmount) private pure returns(uint totalYield) {
    // StakeInfo storage SD = balance[msg.sender];
    uint totalDays = _noOfDays/_year;
    totalYield = totalDays * _stakedAmount;
}

// Function to withdraw tokens

function withdrawTokens() external {
    StakeInfo storage SD = balance[msg.sender];
    // State == block.timestamp + SD.noOfDays;
    require(block.timestamp > SD.noOfDays, "Staking period not reached");
    require(SD.stakedAmount > 0, "No On-going Stake");
    uint calculatedReturns = calculateAPY(SD.noOfDays, SD.stakedAmount, SD.yearLater);

    uint transferableTokens = SD.stakedAmount + calculatedReturns;

    balance[msg.sender].stakedAmount = 0;
    balance[msg.sender].noOfDays = 0;

    payable(msg.sender).transfer(transferableTokens);
    State == stakingStatus.Closed;



}








}