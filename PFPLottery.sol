// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

pragma solidity ^0.8.0;








contract NFT is ERC721Enumerable, Ownable {
  using Strings for uint256;
  uint id=1;
  using SafeMath for uint256;
  string baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.05 ether;   
  uint256 public maxMintAmount = 20;
  uint256 public maxMintInMonth=10;
  bool public paused = false;
  bool public revealed = false;
  string public notRevealedUri;
  uint8 public constant Bronze=1;
  uint8 public constant Silver=2;
  uint8 public constant Gold=3;
  uint8 public constant Diamond=4;
  uint8 public constant Simple=0;
  uint8 public constant T1P=1;
  uint8 public constant T2P=2;
  uint8 public constant T3P=3;
  uint8 public constant T4P=4;
  uint8 public constant T5P=5;
  uint8 public constant T6P=6;
  uint8 public constant T7P=7;
  uint256 tokenId=1;
  uint8 public maxheartsForSimpleNft=5;
  uint  public maxheartsForShieldNft=maxheartsForSimpleNft*2;
  uint256 bronzeNoShieldPoints=50;
  uint256 bronzeShieldPoints=60;
  uint256 silverNoShieldPoints=75;
  uint256 silverShieldPoints=80;
  uint256 T1PPoints=50;
  uint256 T2PPoints=50;
  uint256 T3PPoints=60;
  uint256 T4PPoints=60;
  uint256 T5PPoints=75;
  uint256 T6PPoints=75;
  uint256 goldPoints=80;
  uint256 indexOfNftSimple=1;
  uint256 indexOfNftT1P=1;
  uint256 indexOfNftT2P=1;
  uint256 indexOfNftT3P=1;
  uint256 indexOfNftT4P=1;
  uint256 indexOfNftT5P=1;
  uint256 indexOfNftT6P=1;
  uint256 indexOfNftT7P=1;
  uint maxOfT1P=10;
  uint maxOfT2P=10;
  uint maxOfT3P=10;
  uint maxOfT4P=10;
  uint maxOfT5P=10;
  uint maxOfT6P=10;
  uint maxOfT7P=10;
  ERC20 tokenAddress;
  struct Nft{
    uint id;
    uint Type;
    uint level;
    uint256 hearts;
    uint256 points;
    bool Shield;
  }
  event ChargeHearts(uint tokenId);
  event NewBox(address owner);
  event UpLevel(uint tokenId);
  Nft[] public nfts;
  mapping (uint => Nft) public nftPropriety;
  mapping (address =>uint) nuberBoxByOwner;
  address ownerT;

 bytes32 internal keyHash; // identifies which Chainlink oracle to use
    uint internal fee;        // fee to get random number
    uint public randomResult;


  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    string memory _initNotRevealedUri
  ) ERC721(_name, _symbol)  {
    setBaseURI(_initBaseURI);
    setNotRevealedURI(_initNotRevealedUri);
    ownerT=_msgSender();
  }

   function changeMaxLevel(uint256 _maxOfT1P, uint256 _maxOfT2P,uint256 _maxOfT3P,uint256 _maxOfT4P,uint256 _maxOfT5P,uint256 _maxOfT6P,uint256 _maxOfT7P) public onlyOwner{
      maxOfT1P=_maxOfT1P;
      maxOfT2P=_maxOfT2P;
      maxOfT3P=_maxOfT3P;
      maxOfT4P=_maxOfT4P;
      maxOfT5P=_maxOfT5P;
      maxOfT6P=_maxOfT6P;
      maxOfT7P=_maxOfT7P;
  }

 
   function getNumberOfBoxByOwne(address _owner) public view returns(uint){
     return nuberBoxByOwner[_owner];
   }
  
      function mint() public {
      Nft memory nft ;
      uint idToken;
      uint rendumNumber=random();
      if(rendumNumber>=10){
        uint level;
        bool shieldBool;
        
        uint hearts;
        if(rendumNumber==10){level=Bronze;shieldBool=false;}
        else if(rendumNumber==20){level=Bronze;shieldBool=true;}
        else if(rendumNumber==30){level=Silver;shieldBool=false;}
        else if(rendumNumber==40){level=Silver;shieldBool=true;}
        else if(rendumNumber==50){level=Gold;shieldBool=true;}
        else if(rendumNumber==60){level=Diamond;shieldBool=true;}
        shieldBool?hearts=maxheartsForShieldNft:hearts=maxheartsForSimpleNft;
        idToken=generateDna(indexOfNftSimple,Simple);
        indexOfNftSimple++;
        nft = Nft(idToken,Simple,level,hearts,0,shieldBool);

      }
      else if(rendumNumber==1){
        idToken=generateDna(indexOfNftT1P,T1P);
        indexOfNftT1P++;
        nft = Nft(idToken,T1P,Bronze,10,0,true);
      }
      else if(rendumNumber==2){
        idToken=generateDna(indexOfNftT2P,T2P);
        indexOfNftT2P++;
        nft = Nft(idToken,T2P,Bronze,10,0,true);
      }
      else if(rendumNumber==3){
        idToken=generateDna(indexOfNftT3P,T3P);
        indexOfNftT3P++;
        nft = Nft(idToken,T3P,Silver,10,0,true);
       
      }
      else if(rendumNumber==4){
        idToken=generateDna(indexOfNftT4P,T4P);
        indexOfNftT4P++;
        nft = Nft(idToken,T4P,Silver,10,0,true);
      }
      else if(rendumNumber==5){
        idToken=generateDna(indexOfNftT5P,T5P);
        indexOfNftT5P++;
        nft = Nft(idToken,T5P,Gold,10,0,true);

      }
       else if(rendumNumber==6){
        idToken=generateDna(indexOfNftT6P,T6P);
        indexOfNftT6P++;
        nft = Nft(idToken,T6P,Gold,10,0,true);

      } 
       else if(rendumNumber==7){
        idToken=generateDna(indexOfNftT7P,T7P);
        indexOfNftT7P++;
        nft = Nft(idToken,T7P,Diamond,10,0,true);

      } 
     
         nfts.push(nft);
         _mint(_msgSender(),idToken);
      
  }


  
  function numberNftByLevel(uint256 _level) public view returns(uint256){
      uint256 numberByLevel=0;
      for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
      if(nfts[indexOfArrayNfts].level==_level)
       numberByLevel++;
       return numberByLevel;
  }


  // thid function for fill nft hearts 
  function chargeHearts(uint _tokenId) public payable {
    require(ownerOf(_tokenId)==_msgSender(),"your are not owner of this nft");
    require(getNftById(_tokenId).hearts==0,"You still have hearts");
    uint NumberOfHearts=0;
    getNftById(_tokenId).Shield?NumberOfHearts=maxheartsForShieldNft:NumberOfHearts=maxheartsForSimpleNft;
    Nft memory newNft=Nft(getNftById(_tokenId).id,getNftById(_tokenId).Type,getNftById(_tokenId).level,NumberOfHearts,getNftById(_tokenId).points,getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
    emit ChargeHearts(_tokenId);
  }
  function UpdateShieled(uint _tokenId) public {
    for(uint indexfNft=0;indexfNft<nfts.length;indexfNft++)
      if(nfts[indexfNft].id==_tokenId)
      nfts[indexfNft].Shield=!nfts[indexfNft].Shield;
  }
  function incrementPoints(uint _tokenId) external{
    Nft memory newNft=Nft(getNftById(_tokenId).id,getNftById(_tokenId).Type,getNftById(_tokenId).level,getNftById(_tokenId).hearts,getNftById(_tokenId).points.add(1),getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
  }
  function decrementHearts(uint _tokenId) external {
    Nft memory newNft=Nft(getNftById(_tokenId).id,getNftById(_tokenId).Type,getNftById(_tokenId).level,getNftById(_tokenId).hearts.sub(1),getNftById(_tokenId).points,getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
  }


  function chargePoints(uint _tokenId) public {
    Nft memory newNft=Nft(getNftById(_tokenId).id,2,getNftById(_tokenId).level,10,100,getNftById(_tokenId).Shield);
    updateNft(_tokenId,newNft);
    emit ChargeHearts(_tokenId);
  }

  function updateNft(uint _tokenId,Nft memory _newNft) public {
     for(uint indexfNft=0;indexfNft<nfts.length;indexfNft++)
      if(nfts[indexfNft].id==_tokenId){
        nfts[indexfNft].id=_newNft.id;
        nfts[indexfNft].Type=_newNft.Type;
        nfts[indexfNft].level=_newNft.level;
        nfts[indexfNft].hearts=_newNft.hearts;
        nfts[indexfNft].points=_newNft.points;
        nfts[indexfNft].Shield=_newNft.Shield;
      }
  }
  
  function getNftById(uint256 _tokenId) public view returns(Nft memory nft){
    for(uint indexOfArrayNfts=0;indexOfArrayNfts<nfts.length;indexOfArrayNfts++)
    if(nfts[indexOfArrayNfts].id==_tokenId)
    nft= nfts[indexOfArrayNfts];
  }


  function upgradeNft(uint256 _tokenId) public {
    uint256 level=getNftById(_tokenId).level;
    uint256 points=getNftById(_tokenId).points;
    bool shield=getNftById(_tokenId).Shield;
    uint hearts=getNftById(_tokenId).hearts;
    require(level<Diamond,"this is super level");
    require(ownerOf(_tokenId)==_msgSender(),"your are not owner of this nft");

    if(getTypeNftByTokenId(_tokenId)==Simple){
        if(level==Bronze &&  shield==false){
          require(points>=bronzeNoShieldPoints,"your points not1 ------- for this transaction");
          updateNft(_tokenId,Nft(getNftById(_tokenId).id,Simple,level,hearts.mul(2),0,true));
        }
        else if(level==Bronze  && shield==true){
          require(points>=bronzeShieldPoints,"your points not2 ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,Simple,Silver,hearts.div(2),0,false);
          updateNft(_tokenId,newNft);
        }
        else if(level>=Silver  && shield==false){
          require(points>=silverNoShieldPoints,"your points not3 ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,Simple,level,hearts.mul(2),0,true);
          updateNft(_tokenId,newNft);
        }
        else if(level<=Silver  && shield==true){
          require(points>=1,"your points not4 ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,Simple,Gold,hearts,0,true);
          updateNft(_tokenId,newNft);
        }
        else if(level==Gold  && shield==true){
          require(points>=silverShieldPoints,"your points not ------- for this transaction");
          Nft memory newNft=Nft(getNftById(_tokenId).id,Simple,Diamond,hearts,0,true);
          updateNft(_tokenId,newNft);
        }
    }
    else if(getTypeNftByTokenId(_tokenId)==T1P){
      require(indexOfNftT2P<=maxOfT1P,"There is nothing left in the next level");
      require(points>=T1PPoints,"your points not ------- for this transaction");
      transferFrom(_msgSender(),ownerT,_tokenId);
      uint idToken=generateDna(indexOfNftT2P,T2P);
      indexOfNftT2P++;
      nfts.push(Nft(idToken,T2P,Bronze,hearts,0,true));
      _safeMint(_msgSender(),idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T2P){
      require(indexOfNftT3P<=maxOfT3P,"There is nothing left in the next level");
      require(points>=T2PPoints,"your points not ------- for this transaction");
      transferFrom(_msgSender(),ownerT,_tokenId);
      uint idToken=generateDna(indexOfNftT3P,T3P);
      indexOfNftT3P++;
      nfts.push(Nft(idToken,T3P,Silver,hearts,0,true));
      _safeMint(_msgSender(),idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T3P){
      require(indexOfNftT4P<=maxOfT4P,"There is nothing left in the next level");
      require(points>=T3PPoints,"your points not ------- for this transaction");
      transferFrom(_msgSender(),ownerT,_tokenId);
      uint idToken=generateDna(indexOfNftT4P,T4P);
      indexOfNftT4P++;
      nfts.push(Nft(idToken,T4P,Silver,hearts,0,true));
      _safeMint(_msgSender(),idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T4P){
      require(indexOfNftT5P<=maxOfT5P,"There is nothing left in the next level");
      require(points>=T4PPoints,"your points not ------- for this transaction");
        transferFrom(_msgSender(),ownerT,_tokenId);
        uint idToken=generateDna(indexOfNftT5P,T5P);
        indexOfNftT5P++;
        nfts.push(Nft(idToken,T5P,Gold,hearts,0,true));
        _safeMint(_msgSender(),idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T5P){
      require(indexOfNftT6P<=maxOfT6P,"There is nothing left in the next level");
      require(points>=T5PPoints,"your points not ------- for this transaction");
        transferFrom(_msgSender(),ownerT,_tokenId);
        uint idToken=generateDna(indexOfNftT6P,T6P);
        indexOfNftT6P++;
        nfts.push(Nft(idToken,T6P,Gold,hearts,0,true));
        _safeMint(_msgSender(),idToken);
    }
    else if(getTypeNftByTokenId(_tokenId)==T6P){
      require(indexOfNftT7P<=maxOfT7P,"There is nothing left in the next level");
      require(points>=T6PPoints,"your points not ------- for this transaction");
        transferFrom(_msgSender(),ownerT,_tokenId);
        uint idToken=generateDna(indexOfNftT7P,T7P);
        indexOfNftT7P++;
        nfts.push(Nft(idToken,T7P,Diamond,hearts,0,true));
        _safeMint(_msgSender(),idToken);
    }
    emit UpLevel(_tokenId);
  }

   function _safeTransferFrom(
        ERC20 token,
        address sender,
        address recipient,
        uint amount
    ) private {
        require(sender != address(0),"address of sender Incorrect ");
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Token transfer failed");
    }
    function random() public view returns(uint ){
      uint rendumNumber = uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,  
      _msgSender()))).mod(10001);
      uint returnNuber;
      if(rendumNumber>=0 && rendumNumber<=1750){returnNuber= 10;}
      else if(rendumNumber>1750 && rendumNumber<=3500)returnNuber=20;
      else if(rendumNumber>3500 && rendumNumber<=4200)returnNuber=30;
      else if(rendumNumber>4200 && rendumNumber<=4500)returnNuber=40;
      else if(rendumNumber>4500 && rendumNumber<=4502)returnNuber=50;
      else if(rendumNumber>4503 && rendumNumber<=4503)returnNuber=60;
      else if(rendumNumber>4503 && rendumNumber<=6603)indexOfNftT1P>maxOfT1P?random():returnNuber= 1;
      else if(rendumNumber>6603 && rendumNumber<=8503)indexOfNftT2P>maxOfT2P?random():returnNuber= 2;
      else if(rendumNumber>8503 && rendumNumber<=9303)indexOfNftT3P>maxOfT3P?random():returnNuber= 3;
      else if(rendumNumber>9303 && rendumNumber<=9903)indexOfNftT4P>maxOfT4P?random():returnNuber= 4;
      else if(rendumNumber>9903 && rendumNumber<=9980)indexOfNftT5P>maxOfT5P?random():returnNuber= 5;
      else if(rendumNumber>9980 && rendumNumber<=9990)indexOfNftT6P>maxOfT6P?random():returnNuber= 6;
      else if(rendumNumber>9990 && rendumNumber<=10000)indexOfNftT7P>maxOfT7P?random():returnNuber= 7;
      return returnNuber;
    }

  function generateDna(uint _id,uint _type) public pure returns(uint){
      return st2num(string(abi.encodePacked(num2st(_id),num2st(_type))));
  }

  function st2num(string memory numString) public pure returns(uint) {
        uint  val=0;
        bytes   memory stringBytes = bytes(numString);
        for (uint  i =  0; i<stringBytes.length; i++) {
            uint exp = stringBytes.length - i;
            bytes1 ival = stringBytes[i];
            uint8 uval = uint8(ival);
            uint jval = uval - uint(0x30);
            val +=  (uint(jval) * (10**(exp-1))); 
        }
      return val;
  }

  function num2st(uint256 _uint) public pure returns(string memory){
    return Strings.toString(_uint);
  }
  function getTypeNftByTokenId(uint _tokenId) pure public returns(uint Type) {
    Type=_tokenId%10;
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  function getAllNfts() public view returns(Nft[] memory){
    return nfts;
  }
  
  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 _tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(_tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );
    
    if(revealed == false) {
        return notRevealedUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI,"/",_tokenId.mod(10).toString(),"/", _tokenId.div(10).toString(), baseExtension))
        : "";
  }

  function reveal() public onlyOwner {
      revealed = true;
  }
  
  function setCost(uint256 _newCost) public onlyOwner {
    cost = _newCost;
  }

  function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
    maxMintAmount = _newmaxMintAmount;
  }
  
  function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
    notRevealedUri = _notRevealedURI;
  }

  function setBaseURI(string memory _newBaseURI) public onlyOwner {
    baseURI = _newBaseURI;
  }
  function getBaseURI() public view onlyOwner returns(string memory){
    return baseURI;
  }

  function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
    baseExtension = _newBaseExtension;
  }

  function pause(bool _state) public onlyOwner {
    paused = _state;
  }

}

contract GeneralLottery is  Ownable ,VRFConsumerBaseV2 {
  VRFCoordinatorV2Interface COORDINATOR;
  uint64 s_subscriptionId;
  address vrfCoordinator = 0x6168499c0cFfCaCD319c818142124B7A15E857ab;
  bytes32 keyHash = 0xd89b2bf150e3b9e13446986e571fb9cab24b13cea0a43ea20a6049a85cc807cc;
  uint32 callbackGasLimit = 100000;
  uint16 requestConfirmations = 3;
  uint256[] public s_randomWords;
  uint256 public s_requestId;
  address s_owner;
    using Strings for uint256;
    using SafeMath for uint256;
    struct TiketsForOwner{
        uint idTickets;
        uint from;
        uint to;
    }
    LOTTERY_STATE public lotteryState=LOTTERY_STATE.CLOSED;
    enum LOTTERY_STATE {
        OPEN,
        CLOSED,
        CALCULATING_WINNER
    }
    uint[]  idWinners;
    TiketsForOwner[] public tikets;
    TiketsForOwner[] newTable;
    uint idTicket=0;
    uint idList=1;
    address addressNft;
    mapping(uint=>address) public ownerOfTicket;
    mapping(uint=>address) public EmptyownerOfTicket;
    event startLouttry();
    event enterToLouttry(address _user);
    event generateRandomTicket(uint _number);
    address adreessToken;
    struct TicketWiner{ 
        uint idTikets;
        address ownerTicket;
        uint ticket;
    }
    NFT nftContrat;
    constructor(address _adreessToken,address _adreessNft,uint64 subscriptionId) VRFConsumerBaseV2(vrfCoordinator){
          adreessToken=_adreessToken;
          COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
          s_owner = _msgSender();
          s_subscriptionId = subscriptionId;
          addressNft=_adreessNft;
          nftContrat=NFT(addressNft);
    }

    
      function _owner() public view virtual returns (address) {
        return s_owner;
      }

      function checkBalanceToken(address _tokenAddress,address _user) public view returns(uint ){
         return ERC20(_tokenAddress).balanceOf(_user);
    }
    function returnMultipleById(uint _tokenId,uint _numberOfTicket) private returns(uint256){
     NFT.Nft memory nftCanShared=nftContrat.getNftById(_tokenId);
     require(nftCanShared.hearts>0,"this nft dosn't have healt for this operation");
     require(nftCanShared.Type>=nftContrat.T1P(),"Your type of nft is Not PFP");
     uint mulNft=100;
     uint256 numberOfTikets=_numberOfTicket;
     require(nftContrat.ownerOf(_tokenId)==_msgSender(),"your are not owner of this nft");
     require(nftCanShared.hearts>0,"your are not owner of this nft");
     if(nftCanShared.level==nftContrat.Bronze() && !nftCanShared.Shield){
        mulNft=intervalRandom(101,105);
      }
     else if(nftCanShared.level==nftContrat.Bronze() && nftCanShared.Shield){
         mulNft=intervalRandom(106,110);
     }
     else if(nftCanShared.level==nftContrat.Silver() && !nftCanShared.Shield){
         mulNft=intervalRandom(111,120);
     }
     else if(nftCanShared.level==nftContrat.Silver() && nftCanShared.Shield){
          mulNft=intervalRandom(121,125);
      }
     else if(nftCanShared.level==nftContrat.Gold()){
         mulNft=intervalRandom(150,170);
      }
     else if(nftCanShared.level==nftContrat.Diamond()){
         mulNft=intervalRandom(190,200);
     }
      nftContrat.incrementPoints(_tokenId);
      nftContrat.decrementHearts(_tokenId);
         
         return numberOfTikets*mulNft;

    }
    
        function intervalRandom(uint _from ,uint _to) private view returns(uint256){
        uint256 hash=112233445566778899**2;
        uint256  rnd=uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp,hash)));
        return _from+rnd.mod(_to.sub(_from).add(1));
    }

       function enterToLoutry(uint _tokenId) public {
        require(lotteryState==LOTTERY_STATE.OPEN,"Louttry is closed");
        uint balanceGardIno=checkBalanceToken(adreessToken,_msgSender()).div(10**18);
        require(balanceGardIno>0,"Your balance GandeIno Not suffisant");
        require(!checkUseralreadyParticipating(),"you are already Participating in this louttry");
        uint numberOfTicket=returnMultipleById(_tokenId,balanceGardIno).div(100);
         TiketsForOwner memory newTickets=TiketsForOwner(idList,idTicket.add(1),idTicket+numberOfTicket);
         tikets.push(newTickets);
         ownerOfTicket[idList]=_msgSender();
         idTicket+=numberOfTicket;
         idList++;
         emit enterToLouttry(_msgSender());
     }
     function getWinnerTicket() public view returns(uint[] memory){
       require(idWinners.length>0,"Random not executed");
       return idWinners;
     }
     function checkUseralreadyParticipating() public view returns(bool){
        bool check=false;
        for(uint indexOfTickets=0;indexOfTickets<tikets.length;indexOfTickets++){
             if(ownerOfTicket[tikets[indexOfTickets].idTickets]==_msgSender())
             check =true;
         }
         return check;
     }
    function getTicketByUser() public view returns(TiketsForOwner memory){
        TiketsForOwner memory returnTicket ;
        for(uint indexOfTickets=0;indexOfTickets<tikets.length;indexOfTickets++){
             if(ownerOfTicket[tikets[indexOfTickets].idTickets]==_msgSender())
             returnTicket=tikets[indexOfTickets];
         }
         return returnTicket;
    }
     function getWinnerId(uint _id) public view returns(TicketWiner memory ){
       TicketWiner memory ticketWiner;
       for(uint indexOfArray=0;indexOfArray<tikets.length;indexOfArray++){
       if(tikets[indexOfArray].from<= _id && _id<=tikets[indexOfArray].to)
        ticketWiner=TicketWiner(tikets[indexOfArray].idTickets,ownerOfTicket[tikets[indexOfArray].idTickets],_id);
       }
      return ticketWiner;
    }
    function generateRandomWinners() public onlyOwner{
      require(lotteryState==LOTTERY_STATE.CALCULATING_WINNER,"Louttry is Open ");
      require(s_randomWords.length!=0,"random from chainlink not work");
      for(uint i=0;i<s_randomWords.length;i++){
        idWinners.push(s_randomWords[i].mod(idTicket));
      }
      lotteryState=LOTTERY_STATE.CLOSED;
      emit generateRandomTicket(s_randomWords.length);
    }  

    function startNewLouttry() public onlyOwner {
        tikets=newTable;
        idTicket=0;
        idList=1;
        delete idWinners;
        lotteryState=LOTTERY_STATE.OPEN;
        delete s_randomWords;
        emit startLouttry();
    }
    function getAllTickets() public view returns(TiketsForOwner[] memory){
      return tikets;
    }

 
  function requestRandomWords(uint32 _numWords) external onlyOwner {
    lotteryState=LOTTERY_STATE.CALCULATING_WINNER;
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      _numWords
    );
  }
  function returnRandomList() external view returns(uint[] memory) {
    return s_randomWords;
  }
  
  function fulfillRandomWords(
    uint256, /* requestId */
    uint256[] memory randomWords
  ) internal override {
    s_randomWords = randomWords;
  }

}

