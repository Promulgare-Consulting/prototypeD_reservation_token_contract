pragma solidity ^0.4.24;


import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC20/ERC20.sol";

/**
 * @title ReservationToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `StandardToken` functions.
 */
contract ReservationToken is ERC20  {

  string public constant name = "ReservationToken";
  string public constant symbol = "PTD";
  uint8 public constant decimals = 0;

  uint256 public constant INITIAL_SUPPLY = 10000;
  

  address public owner;
  
  mapping(uint => uint) public reservations;
  
  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  constructor() public {
    _mint(msg.sender, INITIAL_SUPPLY);
    owner = msg.sender;  
  }

    function reserveDate(uint reservationDate, uint userId) public {
        // Check to see if date available
        require(getReservation(reservationDate)==0);
        // See if user has any tokens to use
        require(balanceOf(msg.sender)>0);
        // Put the reservation into the reservations calendar - in the form of YYYYMMDD ie 20180823
        reservations[reservationDate]=userId;
        // reduce the tokens for the person making the reservation
        _burn(msg.sender, 1);
    }
    
    function getReservation(uint reservationDate) public view returns(uint){
        return (reservations[reservationDate]);
    }
}
