// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import '@openzeppelin/contracts/access/Ownable.sol';
import './interface/IEmployee.sol';

contract Employee is Ownable, IEmployee {
    struct Detail {
        uint256 employeeIndex;
        string name;
        string position;
    }
    mapping(address => Detail) public employeeDetail;
    address[] public employees;

    function employeeLength() public view override returns (uint256) {
        return employees.length;
    }

    function addEmployee(
        address _employee,
        string calldata _name,
        string calldata _position
    ) external override onlyOwner {}

    function isEmployeeExist(address _employee) public override view returns (bool) {
        if (employeeLength() == 0) return false;

        uint256 index = employeeDetail[_employee].employeeIndex;

        return employees[index] == _employee;
    }
}

function removeEmployee(address _employee) external onlyOwner {
    require(isEmployeeExist(_employee), 'not found');

    uint256 indexToRemove = employeeDetail[_employee].employeeIndex;

    // Detail memory employeeToMove = employeeDetail(employees[employeeLength() -1]);
    address employeeToMove = employees[employeeLength() - 1];

    employees[indexToRemove] = employeeToMove;
    employeeDetail[employeeToMove].employeeIndex = indexToRemove;

    delete employeeDetail[_employee];
    employees.pop();
}
