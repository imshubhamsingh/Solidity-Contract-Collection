pragma solidity ^0.4.13;

contract Amazon {

  /* set owner */
  address owner;

  /* Add a variable called skuCount to track the most recent sku # */
  uint private skuCount;

  /* Add a line that creates a public mapping that maps the SKU (a number) to an Item.
     Call this mappings items
  */
  mapping (uint => Item) private items;

  /* Add a line that creates an enum called State. This should have 4 states
    ForSale
    Sold
    Shipped
    Received
  */
  enum State { ForSale, Sold, Shipped , Received }

  /* Create a struct named Item.
    Here, add a name, sku, price, state, seller, and buyer
    We've left you to figure out what the appropriate types are,
    if you need help you can ask around :)
  */
  struct Item {
    string name;
    uint sku;
    uint price;
    State state;
    address seller;
    address buyer;
  }

  /* Create 4 events with the same name as each possible State (see above)
    Each event should accept one argument, the sku*/
    event ForSale (uint sku);
    event Sold (uint sku);
    event Shipped (uint sku);
    event Received (uint sku);

  modifier isOwner (address _owner) { require(msg.sender == _owner); _;}
  modifier isBuyer (address _buyer) { require(msg.sender == _buyer); _;}
  modifier paidEnough(uint _value) { require(msg.value >= _value); _;}
  modifier refundValue(uint sku) {
    //refund them after pay for item (why it is before, _ checks for logic fo func)
    _;
    if(msg.value - items[sku].price >0){
        msg.sender.transfer(msg.value - items[sku].price);
    }
  }

  /* For each of the following modifiers, use what you learned about modifiers
   to give them functionality. For example, the forSale modifier should require
   that the item with the given sku has the state ForSale. */
  modifier forSale (uint _sku) { require(State.ForSale == items[_sku].state); _ ;}
  modifier sold (uint _sku) { require(State.Sold == items[_sku].state); _ ;}
  modifier shipped (uint _sku) { require(State.Shipped == items[_sku].state); _ ;}
  modifier received (uint _sku) { require(State.Received == items[_sku].state); _ ;}


  constructor() public {
    /* Here, set the owner as the person who instantiated the contract
       and set your skuCount to 0. */
       owner = msg.sender;
       skuCount = 0;
  }

  function addItem(string _name, uint _price) public {
    items[skuCount] = Item({name: _name, sku: skuCount, price: _price*1 ether, state: State.ForSale, seller: msg.sender, buyer: msg.sender});
    skuCount = skuCount + 1;
    emit ForSale(skuCount);
  }

  /* Add a keyword so the function can be paid. This function should transfer money
    to the seller, set the buyer as the person who called this transaction, and set the state
    to Sold. Be careful, this function should use 3 modifiers to check if the item is for sale,
    if the buyer paid enough, and check the value after the function is called to make sure the buyer is
    refunded any excess ether sent. Remember to call the event associated with this function!*/

  function buyItem(uint sku) forSale(sku) paidEnough(items[sku].price) refundValue(sku) payable public{
    items[sku].buyer = msg.sender;
    items[sku].state = State.Sold;
    items[sku].seller.transfer(items[sku].price);
    emit Sold(sku);
  }

  /* Add 2 modifiers to check if the item is sold already, and that the person calling this function
  is the seller. Change the state of the item to shipped. Remember to call the event associated with this function!*/
  function shipItem(uint sku)
  isOwner(items[sku].seller)
  sold(sku) public {
    items[sku].state = State.Shipped;
    emit Shipped(sku);
  }

  /* Add 2 modifiers to check if the item is shipped already, and that the person calling this function
  is the buyer. Change the state of the item to received. Remember to call the event associated with this function!*/
  function receiveItem(uint sku) shipped(sku) isBuyer(items[sku].buyer) public {
    items[sku].state = State.Received;
    emit Received(sku);
  }

  /* We have this function completed so we can run tests, just ignore it :) */
  function fetchLast() public view returns (string name, uint sku, uint price, uint state, address seller, address buyer) {
    name = items[skuCount-1].name;
    sku = items[skuCount-1].sku;
    price = items[skuCount-1].price;
    state = uint(items[skuCount-1].state);
    seller = items[skuCount-1].seller;
    buyer = items[skuCount-1].buyer;
    return (name, sku, price, state, seller, buyer);
  }

}