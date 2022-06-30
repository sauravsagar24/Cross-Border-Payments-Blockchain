// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.4.0 < 0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract CrossBorderPaymnet
{
    mapping(address=>uint) userAccount;
    mapping(address=>bool) public userExists;

    mapping(address=>string) public Bank_Name;
    mapping(address=>string) Customer_Name;
    mapping(address=>string) Pswd;

    uint public forex_tax;


    function OpenNewAccount(string memory BankName, string memory CustomerName, string memory Password) public payable returns(string memory)
    {
        require(userExists[msg.sender]==false,'Account Already Created');

        
        userAccount[msg.sender] = msg.value;
        userExists[msg.sender] = true;

        Bank_Name[msg.sender] = BankName;
        Customer_Name[msg.sender] = CustomerName;
        Pswd[msg.sender] = Password;

        string memory result_note = string(abi.encodePacked("Congratulation ", CustomerName, "! Thanks for choosing ", BankName , "." ));
        return(result_note);
    }


    function DepositMoney(string memory Password) public payable returns(string memory)
    {
        require(userExists[msg.sender]==true, "Account is not created");
        require(msg.value > 0, "Value for deposit is Zero");

        if( keccak256(abi.encodePacked(Pswd[msg.sender])) == keccak256(abi.encodePacked(Password)) ) 
        {
            userAccount[msg.sender] = userAccount[msg.sender] + msg.value;
            return ("Deposited Succesfully..!");
        }

        return("Wrong Password..!");
    }


    function WithdrawMoney(string memory Password, uint Amount) public payable returns(string memory)
    {
        require(userAccount[msg.sender] > Amount, "Insufficeint balance in Bank account..!");
        require(userExists[msg.sender] == true, "Account is not created..!");
        require(Amount > 0, "Enter non-zero value for withdrawal...!");

        if( keccak256(abi.encodePacked(Pswd[msg.sender])) == keccak256(abi.encodePacked(Password)) ) 
        {
            userAccount[msg.sender] = userAccount[msg.sender] - Amount;
            //msg.sender.transfer(amount);
            return("withdrawal Succesful");
        }

        return("Wrong Password..!");
    }



    function ForiegnExchange(string memory Sender_Bank_Name, string memory Password, string memory Receiver_Bank_Name, address payable ReceiverAddress, uint Transfer_amount) public returns(string memory)
    {
        if ( ( keccak256(abi.encodePacked(Bank_Name[msg.sender])) == keccak256(abi.encodePacked(Sender_Bank_Name)) )  
        && ( keccak256(abi.encodePacked(Pswd[msg.sender])) == keccak256(abi.encodePacked(Password)) )  )
        {
            if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 5;

                uint INR2USD = Transfer_amount / 76;
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;

                forex_tax = forex_tax + (tranfer_tax / 76);


                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + INR2USD ;
                
                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }


            else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 5;

                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint USD2INR = Transfer_amount * 76;

                forex_tax = forex_tax + tranfer_tax;

                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + USD2INR ;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }


            else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 4;

                uint JPY2USD = Transfer_amount / 128;
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;

                forex_tax = forex_tax + (tranfer_tax / 128);

                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + JPY2USD ;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 4;

                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint USD2JPY = Transfer_amount * 128;

                forex_tax = forex_tax + tranfer_tax;

                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + USD2JPY;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 2;

                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint INR2JPY = ( Transfer_amount * 167 ) / 100;

                forex_tax = forex_tax + (tranfer_tax / 76);

                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + INR2JPY;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }


            else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) 
            && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) )
            {
                require(userAccount[msg.sender] > Transfer_amount, "Insufficeint balance in Bank account..!");
                require(userExists[msg.sender]==true, "Account is not created..!");
                require(userExists[ReceiverAddress]==true, "Receiver's account does not exists in Bank..!");
                require(Transfer_amount > 0, "Enter non-zero value for sending..!");

                uint forex_rate = 2;

                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint JPY2INR = ( Transfer_amount * 100 ) / 167;

                forex_tax = forex_tax + (tranfer_tax / 128);

                userAccount[msg.sender] = userAccount[msg.sender] - Transfer_amount - tranfer_tax ;
                userAccount[ReceiverAddress] = userAccount[ReceiverAddress] + JPY2INR;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }
        }
        return("Invalid Credentials..!");
    }



    function CheckBalance(string memory Password) public view returns(string memory)
    {
        if( keccak256(abi.encodePacked(Pswd[msg.sender])) == keccak256(abi.encodePacked(Password)) )       
        {
            string memory str_balance = Strings.toString(userAccount[msg.sender]);
            string memory result_note;

            if( keccak256(abi.encodePacked(Bank_Name[msg.sender])) == keccak256(abi.encodePacked("Bank of India")) )
            {
                result_note = string(abi.encodePacked(str_balance," INR"));
            }

            else if( keccak256(abi.encodePacked(Bank_Name[msg.sender])) == keccak256(abi.encodePacked("Bank of America")) )
            {
                result_note = string(abi.encodePacked(str_balance," USD"));
            }

            else if( keccak256(abi.encodePacked(Bank_Name[msg.sender])) == keccak256(abi.encodePacked("Bank of Japan")) )
            {
                result_note = string(abi.encodePacked(str_balance," YEN"));
            }

            return(result_note);
        }
        
        return("Wrong Password..!");
    }



    function ChangePassword( string memory CurrentPassword, string memory NewPassword) public returns(string memory)
    {
        if (keccak256(abi.encodePacked(Pswd[msg.sender])) == keccak256(abi.encodePacked(CurrentPassword)))
        {
            Pswd[msg.sender] = NewPassword;
            return("Password Changed Successfully..!");
        }

        return("Invalid Password..!");
    }


    function AccountExist() public view returns(bool)
    {
        return userExists[msg.sender];
    }
  
}
