pragma solidity ^0.4.10;

import "./Owned.sol";

contract Store is Owned{

    /* Store internals */
    bytes32 public store_name; // store name
    uint256 private store_balance;  // store balance

    mapping (address => Customer) customers;

    /* Store Events */
    event CustomerRegistered(address customer);
    event CustomerRegistrationFailed(address customer);
    event CustomerDeregistered(address customer);
    event CustomerDeregistrationFailed(address customer);

    /**
        @notice every customer has an address, name,
        balance and a shopping cart
    */
    struct Customer {
        address adr;
        
		bytes32 name;
		bytes32 lastname;

		bytes32 number;
		bytes32 street;
		bytes32 city;
		bytes32 state;
        
		uint256 balance;
    }

    /**
        @notice Default constructor
    */
    function Store() {
        owner = msg.sender;
        store_name = "my-retail-store";
        store_balance = 0;
        if (this.balance > 0) throw;
    }

    /**
          @notice Payable fallback
    */
    function() payable {

    }

    /**
          @notice Registers a new customer (only store owners)
          @param _address Customer's address
          @param _name Customer's name
          @param _balance Customer's balance
          @return success
    */
    /*function registerCustomer(address _address, bytes32 _name, bytes32 _lastname, bytes32 _street, bytes32 _number, bytes32 _city, bytes32 _state, uint256 _balance)
                                        onlyOwner returns (bool success) {
	*/
	function registerCustomer(address _address, bytes32 _name, uint256 _balance)
                                        onlyOwner returns (bool success) {
										bytes32 _lastname = "s";
										bytes32 _city = "s";
										bytes32 _state = "s";
										bytes32 _street = "s";
										bytes32 _number = "s";
									
	if (_address != address(0)) {
        Customer memory customer = Customer({ adr: _address, 
											  name: _name,
											  lastname: _lastname,
											  city: _city,
											  state: _state,
											  number: _number,
											  street: _street,
                                              balance: _balance
                                            });
        customers[_address] = customer;
        CustomerRegistered(_address);
        return true;
      }
      CustomerRegistrationFailed(_address);
      return false;
    }

    /**
        @notice Removes a customer (only store owners)
        @param _address Customer's address
        @return success
    */
    function deregisterCustomer(address _address) onlyOwner
                                                        returns (bool success) {
      Customer customer = customers[_address];
      if (customer.adr != address(0)) {
        delete customers[_address];
        CustomerDeregistered(_address);
        return true;
      }
      CustomerDeregistrationFailed(_address);
      return false;
    }

    

    /**
          @notice Changes the name of the store
          @param new_store_name New store name
          @return success
    */
    function renameStoreTo(bytes32 new_store_name) onlyOwner
                                                        returns (bool success) {
        if (new_store_name.length != 0 &&
            new_store_name.length <= 32) {
            store_name = new_store_name;
            return true;
        }
        return false;
    }


    /**
          @notice Returns customer's balance
          @return _balance Customer's balance
    */
    function getBalance() constant returns (uint256 _balance) {
      return customers[msg.sender].balance;
    }

    /**
          @notice Returns stores's own balance
          @return store_balance Store's current balance
    */
    function getStoreBalance() onlyOwner constant returns (uint256) {
      return store_balance;
    }
}
