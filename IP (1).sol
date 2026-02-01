// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;


/* 
* @title: Subnet Masking
* @author: Tianchan Dong
* @notice: This contract illustrate how IP addresses are distributed and calculated
* @notice: This contract has no sanity checks! Only use numbers provided in constructor
*/ 

contract Masking{

    // Return Variables
    string public Country;
    string public ISP;
    string public Institute;
    string public Device;

    // Maps of IP interpretation
    mapping(uint => string) public Countries;
    mapping(uint => string) public ISPs;
    mapping(uint => string) public Institutions;
    mapping(uint => string) public Devices;

    constructor() {
        Countries[34] = "Botswana";
        Countries[58] = "Egypt";
        Countries[125] = "Brazil";
        Countries[148] = "USA";
        Countries[152] = "France";
        Countries[196] = "Singapore";
        ISPs[20] = "Orange";
        ISPs[47] = "Telkom";
        ISPs[139] = "Vodafone";
        Institutions[89] = "University";
        Institutions[167] = "Government";
        Institutions[236] = "HomeNet";
        Devices[13] = "iOS";
        Devices[124] = "Windows";
        Devices[87] = "Android";
        Devices[179] = "Tesla ECU";
    }

    function IP(string memory input) public {
    bytes memory s = bytes(input);
    require(s.length == 32, "Input must be 32 bits");

    // Convert binary string to uint (32 bits)
    uint ip = 0;
    for (uint i = 0; i < 32; i++) {
        ip = ip << 1;

        if (s[i] == bytes1("1")) {
            ip |= 1;
        } else {
            require(s[i] == bytes1("0"), "Only 0 or 1 allowed");
        }
    }

    // Mask for 8 bits
    uint mask = 0xFF; // 255

    // Extract each segment (last 8 bits = device, etc.)
    uint deviceCode    =  ip        & mask;
    uint instituteCode = (ip >> 8)  & mask;
    uint ispCode       = (ip >> 16) & mask;
    uint countryCode   = (ip >> 24) & mask;

    // Map to labels
    Country   = Countries[countryCode];
    ISP       = ISPs[ispCode];
    Institute = Institutions[instituteCode];
    Device    = Devices[deviceCode];
    }
}