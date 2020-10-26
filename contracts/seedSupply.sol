pragma solidity >=0.5.0;
import "./storage.sol";
import "./Ownable.sol";

contract seedSupply is Ownable{

    event BatchAdded(address indexed user,address indexed batchNo);
    event DoneInspection(address indexed user,address indexed batchNo);
    event DoneLab(address indexed user,address indexed batchNo);
    event DoneDistribution(address indexed user,address indexed batchNo);
    
    /*modiefier*/
    modifier isValidPerformer(address batchNo,string memory role){
        require(keccak256(abi.encodePacked(Storage.getUserRole(batchNo))) == keccak256(abi.encodePacked(role)));
        require(keccak256(abi.encodePacked(Storage.getNextAction(batchNo))) == keccak256(abi.encodePacked(role)));
        _;
    }

    seedStorage Storage;

    constructor(address _storageAddress) public{
        Storage = seedStorage(_storageAddress);
    }

    /*Get next Action */
    function getNextAction(address _batchNo) public view returns(string memory action)
    {
       (action) = Storage.getNextAction(_batchNo);
       return (action);
    }

    /*get Basic Details*/

    function getBatchDetails(address _batchNo) public view returns(string memory producerName,
        string memory seedType,
        uint quantity){
            (producerName,seedType,quantity) = Storage.getBatchDetails(_batchNo);
            return (producerName,seedType,quantity);
    }

    function setBatchDetails(string memory _producerName,
                            string memory _seedType,
                            uint _quantity) public returns(address){
          address batchNo = Storage.setBatchDetails(_producerName,_seedType,_quantity);  
          emit BatchAdded(msg.sender,batchNo);
          return true;

    }

    /*get Inspector data */


















}