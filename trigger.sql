DELIMITER //

CREATE TRIGGER update_balance
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    DECLARE amount DECIMAL(10, 2);
    
    -- Get the transaction amount
    SET amount = NEW.amount;

    -- Update balance based on transaction type
    IF NEW.atype = 'Deposite' THEN
        UPDATE accounts
        SET curbal = curbal + amount
        WHERE acnumber = NEW.account_no;
    ELSEIF NEW.atype = 'Withdraw' THEN
        UPDATE accounts
        SET curbal = curbal - amount
        WHERE acnumber = NEW.account_no;
    END IF;
END;
//

DELIMITER ;

