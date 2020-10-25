pragma solidity >=0.5.0;

contract seedStorage{

    /* 
        producer
        inspector
        lab
    */
    struct basicDetails{
        string seedType;
        uint quantity;
    }
    struct user{
        string name;
        string location;
        string usertype;
    }
    mapping(address => user) userDetails;


    struct producer{
        string name;
        string location;
        string seedtype;
    }
    struct inspector{
        string typeOfSeed;
        string fertilizer;
        string seedCondition;

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

    mapping(address => basicDetails) batchBasicDetails;
    mapping (address=> inspector) batchInspector;
    mapping(address => lab) batchLab;
    mapping(address => distributor) batchDistributor;

    //role mapping
    mapping(address => string) userRole;
    
    //producer producerData;
    user userData;
    inspector inspectordata;
    lab labDats;
    distributor distributorData;

    function setUser(address _userAddress,
                    string memory _name,
                    string memory _location,
                    string memory _userType) public returns(bool){
            userData.name = _name;
            userData.location = _location;
            userData.usertype = _userType;

            userDetails[_userAddress] = userData;
            userRole[_userAddress] = _userType;

    }

    


}
