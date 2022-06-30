// SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 < 0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";

contract CrossBorderPayment
{
    // Declaring a structure for Bank
    struct Bank
    {
        string name;
        string acc_no;
        string password;
        uint balance;
    }

    uint BOI_acc_count = 1002;
    uint BOJ_acc_count = 1002;
    uint BOA_acc_count = 1002;

    // Cross Border Banks
    Bank[] BankOfIndia;
    Bank[] BankOfJapan;
    Bank[] BankOfAmerica;
    

    // Exchange Tax
    uint public forex_tax = 0;
    

    // Setting up some Default Accounts 
    function SetDefaultAccounts() public
    {
        Bank memory a = Bank("Saurav Sagar", "BOA00001001", "saurav@24", 1000);
        BankOfAmerica.push(a);

        Bank memory b = Bank("Anurag Dhote", "BOI00001001", "anurag@25", 76475);
        BankOfIndia.push(b);

        Bank memory c = Bank("Pratik Bhankhodiya", "BOJ00001001", "pratik@24", 128471);
        BankOfJapan.push(c);

    }


    // Creating New Bank account
    function OpenNewAccount(string memory Bank_Name, string memory cust_name, string memory password, uint first_deposit_amount) public  returns(string memory)
    {
        if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
        {
            string memory added_text1 = "BOI0000";
            string memory added_text2 = Strings.toString(BOI_acc_count);

            string memory new_account_number = string(abi.encodePacked(added_text1,added_text2));
            Bank memory account = Bank(cust_name, new_account_number, password, first_deposit_amount);
            BOI_acc_count = BOI_acc_count + 1;
            BankOfIndia.push(account);

            string memory result_note = string(abi.encodePacked("Namaste ", cust_name, "! Thanks for choosing Bank for India. Your account number is ",new_account_number));
            return(result_note);
        }

        else if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of America")))
        {
            string memory added_text1 = "BOA0000";
            string memory added_text2 = Strings.toString(BOA_acc_count);

            string memory new_account_number = string(abi.encodePacked(added_text1,added_text2));
            Bank memory account = Bank(cust_name, new_account_number, password, first_deposit_amount);
            BOA_acc_count = BOA_acc_count + 1;
            BankOfAmerica.push(account);
            
            string memory result_note = string(abi.encodePacked("Congratulation ", cust_name,"! Thanks for choosing Bank of America. Your account number is ",new_account_number));
            return(result_note);
        }

        else if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")))
        {
            string memory added_text1 = "BOJ0000";
            string memory added_text2 = Strings.toString(BOJ_acc_count);

            string memory new_account_number = string(abi.encodePacked(added_text1,added_text2));
            Bank memory account = Bank(cust_name, new_account_number, password, first_deposit_amount);
            BOJ_acc_count = BOJ_acc_count + 1;
            BankOfJapan.push(account);
            
            string memory result_note = string(abi.encodePacked("Konnichiwa ", cust_name,"! Thanks for choosing Bank of Japan. Your account number is ",new_account_number));
            return(result_note);
        }

        return("No such Bank exist...!"); 
    }


    // Checing Account Balance
    function CheckBalance(string memory Bank_Name, string memory cust_acc_no, string memory cust_pswd) public view returns(string memory)
    {
        uint i;

        if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
        {
            
            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )
                {
                    string memory str_balance = Strings.toString(account.balance);
                    string memory result_note = string(abi.encodePacked(str_balance," INR"));
                    return(result_note);
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of America")) )
        {
            
            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    string memory str_balance = Strings.toString(account.balance);
                    string memory result_note = string(abi.encodePacked(str_balance," USD"));
                    return(result_note);
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")) )
        {
            
            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    string memory str_balance = Strings.toString(account.balance);
                    string memory result_note = string(abi.encodePacked(str_balance," YEN"));
                    return(result_note);
                }
            }
        }

        return("Invalid Credentials....!");
        
    }


    // Deposit Money in Bank Account
    function DepositMoney(string memory Bank_Name, string memory cust_acc_no, string memory cust_pswd, uint deposit_amount) public returns(string memory)
    {
        uint i;

        if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
        {
            
            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )
                {
                    BankOfIndia[i].balance = BankOfIndia[i].balance + deposit_amount;
                    string memory str_balance = Strings.toString(BankOfIndia[i].balance);
                    string memory result_note = string(abi.encodePacked(str_balance," INR"));
                    return(result_note);
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of America")) )
        {
            
            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    BankOfAmerica[i].balance = BankOfAmerica[i].balance + deposit_amount;
                    string memory str_balance = Strings.toString(BankOfAmerica[i].balance);
                    string memory result_note = string(abi.encodePacked(str_balance," USD"));
                    return(result_note);
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")) )
        {
            
            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    BankOfJapan[i].balance = BankOfJapan[i].balance + deposit_amount;
                    string memory str_balance = Strings.toString(BankOfJapan[i].balance);
                    string memory result_note = string(abi.encodePacked(str_balance," YEN"));
                    return(result_note);
                }
            }
        }

        return("Invalid Credentials....!");      
    }


    // Withdraw Money from Bank Account
    function WithdrawMoney(string memory Bank_Name, string memory cust_acc_no, string memory cust_pswd, uint withdraw_amount) public returns(string memory)
    {
        uint i;

        if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
        {
            
            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )
                {
                    if (account.balance >= withdraw_amount)
                    {
                        BankOfIndia[i].balance = BankOfIndia[i].balance - withdraw_amount;
                        string memory str_balance = Strings.toString(BankOfIndia[i].balance);
                        string memory result_note = string(abi.encodePacked(str_balance," INR"));
                        return(result_note);
                    }

                    return("Not enough Balance.");
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of America")) )
        {
            
            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    if (account.balance >= withdraw_amount)
                    {
                        BankOfAmerica[i].balance = BankOfAmerica[i].balance - withdraw_amount;
                        string memory str_balance = Strings.toString(BankOfAmerica[i].balance);
                        string memory result_note = string(abi.encodePacked(str_balance," USD"));
                        return(result_note);
                    }

                    return("Not enough Balance.");
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")) )
        {
            
            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(cust_pswd)) ) )  
                {
                    if (account.balance >= withdraw_amount)
                    {
                        BankOfJapan[i].balance = BankOfJapan[i].balance - withdraw_amount;
                        string memory str_balance = Strings.toString(BankOfJapan[i].balance);
                        string memory result_note = string(abi.encodePacked(str_balance," YEN"));
                        return(result_note);
                    }

                    return("Not enough Balance.");
                }
            }
        }

        return("Invalid Credentials....!");
        
    }


    // Changing old Bank Password
    function ChangePassword(string memory Bank_Name, string memory cust_acc_no, string memory current_pswd, string memory new_password) public returns(string memory)
    {
        uint i;

        if (keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
        {
            
            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(current_pswd)) ) )
                {
                    BankOfIndia[i].password = new_password;
                    return("Password Changed!");
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of America")) )
        {
            
            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(current_pswd)) ) )
                {
                    BankOfAmerica[i].password = new_password;
                    return("Password Changed!");
                }
            }
        }

        else if ( keccak256(abi.encodePacked(Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")) )
        {
            
            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
            
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(cust_acc_no)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(current_pswd)) ) )
                {
                    BankOfJapan[i].password = new_password;
                    return("Password Changed!");
                }
            }
        }

        return("Invalid Credentials....!");   
    }


    // Transfer money Cross Border
    function ForeignExchange(string memory Sender_Bank_Name, string memory Sender_Acc_No, string memory Sender_Password, string memory Receiver_Bank_Name, string memory Receiver_Acc_No, uint Transfer_amount) public returns(string memory)
    {
        uint i;
        uint sender_index;
        uint receiver_index;

        if ( keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked(Receiver_Bank_Name)) )
        {
            if (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of India")))
            { 
                for(i=0; i<BankOfIndia.length; i++)
                {
                    Bank memory account = BankOfIndia[i];
            
                    if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                    && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                    {
                        sender_index = i;
                    }

                    if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                    {
                        receiver_index = i;
                    }
                }

                if (BankOfIndia[sender_index].balance >= Transfer_amount)
                {
                    BankOfIndia[sender_index].balance = BankOfIndia[sender_index].balance - Transfer_amount;
                    BankOfIndia[receiver_index].balance = BankOfIndia[receiver_index].balance + Transfer_amount;
                    return("Transfer Successful!");
                }

                return("Not enough Balance!");
            }


            else if (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of America")))
            { 
                for(i=0; i<BankOfAmerica.length; i++)
                {
                    Bank memory account = BankOfAmerica[i];
            
                    if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                    && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                    {
                        sender_index = i;
                    }

                    if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                    {
                        receiver_index = i;
                    }
                }

                if (BankOfAmerica[sender_index].balance >= Transfer_amount)
                {
                    BankOfAmerica[sender_index].balance = BankOfAmerica[sender_index].balance - Transfer_amount;
                    BankOfAmerica[receiver_index].balance = BankOfAmerica[receiver_index].balance + Transfer_amount;
                    return("Transfer Successful!");
                }

                return("Not enough Balance!");
            }


            else if (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan")))
            { 
                for(i=0; i<BankOfJapan.length; i++)
                {
                    Bank memory account = BankOfJapan[i];
            
                    if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                    && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                    {
                        sender_index = i;
                    }

                    if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                    {
                        receiver_index = i;
                    }
                }

                if (BankOfJapan[sender_index].balance >= Transfer_amount)
                {
                    BankOfJapan[sender_index].balance = BankOfJapan[sender_index].balance - Transfer_amount;
                    BankOfJapan[receiver_index].balance = BankOfJapan[receiver_index].balance + Transfer_amount;
                    return("Transfer Successful!");
                }

                return("Not enough Balance!");
            }
        }  

            
        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) )
        { 
            uint forex_rate = 5;

            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfIndia[sender_index].balance >= Transfer_amount)
            {
                uint INR2USD = Transfer_amount / 76;
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;

                forex_tax = forex_tax + (tranfer_tax / 76);

                BankOfIndia[sender_index].balance = BankOfIndia[sender_index].balance - Transfer_amount - tranfer_tax ;
                BankOfAmerica[receiver_index].balance = BankOfAmerica[receiver_index].balance + INR2USD ;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }

        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) )
        { 
            uint forex_rate = 5;

            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfAmerica[sender_index].balance >= Transfer_amount)
            {
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint USD2INR = Transfer_amount * 76;

                forex_tax = forex_tax + tranfer_tax;

                BankOfAmerica[sender_index].balance = BankOfAmerica[sender_index].balance - Transfer_amount - tranfer_tax;
                BankOfIndia[receiver_index].balance = BankOfIndia[receiver_index].balance + USD2INR;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }



        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) )
        { 
            uint forex_rate = 4;

            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfJapan[sender_index].balance >= Transfer_amount)
            {
                uint JPY2USD = Transfer_amount / 128;
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;

                forex_tax = forex_tax + (tranfer_tax / 128);

                BankOfJapan[sender_index].balance = BankOfJapan[sender_index].balance - Transfer_amount - tranfer_tax;
                BankOfAmerica[receiver_index].balance = BankOfAmerica[receiver_index].balance + JPY2USD;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }


        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of America"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) )
        { 
            uint forex_rate = 4;

            for(i=0; i<BankOfAmerica.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfAmerica[sender_index].balance >= Transfer_amount)
            {
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint USD2JPY = Transfer_amount * 128;

                forex_tax = forex_tax + tranfer_tax;

                BankOfAmerica[sender_index].balance = BankOfAmerica[sender_index].balance - Transfer_amount - tranfer_tax;
                BankOfJapan[receiver_index].balance = BankOfJapan[receiver_index].balance + USD2JPY;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }



        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) )
        { 
            uint forex_rate = 2;

            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfAmerica[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfIndia[sender_index].balance >= Transfer_amount)
            {
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint INR2JPY = ( Transfer_amount * 167 ) / 100;

                forex_tax = forex_tax + (tranfer_tax / 76);

                BankOfIndia[sender_index].balance = BankOfIndia[sender_index].balance - Transfer_amount - tranfer_tax;
                BankOfJapan[receiver_index].balance = BankOfJapan[receiver_index].balance + INR2JPY;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }




        else if ( (keccak256(abi.encodePacked(Sender_Bank_Name)) == keccak256(abi.encodePacked("Bank of Japan"))) 
        && (keccak256(abi.encodePacked(Receiver_Bank_Name)) == keccak256(abi.encodePacked("Bank of India"))) )
        { 
            uint forex_rate = 2;

            for(i=0; i<BankOfJapan.length; i++)
            {
                Bank memory account = BankOfJapan[i];
        
                if ( ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Sender_Acc_No)) ) 
                && ( keccak256(abi.encodePacked(account.password)) == keccak256(abi.encodePacked(Sender_Password)) ) )
                {
                    sender_index = i;
                }
            }

            for(i=0; i<BankOfIndia.length; i++)
            {
                Bank memory account = BankOfIndia[i];
        
                if ( keccak256(abi.encodePacked(account.acc_no)) == keccak256(abi.encodePacked(Receiver_Acc_No)) ) 
                {
                    receiver_index = i;
                }
            }

            if (BankOfJapan[sender_index].balance >= Transfer_amount)
            {
                uint tranfer_tax = (Transfer_amount * forex_rate) / 100;
                uint JPY2INR = ( Transfer_amount * 100 ) / 167;

                forex_tax = forex_tax + (tranfer_tax / 128);

                BankOfJapan[sender_index].balance = BankOfJapan[sender_index].balance - Transfer_amount - tranfer_tax;
                BankOfIndia[receiver_index].balance = BankOfIndia[receiver_index].balance + JPY2INR;

                string memory str_forex_rate = Strings.toString(forex_rate);
                string memory result_note = string(abi.encodePacked("Transfer Successful! With a deduction of ", str_forex_rate,"% foriegn currency exchange tax."));
                return(result_note);
            }

            return("Not enough Balance!");
        }

        return("Invalid Credentials....!");          
    }
}
