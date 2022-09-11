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

    receive() external payable {}
    fallback() external payable{}

    constructor() {
        owner = msg.sender;
    }






}