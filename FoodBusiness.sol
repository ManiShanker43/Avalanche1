// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FoodBusiness {
    address public owner;
    mapping(address => uint256) public customerPoints;

    event PurchaseMade(address indexed customer, uint256 amount, uint256 pointsEarned);
    event PointsRedeemed(address indexed customer, uint256 pointsRedeemed, uint256 discountApplied);
    event ContractHalted(address indexed owner, uint256 remainingFunds);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function makePurchase(uint256 amount) external {
        require(amount > 0, "Purchase amount must be greater than 0");

        uint256 pointsEarned = amount / 10; // 1 point for every 10 units of purchase
        customerPoints[msg.sender] += pointsEarned;

        emit PurchaseMade(msg.sender, amount, pointsEarned);
    }

    function redeemPoints(uint256 pointsToRedeem) external {
        require(pointsToRedeem > 0, "Points to redeem must be greater than 0");
        require(pointsToRedeem <= customerPoints[msg.sender], "Not enough points to redeem");
        uint256 discountApplied = pointsToRedeem;
        customerPoints[msg.sender] -= pointsToRedeem;

        emit PointsRedeemed(msg.sender, pointsToRedeem, discountApplied);
    }
    function haltContract() external onlyOwner {
        // Add bussiness required  logic before halting the contract
        uint256 remainingFunds = address(this).balance;

        emit ContractHalted(owner, remainingFunds);

     
        revert("Contract halted");
    }

    function assertExample(uint256 x) external pure returns (uint256) {
        // Use of assert to validate a condition
        assert(x > 0);
        return x;
    }
}
