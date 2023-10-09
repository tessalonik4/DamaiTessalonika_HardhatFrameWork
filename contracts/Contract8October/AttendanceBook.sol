// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./interface/IEmployee.sol";

contract AttendanceBook {
    uint256 public start;
    uint256 public end;
    uint256 public attendanceLength;
    address public employee;

    mapping(address => bool) public isAttend;

    modifier onlyEmployee() {
       require(
        IEmployee(employee).isEmployeeExist(msg.sender),
        'not an employee'
        );
        _;
    }
    constructor(address_employee){
        employee = _employee;
    }
    function attend() external onlyEmployee {
        isAttend(msg.sender) = true;
        attendanceLength += 1;
        
    }
    function attendancePercentage() external view returs(uint256) {
        uint256 totalEmployee = IEmployee(employee).employeeLength();

        return attendanceLength * 100 / totalEmployee;
    }
}