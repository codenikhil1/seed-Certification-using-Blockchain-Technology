pragma solidity >=0.5.0;
pragma experimental ABIEncoderV2;
import "./seedOwner.sol";
contract seed is seedOwner{

    //events
    event UserAdded(address indexed user,string name,string userType);
    event BatchAdded(address indexed user,string  batchNo);
    event DoneCultivation(address indexed user,string  batchNo);
    event DoneProcessing(address indexed user,string  batchNo);
    event DoneLab(address indexed user,string  batchNo);
    event DoneCertification(address indexed user,string  batchNo);
    event DoneDistribution(address indexed user,string  batchNo);


    constructor() public{
        authorizedCaller[msg.sender] = 1;
    }

    modifier onlyAuthCaller(){
        require(authorizedCaller[msg.sender] == 1);
        _;
    }
    modifier isValidPerformer(string memory batchNo,string memory role){
        require(keccak256(abi.encodePacked(getUserRole(msg.sender))) == keccak256(abi.encodePacked(role)));
        require(keccak256(abi.encodePacked(getNextAction(batchNo))) == keccak256(abi.encodePacked(role)));
        _;
    }
    //authorizeCalller Mapping
    mapping(address => uint) authorizedCaller;

    //strcutures
    struct user{
        string name;
        string userType;
    }
    struct BatchDetails{ 
        string batchId;
        string crop;
        string variety;
        uint sourceQuantity;
        string Date;
        string Owner;
        uint plotno;
    }
    struct seedGrower{
        string date;
    }
    struct processor{
        string batchId;
        uint quantity;
        string date;
    }
    struct lab{
        string  batchId;
        string date;
        string result;
    }
    struct certification{
        string batchId;
        string certifacateNo;
        string date;
        uint validity;
    }
    struct distribution{
        string batchId;
        string storeHouse;
        string Date;
    }

    //mappings
    mapping(string => BatchDetails) batchBasicDetails;
    mapping(string =>seedGrower) batchGrower;
    mapping(string => processor) batchProcessor;
    mapping(string => lab) batchLab;
    mapping(string => certification) batchCertification;
    mapping(string => distribution) batchDistribution;
    mapping(string => string) nextAction;
    mapping(address => string) userRole;
    mapping(address =>user) userDetails;
    mapping(string => uint) batchPresent;
    //struct variables
    user userData;
    BatchDetails batchData;
    seedGrower seedGrowerData;
    processor processorData;
    lab labData;
    certification certificationData;
    distribution distributionData;

    //functions

    function getUserRole(address _user) public view returns(string memory){
        return userRole[_user];
    }

    function getNextAction(string memory batchNo) public view returns(string memory){
        return nextAction[batchNo];
    }

    function setUser(address _userAddress,
                    string memory _name,
                    string memory _userType) public onlyAuthCaller onlyOwner returns(bool){
        userData.name = _name;
        userData.userType = _userType;

        userDetails[_userAddress] = userData;
        userRole[_userAddress] = _userType;

        emit UserAdded(_userAddress,_name,_userType);
        return true;             
    }

    function getUser(address _user) public view returns(
        string memory name,
        string memory userType
    ){
        user memory temp = userDetails[_user];
        return(temp.name,temp.userType);
    }

    //seed agency

    function setBatchDetails(string memory _batchId,
        string memory _crop,
        string memory _variety,
        uint _sourceQuantity,
        string memory _Date,
        string memory _Owner,
        uint _plotno) public returns(bool){
    require(keccak256(abi.encodePacked(getUserRole(msg.sender))) == keccak256(abi.encodePacked('SeedProducingAgency')));
    require(batchPresent[_batchId] == 0);

    batchData.batchId = _batchId;
    batchData.crop = _crop;
    batchData.variety = _variety;
    batchData.sourceQuantity = _sourceQuantity;
    batchData.Date = _Date;
    batchData.Owner = _Owner;
    batchData.plotno = _plotno;
    
    batchPresent[_batchId] = 1;
    batchBasicDetails[_batchId] = batchData;

    nextAction[_batchId] = 'SeedGrower';
    emit BatchAdded(msg.sender,_batchId);
    return true;
    }

    function getBatchDetails(string memory _batchId) public view returns(string memory _crop,
        string memory _variety,
        uint _sourceQuantity,
        string memory _Date,
        string memory _Owner,
        uint _plotno){
        BatchDetails memory temp = batchBasicDetails[_batchId];
        return (temp.crop,temp.variety,temp.sourceQuantity,temp.Date,temp.Owner,temp.plotno);

    }

    //seed Grower

    function setSeedGrower(string memory _batchId,string memory _date) public isValidPerformer(_batchId,'SeedGrower') returns(bool){
        seedGrowerData.date = _date;
        batchGrower[_batchId] = seedGrowerData;

        nextAction[_batchId] = 'Processor';

        emit DoneCultivation(msg.sender,_batchId);

        return true;

    }

    function getSeedGrower(string memory _batchId) public view returns(string memory date){
        seedGrower memory temp = batchGrower[_batchId];
        return(temp.date);
    }

    //processor
    function setProcessor( string memory _batchId,
        uint _quantity,
        string memory _date) public isValidPerformer(_batchId,'Processor') returns(bool){
        processorData.batchId = _batchId;
        processorData.quantity = _quantity;
        processorData.date = _date;

        batchProcessor[_batchId] = processorData;

        nextAction[_batchId] = 'Lab';

        emit DoneProcessing(msg.sender,_batchId);
        return true;
    
    }

    function getProcessor(string memory _batchId) public view returns(uint _quantity,
        string memory _date){
            
            processor memory temp = batchProcessor[_batchId];
            return(temp.quantity,temp.date);
    }


    //lab
    function setLab( string memory _batchId,
        string memory _date,
        string memory _result) public isValidPerformer(_batchId,'Lab') returns(bool){
       labData.batchId = _batchId;
       labData.date = _date;
       labData.result = _result;

        batchLab[_batchId] = labData;
        nextAction[_batchId] = 'Certification';
        emit DoneLab(msg.sender,_batchId);
        return(true);

    }

    function getLab(string memory _batchId) public view returns(string memory _date,
        string memory _result){
            lab memory temp = batchLab[_batchId];
            return(temp.date,temp.result);
    }

    //certification egency

    function setCertification(string memory _batchId,
        string memory _certifacateNo,
        string memory _date,
        uint _validity) public isValidPerformer(_batchId,'Certification') returns(bool){
    
    certificationData.batchId = _batchId;
    certificationData.certifacateNo = _certifacateNo;
    certificationData.date = _date;
    certificationData.validity = _validity;

    batchCertification[_batchId] =  certificationData;  
    nextAction[_batchId] = 'Distributor';
    emit DoneCertification(msg.sender,_batchId);
    return true;
    
    }

    function getCertification(string memory _batchId) public view returns(string memory _certifacateNo,
        string memory _date,
        uint _validity){
    
    certification memory temp = batchCertification[_batchId];
    return(temp.certifacateNo,temp.date,temp.validity);
    
    }

    //distributor

    function setDistribution(string memory _batchId,
        string memory _storeHouse,
        string memory _Date) public isValidPerformer(_batchId,'Distributor') returns(bool){

    distributionData.batchId = _batchId;
    distributionData.storeHouse = _storeHouse;
    distributionData.Date = _Date;

    batchDistribution[_batchId]  = distributionData;
    nextAction[_batchId] = 'Consumer';
    emit DoneDistribution(msg.sender,_batchId);
    return true;
    }

    function getDistribution(string memory _batchId) public view returns(string memory _storeHouse,
        string memory _Date){
            distribution memory temp = batchDistribution[_batchId];
            return(temp.storeHouse,temp.Date);
    }

    function consumer(string memory _batchId) public view returns(BatchDetails memory bcon,seedGrower memory scon,
    processor memory spcon,lab memory lcon,certification memory ccon,distribution memory dcon){
        
         BatchDetails memory batchcon = batchBasicDetails[_batchId];
        seedGrower memory seedcon = batchGrower[_batchId];
        processor memory processorcon = batchProcessor[_batchId];
        lab memory labcon = batchLab[_batchId];
        certification memory certificon = batchCertification[_batchId];
        distribution memory distcon = batchDistribution[_batchId];

        return(batchcon,seedcon,processorcon,labcon,certificon,distcon);
    }
    


}