pragma solidity ^0.4.24;
import "./Ownable.sol";

contract MessageRegistry is Ownable {

    struct Entry {
        address owner;
        string authorName;
        string message;
    }

    Entry[] public entries;

    event NewEntry(uint entryId);
    event EntryModified(uint entryId);

    constructor() public {
        writeMessage("EUROJACKPOT", "Next week winning numbers: 26, 98, 11, 2, 73");
    }

    function writeMessage(string _authorName, string _message) public returns (uint) {
        uint _id = entries.push(Entry(msg.sender, _authorName,_message))-1;
        emit NewEntry(_id);
        return _id;
    }

    function changeMessage(uint _id, string _newMessage) public {
        require(_id <= entries.length, "Entry ID is out of range!");
        require(entries[_id].owner == msg.sender,"It is not your entry, no touchy touchy!");

        entries[_id].message = _newMessage;
        emit EntryModified(_id);
    }

    function readMessage(uint _id) external view returns (string, string) {
        require(_id <= entries.length, "Entry ID is out of range!");

        return (entries[_id].authorName, entries[_id].message);
    }

    function worldDomination() public onlyOwner {
        writeMessage("Adam", "World domination in progress.. Stay tuned!");
    }
}
