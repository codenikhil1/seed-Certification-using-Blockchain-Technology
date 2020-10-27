pragma solidity >=0.5.0;
import "./storage.sol";
import "./Ownable.sol";

contract seedSupply is Ownable{

    event UserUpdate(address indexed user,string name,string contact,string location,string userType);
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
                            uint _quantity) public onlyOwner returns(address){
          address batchNo = Storage.setBatchDetails(_producerName,_seedType,_quantity);  
          emit BatchAdded(msg.sender,batchNo);
          return batchNo;

    }

    /*get Inspector data */

    function getInspectorData(address _batchNo) public view returns(string memory typeOfSeed,
        string memory fertilizer,
        string memory seedCondition,
        uint quantity){
        
        (typeOfSeed,fertilizer,seedCondition,quantity)  = Storage.getInspectorData(_batchNo);
        return (typeOfSeed,fertilizer,seedCondition,quantity);
    }

    /*update inspector data */

    function setInspectorData(address _batchNo,
                            string memory _typeOfSeed,
                            string memory _fertilizer,
                            string memory _seedCondtion,
                            uint _quantity) public isValidPerformer(_batchNo,'INSPECTOR') returns(bool){
        
        bool status = Storage.setFarmInspector(_batchNo,_typeOfSeed,_fertilizer,_seedCondtion,_quantity);
        emit DoneInspection(msg.sender,_batchNo);
        return status;
    
    }

    /*get Lab Data */

    function getLabData(address _batchNo) public view returns(uint temp,
                        uint germ,
                        uint purification,
                        uint seedMoisture,
                        uint quantity){
        (temp,germ,purification,seedMoisture,quantity) = Storage.getLabData(_batchNo);
        return (temp,germ,purification,seedMoisture,quantity);
    }

    /*set lab data*/

    function setLabData(address _batchNo,
                        uint _temp,
                        uint _germ,
                        uint _purification,
                        uint _seedMoisture,
                        uint _quantity) public isValidPerformer(_batchNo,'LAB') returns(bool){
     bool status = Storage.setLabData(_batchNo,_temp,_germ,_purification,_seedMoisture,_quantity);
     emit DoneLab(msg.sender,_batchNo);
     return status;   
                           
    }

    /*get Distibutor Data */

    function getDistributorData(address _batchNo) public view returns(uint quantity,
                                string memory wareHouseName,
                                string memory transportType,
                                string memory date){

    (quantity,wareHouseName,transportType,date) = Storage.getDistributorData(_batchNo);
    return (quantity,wareHouseName,transportType,date);
    
    }

    /*set dist data */

    function setDistributorData(address _batchNo,
                                uint _quantity,
                                string memory _warehouseName,
                                string memory _transportType,
                                string memory _date) public isValidPerformer(_batchNo,'DISTRIBUTOR') returns(bool){
            bool status = Storage.setDistributorData(_batchNo,_quantity,_warehouseName,_transportType,_date);
            emit DoneDistribution(msg.sender,_batchNo);
            return status;


    }


    /*get user data*/

    function getUser(address _userAddress) public view returns(string memory name,
                    string memory contactNo,
                    string memory location,
                    string memory userType){
        (name,contactNo,location,userType) = Storage.getUser(_userAddress);
        return (name,contactNo,location,userType);
    
    }

    /*set user data */
    function setUser(address _userAddress,
                    string memory _name,
                    string memory _contactNo,
                    string memory _location,
                    string memory _userType) public onlyOwner returns(bool){
        require(_userAddress != address(0));
        bool status = Storage.setUser(_userAddress,_name,_contactNo,_location,_userType);
        emit UserUpdate(_userAddress,_name,_contactNo,_location,_userType);
        return status;

    }

















}