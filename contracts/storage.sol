pragma solidity >=0.5.0;

contract seedStorage{

    /* 
        producer
        inspector
        lab
    */
    constructor(){
            authorizedCaller[msg.sender] = 1;
    }
    //modifier to see is function caller is authorized
    modifier onlyAuthCaller(){
        require(authorizedCaller[msg.sender] == 1);
        _;
    }
    mapping(address => uint) authorizedCaller;
    struct batchDetails{
        string producerName;
        string seedType;
        uint quantity;

    }
    struct user{
        string name;
        string contactNo;
        string location;
        string usertype;
    }
    mapping(address => user) userDetails;

    struct inspector{
        string typeOfSeed;
        string fertilizer;
        string seedCondition;
        uint quantity;
    }
    struct lab{
            uint temp;
            uint purification;
            uint germ;
            uint seedMoisture;
            uint quantity;
    }
    struct distributor{
            uint quantity;
            string warehouseName;
            string transportType;
            string date;
    }

    mapping(address => batchDetails) batchBasicDetails;
    mapping(address=> inspector) batchInspector;
    mapping(address => lab) batchLab;
    mapping(address => distributor) batchDistributor;
    mapping(address => string) nextAction;

    //role mapping
    mapping(address => string) userRole;
    
    //producer producerData;
    batchDetails BatchDetailsData;
    user userData;
    inspector inspectorData;
    lab labData;
    distributor distributorData;
    /*set user details*/
    function setUser(address _userAddress,
                    string memory _name,
                    string memory _contactNo,
                    string memory _location,
                    string memory _userType) public onlyAuthCaller returns(bool){
            /*store data into struct*/
            userData.name = _name;
            userData.location = _location;
            userData.usertype = _userType;
            userData.contactNo = _contactNo;

            /*store data into mapping*/
            userDetails[_userAddress] = userData;
            userRole[_userAddress] = _userType;
            return true;

    }

    /*get batch details*/

    function getBatchDetails(address _batchNo) public view onlyAuthCaller returns(
        string memory producerName,
        string memory seedType,
        uint quantity) {
                batchDetails memory temp = batchBasicDetails[_batchNo];
                return (temp.producerName,temp.seedType,temp.quantity);
    }

    /*set batch details*/

    function setBatchDetails(string memory _producerName,
                            string memory _seedType,
                            uint _quantity) public onlyAuthCaller returns(address){
        uint tempData = uint (keccak256(abi.encodePacked(_producerName,block.timestamp)));
        address batchNo = address(tempData);

        /*set struct data*/
        BatchDetailsData.producerName = _producerName;
        BatchDetailsData.seedType = _seedType;
        BatchDetailsData.quantity = _quantity;

        /*set mapping*/
        batchBasicDetails[batchNo] = BatchDetailsData;

        /*set next action mapping*/
        nextAction[batchNo] = 'INSPECTOR';

        return batchNo;

                                
    }

    /*set farm inspector*/

    function setFarmInspector(address _batchNo,
                            string memory _typeOfSeed,
                            string memory _fertilizer,
                            string memory _seedCondtion,
                            uint _quantity
                            ) public onlyAuthCaller returns(bool){
            /*set struct*/
            inspectorData.typeOfSeed = _typeOfSeed;
            inspectorData.fertilizer = _fertilizer;
            inspectorData.seedCondition = _seedCondtion;
            inspectorData.quantity = _quantity;
            /*set batch mapping*/
            batchInspector[_batchNo] = inspectorData;

            /*set next action mapping*/
            nextAction[_batchNo] = 'LAB';

            return true;
    }

    /*get inspector data*/

    function getInspectorData(address _batchNo) public view onlyAuthCaller returns(
        string memory typeOfSeed,
        string memory fertilizer,
        string memory seedCondtion,
        uint quantity) {

        inspector memory tempData = batchInspector[_batchNo];

        return(tempData.typeOfSeed,tempData.fertilizer,tempData.seedCondition,tempData.quantity);
    }

    /* set lab data */
        function setLabData(address _batchNo,
                        uint _temp,
                        uint _germ,
                        uint _purification,
                        uint _seedMoisture,
                        uint _quantity) public onlyAuthCaller returns(bool){
        /*set lab struct */
        labData.temp = _temp;
        labData.germ = _germ;
        labData.purification = _purification;
        labData.seedMoisture = _seedMoisture;
        labData.quantity = _quantity;

        /* batch lab mapping*/
        batchLab[_batchNo] = labData;
        nextAction[_batchNo] = 'DIST';
        return(true);
    
    }

    /*get lab data */

    function getLabData(address _batchNo) public view onlyAuthCaller returns(uint _temp,
                        uint germ,
                        uint purification,
                        uint seedMoisture,
                        uint quantity){

         lab memory tempData = batchLab[_batchNo];
         return(tempData.temp,tempData.germ,tempData.purification,tempData.seedMoisture,tempData.quantity);   
    }

    /*set distributor data */

    function  setDistributorData(address _batchNo,
                                uint _quantity,
                                string memory _warehouseName,
                                string memory _transportType,
                                string memory _date)public onlyAuthCaller returns(bool){
       /*put info in distributor struct */
        distributorData.quantity = _quantity;
        distributorData.warehouseName = _warehouseName;
        distributorData.transportType = _transportType;
        distributorData.date = _date;
        
        /*fill mapping */

        batchDistributor[_batchNo] = distributorData;
        nextAction[_batchNo] = 'CONS';
        return (true);
    }
    
    /*get distributor data */

    function getDistributorData(address _batchNo) public view onlyAuthCaller returns(uint quantity,
                                string memory warehouseName,
                                string memory transportType,
                                string memory date){
        distributor memory temp = batchDistributor[_batchNo];

        return (temp.quantity,temp.warehouseName,temp.transportType,temp.date);
    
    
    }


}
