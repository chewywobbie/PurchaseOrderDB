use PurchaseOrderDB
GO
alter procedure addneworder
   @custname varchar(50),
   @custaddr varchar(255),
   @contactno int,
   @totalamount float = 0,
   @amount float = 0,
   @description varchar(255),
   @unitprice float,
   @qty int
as
begin
   set nocount on;

   declare @order_date date;
   set @order_date = getdate();

   -- check if the customer already exists
   declare @tcust_cid int;

   if exists (select * from t_cust where custname = @custname and contactno = @contactno)
   begin
      -- retrieve the existing custid
      select @tcust_cid = cid from t_cust where custname = @custname and contactno = @contactno;
   end
   else
   begin
      -- insert new customer details
      insert into t_cust (custname, custaddr, contactno)
      values (@custname, @custaddr, @contactno);

      -- retrieve the newly inserted custid
      set @tcust_cid = scope_identity();
   end

   -- check if the product already exists
   declare @pid int;
   declare @sid int;

   if exists (select * from t_product where description = @description and unitprice = @unitprice)
   begin
      -- retrieve the existing product id and supplier id
      select @pid = pid, @sid = t_supp_sid from t_product where description = @description and unitprice = @unitprice;
   end
   else
   begin
      -- retrieve the supplier id
      select @sid = sid from t_supplier where suppliername = 'Bath & Body Works';

      -- insert new product
      insert into t_product (unitprice, description, t_supp_sid)
      values (@unitprice, @description, @sid);

      -- retrieve the newly inserted product id
      set @pid = scope_identity();
   end

   -- insert items into the t_order table if it doesn't exist for the customer and order date
   if not exists (select 1 from t_order where t_cust_cid = @tcust_cid and orderdate = @order_date)
   begin
      insert into t_order (orderdate, t_cust_cid)
      values (@order_date, @tcust_cid);
   end

   -- calculate the current amount for the order
   set @amount = @unitprice * @qty;

   -- insert items into the t_orderitems table
   insert into t_orderitems (t_order_oid, t_product_pid, qty)
   select oid, @pid, @qty
   from t_order
   where t_cust_cid = @tcust_cid and orderdate = @order_date;

   -- declare and initialize the variable
   declare @amountlama float;
   select @amountlama = coalesce(totalamount, 0) from t_order where t_cust_cid = @tcust_cid and orderdate = @order_date;

   -- calculate the current amount for the order
   declare @currentamount float;
   set @currentamount = @amount + @amountlama;

   -- update the totalamount for the customer's orders
   set @totalamount = (select sum(@currentamount) from t_order where t_cust_cid = @tcust_cid and orderdate = @order_date);
   update t_order
   set totalamount = @totalamount
   where t_cust_cid = @tcust_cid and orderdate = @order_date;

   -- update the supplier information for the inserted product
   update t_product
   set t_supp_sid = @sid
   where pid = @pid;
end;


EXEC AddNewOrder
   @CustName = 'Rose',
   @CustAddr = 'telipok',
   @ContactNo = 0102120204,
   @Description = 'Into the Night',
   @UnitPrice = 45,
   @Qty = 1;

   EXEC AddNewOrder
   @CustName = 'Rose',
   @CustAddr = 'telipok',
   @ContactNo = 0102120204,
   @Description = 'Thousand Wishes',
   @UnitPrice = 45,
   @Qty = 1;

EXEC AddNewOrder
   @CustName = 'Rose',
   @CustAddr = 'telipok',
   @ContactNo = 0102120204,
   @Description = 'Gingham', 
   @UnitPrice = 45,
   @Qty = 2;

   EXEC AddNewOrder
   @CustName = 'Rose',
   @CustAddr = 'telipok',
   @ContactNo = 0102120204,
   @Description = 'Poppy', 
   @UnitPrice = 45,
   @Qty = 1;

EXEC AddNewOrder
   @CustName = 'Nai',
   @CustAddr = 'Sepanggar',
   @ContactNo = 0146588115,
   @Description = 'Poppy',
   @UnitPrice = 45,
   @Qty = 1;

   
EXEC AddNewOrder
   @CustName = 'Nai',
   @CustAddr = 'Sepanggar',
   @ContactNo = 0146588115,
   @Description = 'Into The Night',
   @UnitPrice = 45,
   @Qty = 1;

   EXEC AddNewOrder
   @CustName = 'Danesh',
   @CustAddr = 'Klang',
   @ContactNo = 0166184162,
   @Description = 'Sweet Pea',
   @UnitPrice = 45,
   @Qty = 1;

   EXEC AddNewOrder
   @CustName = 'Danesh',
   @CustAddr = 'Klang',
   @ContactNo = 0166184162,
   @Description = 'Poppy',
   @UnitPrice = 45,
   @Qty = 2;

      EXEC AddNewOrder
   @CustName = 'Danesh',
   @CustAddr = 'Klang',
   @ContactNo = 0166184162,
   @Description = 'Warm Vanilla Sugar',
   @UnitPrice = 45,
   @Qty = 1;