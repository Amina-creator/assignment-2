pragma solidity 0.8.4;

import"https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
contract mytoken is ERC20{
  constructor ()ERC20("mytoken","mt"){
       owner= msg.sender;
  }
   address owner;
      uint rate=100;
      
   function buytoken( )external payable {
       _mint (msg.sender,msg.value*rate*10**18);
       
   } 
   function adjustprice(uint newprice) external  returns(uint) {
       require (msg.sender==owner,"only owner can adjust price");
       rate=newprice;
       return newprice;
       
   }
    fallback () external payable {
        if (msg.value>0){
        _mint (msg.sender,msg.value*rate*10**18);}
    }
    
}
