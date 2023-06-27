USE PurchaseOrderDB
GO

alter procedure updateorder
   @custname varchar(50),
   @description varchar(255),
   @qty int,
   @unitprice float = 0
as
begin
   set nocount on;

   declare @order_date date;
   set @order_date = getdate();

   -- check if the customer already exists
   declare @tcust_cid int;

   select @tcust_cid = cid from t_cust where CustName = @custname;

   if @tcust_cid is null
   begin
      -- customer does not exist
      raiserror ('Customer does not exist.', 16, 1);
      return;
   end;

   -- check if the product already exists
   declare @pid int;

   select @pid = pid from t_product where Description = @description;

   if @pid is null
   begin
      -- product does not exist
      raiserror ('Product does not exist.', 16, 1);
      return;
   end;

   -- print the selected customer and product ids for debugging
	print 'Selected Customer ID: ' + convert(varchar(5), @tcust_cid) + ' (' + @custname + ')';
	print 'Order to be updated: ' + convert(varchar(5), @pid) + ' (' + @description + ') to quantity = ' + convert(varchar(5), @qty);


	-- update the order items
	update oi
	set Qty = @qty
	from t_orderitems oi
	join t_order o on oi.t_order_oid = o.oid
	join t_product p on oi.t_product_pid = p.pid
	where o.t_cust_cid = @tcust_cid
	   and o.OrderDate = @order_date
	   and p.Description = @description
	   and p.pid = @pid
	   and exists (
		  select 1
		  from t_orderitems oi2
		  where oi2.t_order_oid = o.oid
			 and oi2.t_product_pid = p.pid
	   );

	-- recalculate the totalamount for the specific order
	update o
	set TotalAmount = (
	   select sum(p.UnitPrice * oi.qty)
	   from t_orderitems oi
	   join t_product p on oi.t_product_pid = p.pid
	   where oi.t_order_oid = o.oid
	)
	from t_order o
	where o.t_cust_cid = @tcust_cid
	   and o.OrderDate = @order_date
	   and exists (
		  select 1
		  from t_orderitems oi2
		  join t_product p2 on oi2.t_product_pid = p2.pid
		  where oi2.t_order_oid = o.oid
			 and p2.pid = @pid
	   );


   -- check if any rows were affected
   if @@rowcount = 0
   begin
      -- no rows were updated
      raiserror ('No matching order items found for the specified customer and product.', 16, 1);
      return;
   end;

   -- success message
   print 'Order updated successfully.';
end;


-- Execute the stored procedure
EXEC UpdateOrder
   @CustName = 'Danesh',
   @Description = 'Warm Vanilla Sugar',
   @Qty = 5;







EXEC UpdateOrderItem
    @CustName = 'Nai',
    @Description = 'Thousand Wishes',
    @UnitPrice = 45,
    @Qty = 1;



SELECT * FROM t_order

SELECT * FROM t_orderitems