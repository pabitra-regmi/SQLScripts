use  employee;
CREATE TABLE PaymentMethod (
      Pid INT NOT NULL,
	  Payment VARCHAR(50)
);

INSERT INTO PaymentMethod (Pid,Payment)
VALUES 
    (1,'Receivable'),
	(2,'Bank'),
	(3,'Cash');

