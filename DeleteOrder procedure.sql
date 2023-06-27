use PurchaseOrderDB
go
ALTER PROCEDURE DeleteOrder
   @OrderID INT = NULL,
   @OrderItemID INT = NULL
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @OrderAmount DECIMAL(18, 2);
   DECLARE @OrderAmountBaru DECIMAL(18, 2);

   -- Delete the specific order item with the given OrderItemID (oiid=value, oid=null)
   IF @OrderItemID IS NOT NULL
   BEGIN
      -- Get the OrderID based on the selected OrderItemID
	 SELECT @OrderID = t_order_oid
	 FROM t_orderitems
	 WHERE oiid = @OrderItemID;
	 
	 -- Get the total amount of the order
	 SELECT @OrderAmount = TotalAmount FROM t_order WHERE oid = @OrderID;

	 DECLARE @ProductID INT;
	 DECLARE @Quantity INT;
	 DECLARE @UnitPrice DECIMAL(18, 2);

      -- Get the ProductID, Quantity, and UnitPrice of the order item
      SELECT @ProductID = t_product_pid, @Quantity = Qty, @UnitPrice = tp.UnitPrice
      FROM t_orderitems oi
      JOIN t_product tp ON oi.t_product_pid = tp.pid
      WHERE oi.oiid = @OrderItemID;

      -- Delete the order item
      DELETE FROM t_orderitems WHERE oiid = @OrderItemID;
      SELECT 'deleted unit price' = @UnitPrice;
      SELECT 'deleted quantity' = @Quantity;
	  SELECT 'order amount' = @OrderAmount;

      -- Update the TotalAmount based on the quantity and unit price of the deleted order item
      SET @OrderAmount = @OrderAmount - (@Quantity * @UnitPrice);

   END
   ELSE 
      -- Delete the specific order item with the given OrderItemID (oiid=null, oid=value)
   BEGIN

   	 -- Get the total amount of the order
	 SELECT @OrderAmount = TotalAmount FROM t_order WHERE oid = @OrderID;
     
      -- Delete all order items associated with the order
      DELETE FROM t_orderitems WHERE t_order_oid = @OrderID;

      -- Update the TotalAmount to 0 when deleting all order items
      SET @OrderAmount = 0;
	  print 'order deleted!'

   END

   -- Update the TotalAmount on t_order
   UPDATE t_order SET TotalAmount = @OrderAmount WHERE oid = @OrderID;
	
   -- Delete the order from the t_order table if no order items remaining
   IF NOT EXISTS (SELECT * FROM t_orderitems WHERE t_order_oid = @OrderID)
   BEGIN
      DELETE FROM t_order WHERE oid = @OrderID;
   END

   declare @a int
	select @a = a.cid FROM t_cust a, t_order b WHERE a.cid <> b.t_cust_cid

	DELETE FROM t_cust WHERE cid = @a

END




--delete by oid
DECLARE @OrderID INT = 1; 
EXEC DeleteOrder @OrderID = @OrderID

--delete by oiid
DECLARE @OrderItemID INT = 2; 
EXEC DeleteOrder @OrderItemID = @OrderItemID
