// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract CityChain {
    address public owner;
    string[] public cityHistory;
    mapping(string => bool) public usedCities;

    uint256 public lastMoveTime;
    uint256 public timeout = 1 days;

    event CityAdded(string city, address indexed player);

    constructor() {
        owner = msg.sender;
    }

    function getLastCity() public view returns (string memory) {
        if (cityHistory.length == 0) {
            return "";
        }
        return cityHistory[cityHistory.length - 1];
    }

    function isValidStart(string memory prevCity, string memory newCity) internal pure returns (bool) {
        if (bytes(prevCity).length == 0) return true;

        bytes memory prev = bytes(prevCity);
        bytes memory next = bytes(newCity);

        // skip soft letters at the end: ь, ъ, ы (UTF-8)
        bytes1 lastChar = prev[prev.length - 1];

        // check last valid letter
        while (
            lastChar == bytes1(0x8C) || // Ь
            lastChar == bytes1(0x8A) || // Ъ
            lastChar == bytes1(0x8B)    // Ы
        ) {
            if (prev.length == 1) return true;
            prev = bytes(prevCity);
            lastChar = prev[--prev.length - 1];
        }

        bytes1 firstChar = next[0];
        return (lastChar | 0x20) == (firstChar | 0x20); // ignore case
    }

    function addCity(string memory city) external {
        require(bytes(city).length > 0, "City cannot be empty");
        require(!usedCities[city], "City already used");

        string memory lastCity = getLastCity();
        require(isValidStart(lastCity, city), "City does not start with correct letter");

        usedCities[city] = true;
        cityHistory.push(city);
        lastMoveTime = block.timestamp;

        emit CityAdded(city, msg.sender);
    }

    function resetGame() external {
        require(block.timestamp > lastMoveTime + timeout, "Game is still active");
        delete cityHistory;
        lastMoveTime = block.timestamp;
    }

    function getCityHistory() external view returns (string[] memory) {
        return cityHistory;
    }
}
