pragma solidity 0.8.0;
/*1) The owner can start the bank with initial deposit/capital in ether (min 50 eths)
    2) Only the owner can close the bank. Upon closing the balance should return to the Owner
    3) Anyone can open an account in the bank for Account opening they need to deposit ether with address
    4) Bank will maintain balances of accounts
    5) Anyone can deposit in the bank
    6) Only valid account holders can withdraw
    7) First 5 accounts will get a bonus of 1 ether in bonus
    8) Account holder can inquiry balance
The depositor can request for closing an account*/

contract cryptobank {
    address  owner;
   
   // step 1
   
constructor()payable{
    require(msg.value>=50 ether,'To start this bank you have to submit atleast 50 ethers');
    owner=msg.sender;
}
//step2
modifier chekowner(){
    if (msg.sender ==owner){
        _;
    }
} 
function closebank ()public chekowner{
    
    selfdestruct(payable(owner));
}
//step3
mapping (address=>uint)accounts;
uint8 counter;
function openaccount ()public payable {
    
   require( msg.value>0 && msg.sender!=address(0),'invalid address or value is 0');
        accounts[msg.sender]=msg.value;
     counter++;
     if (counter++>=4){payable (msg.sender).transfer(1 ether);
         
     }
}
//step5
function depositamount (address add,uint amount)public payable {
    uint amount=msg.value;
    require(amount>0 ether && add!=address(0));
    accounts[add]=amount;
}
//step6
function withdraw (uint amount)public payable {
    require(amount>0 ether && msg.sender!=address(0));
    require(amount>=accounts[msg.sender]);
   payable(msg.sender).transfer(amount );
   accounts[msg.sender] -=msg.value;
}
//step8
function chekbalance ()public view returns(uint) {
    return accounts[msg.sender];
}
function closeaccount ()public payable{
     require(msg.sender!=address(0) && accounts[msg.sender]>0 ether);
     payable (msg.sender). transfer(accounts[msg.sender]);

}}
