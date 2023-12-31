USE [master]
GO
/****** Object:  Database [PurchaseOrderDB]    Script Date: 27/6/2023 10:20:25 AM ******/
CREATE DATABASE [PurchaseOrderDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PurchaseOrderDB', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PurchaseOrderDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PurchaseOrderDB_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PurchaseOrderDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PurchaseOrderDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PurchaseOrderDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PurchaseOrderDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PurchaseOrderDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PurchaseOrderDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PurchaseOrderDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PurchaseOrderDB] SET  MULTI_USER 
GO
ALTER DATABASE [PurchaseOrderDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PurchaseOrderDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PurchaseOrderDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PurchaseOrderDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PurchaseOrderDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PurchaseOrderDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PurchaseOrderDB] SET QUERY_STORE = OFF
GO
USE [PurchaseOrderDB]
GO
/****** Object:  Table [dbo].[t_cust]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_cust](
	[cid] [int] IDENTITY(1,1) NOT NULL,
	[CustName] [varchar](50) NULL,
	[CustAddr] [varchar](100) NULL,
	[ContactNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_order]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_order](
	[oid] [int] IDENTITY(1,1) NOT NULL,
	[t_cust_cid] [int] NULL,
	[OrderDate] [date] NOT NULL,
	[TotalAmount] [float] NULL,
 CONSTRAINT [PK_t_order] PRIMARY KEY CLUSTERED 
(
	[oid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_orderitems]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_orderitems](
	[oiid] [int] IDENTITY(1,1) NOT NULL,
	[t_order_oid] [int] NULL,
	[t_product_pid] [int] NULL,
	[Qty] [int] NOT NULL,
 CONSTRAINT [PK__t_orderi__4DCED7D63DD0074E] PRIMARY KEY CLUSTERED 
(
	[oiid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_product]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_product](
	[pid] [int] IDENTITY(1,1) NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[t_supp_sid] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[pid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[t_supplier]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t_supplier](
	[sid] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [varchar](50) NOT NULL,
	[SupplierAddr] [varchar](255) NULL,
	[SContactNo] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[sid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[t_order]  WITH CHECK ADD  CONSTRAINT [FK_t_order_t_cust] FOREIGN KEY([t_cust_cid])
REFERENCES [dbo].[t_cust] ([cid])
GO
ALTER TABLE [dbo].[t_order] CHECK CONSTRAINT [FK_t_order_t_cust]
GO
ALTER TABLE [dbo].[t_orderitems]  WITH CHECK ADD  CONSTRAINT [FK_t_orderitems_t_order] FOREIGN KEY([t_order_oid])
REFERENCES [dbo].[t_order] ([oid])
GO
ALTER TABLE [dbo].[t_orderitems] CHECK CONSTRAINT [FK_t_orderitems_t_order]
GO
ALTER TABLE [dbo].[t_orderitems]  WITH CHECK ADD  CONSTRAINT [FK_t_orderitems_t_product] FOREIGN KEY([t_product_pid])
REFERENCES [dbo].[t_product] ([pid])
GO
ALTER TABLE [dbo].[t_orderitems] CHECK CONSTRAINT [FK_t_orderitems_t_product]
GO
ALTER TABLE [dbo].[t_product]  WITH CHECK ADD  CONSTRAINT [FK_t_product_t_supplier] FOREIGN KEY([t_supp_sid])
REFERENCES [dbo].[t_supplier] ([sid])
GO
ALTER TABLE [dbo].[t_product] CHECK CONSTRAINT [FK_t_product_t_supplier]
GO
/****** Object:  StoredProcedure [dbo].[AddNewOrder]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddNewOrder]
   @custname VARCHAR(50),
   @custaddr VARCHAR(255),
   @contactno INT,
   @totalamount FLOAT = 0,
   @amount FLOAT = 0,
   @description VARCHAR(255),
   @unitprice FLOAT,
   @qty INT
AS
BEGIN
   SET NOCOUNT ON;

   DECLARE @order_date DATE;
   SET @order_date = GETDATE();

   -- Check if the customer already exists
   DECLARE @tcust_cid INT;

   IF EXISTS (SELECT * FROM t_cust WHERE CustName = @custname AND ContactNo = @contactno)
   BEGIN
      -- Retrieve the existing custid
      SELECT @tcust_cid = cid FROM t_cust WHERE CustName = @custname AND ContactNo = @contactno;
   END
   ELSE
   BEGIN
      -- Insert new customer details
      INSERT INTO t_cust (CustName, CustAddr, ContactNo)
      VALUES (@custname, @custaddr, @contactno);

      -- Retrieve the newly inserted custid
      SET @tcust_cid = SCOPE_IDENTITY();
   END

   -- Check if the product already exists
   DECLARE @pid INT;
   DECLARE @sid INT;

   IF EXISTS (SELECT * FROM t_product WHERE Description = @description AND UnitPrice = @unitprice)
   BEGIN
      -- Retrieve the existing product id and supplier id
      SELECT @pid = pid, @sid = t_supp_sid FROM t_product WHERE Description = @description AND UnitPrice = @unitprice;
   END
   ELSE
   BEGIN
      -- Retrieve the supplier id
      SELECT @sid = sid FROM t_supplier WHERE SupplierName = 'Bath & Body Works';

      -- Insert new product
      INSERT INTO t_product (UnitPrice, Description, t_supp_sid)
      VALUES (@unitprice, @description, @sid);

      -- Retrieve the newly inserted product id
      SET @pid = SCOPE_IDENTITY();
   END

   -- Insert items into the t_order table if it doesn't exist for the customer and order date
   IF NOT EXISTS (SELECT 1 FROM t_order WHERE t_cust_cid = @tcust_cid AND OrderDate = @order_date)
   BEGIN
      INSERT INTO t_order (OrderDate, t_cust_cid)
      VALUES (@order_date, @tcust_cid);
   END

   -- Calculate the current amount for the order
   SET @amount = @unitprice * @qty;

   -- insert items into the t_orderitems table
   INSERT INTO t_orderitems (t_order_oid, t_product_pid, Qty)
   SELECT oid, @pid, @qty
   FROM t_order
   WHERE t_cust_cid = @tcust_cid AND OrderDate = @order_date;

   -- Declare and initialize the variable
   DECLARE @amountlama FLOAT;
   SELECT @amountlama = COALESCE(TotalAmount, 0) FROM t_order WHERE t_cust_cid = @tcust_cid AND OrderDate = @order_date;

   -- Calculate the current amount for the order
   DECLARE @currentamount FLOAT;
   SET @currentamount = @amount + @amountlama;

   -- Update the totalamount for the customer's orders
   SET @totalamount = (SELECT SUM(@currentamount) FROM t_order WHERE t_cust_cid = @tcust_cid AND OrderDate = @order_date);
   UPDATE t_order
   SET TotalAmount = @totalamount
   WHERE t_cust_cid = @tcust_cid AND OrderDate = @order_date;

   -- Update the supplier information for the inserted product
   UPDATE t_product
   SET t_supp_sid = @sid
   WHERE pid = @pid;
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteOrder]
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
GO
/****** Object:  StoredProcedure [dbo].[SearchOrder]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SearchOrder]
   @CustomerID INT = NULL,
   @OrderDate DATE = NULL,
   @SortColumn VARCHAR(50) = 'OrderID',
   @SortOrder VARCHAR(4) = 'ASC'
AS
BEGIN
   SET NOCOUNT ON;

   BEGIN TRY
      SELECT O.oid AS OrderID,
             C.CustName AS CustomerName,
             O.OrderDate,
             O.TotalAmount,
             P.Description AS ProductDescription,
             OI.Qty AS Quantity
      FROM t_order O
      INNER JOIN t_cust C ON O.t_cust_cid = C.cid
      INNER JOIN t_orderitems OI ON O.oid = OI.t_order_oid
      INNER JOIN t_product P ON OI.t_product_pid = P.pid
      WHERE (@CustomerID IS NULL OR C.cid = @CustomerID)
         AND (@OrderDate IS NULL OR O.OrderDate = @OrderDate)
      ORDER BY
         CASE WHEN @SortColumn = 'OrderID' AND @SortOrder = 'ASC' THEN O.oid END ASC,
         CASE WHEN @SortColumn = 'OrderID' AND @SortOrder = 'DESC' THEN O.oid END DESC,
         CASE WHEN @SortColumn = 'CustomerName' AND @SortOrder = 'ASC' THEN C.CustName END ASC,
         CASE WHEN @SortColumn = 'CustomerName' AND @SortOrder = 'DESC' THEN C.CustName END DESC,
         CASE WHEN @SortColumn = 'OrderDate' AND @SortOrder = 'ASC' THEN O.OrderDate END ASC,
         CASE WHEN @SortColumn = 'OrderDate' AND @SortOrder = 'DESC' THEN O.OrderDate END DESC;
   END TRY
   BEGIN CATCH
      -- Handle the error or log it
      -- Rethrow the error or return a specific error message
      -- Example:
      -- SELECT ERROR_NUMBER() AS ErrorNumber, ERROR_MESSAGE() AS ErrorMessage;
      -- THROW;
   END CATCH;
END

GO
/****** Object:  StoredProcedure [dbo].[UpdateOrder]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateOrder]
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
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderItem]    Script Date: 27/6/2023 10:20:25 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateOrderItem]
    @OrderItemID INT,
    @Qty INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update the quantity in the t_orderitems table
    UPDATE t_orderitems
    SET Qty = @Qty
    WHERE t_order_oid = @OrderItemID;

    -- Update the TotalAmount and Amount in the t_order table
    UPDATE t_order
    SET TotalAmount = (
            SELECT SUM(oi.Qty * p.UnitPrice)
            FROM t_orderitems oi
            JOIN t_product p ON oi.t_product_pid = p.pid
            WHERE oi.t_order_oid = t_order.oid
        ),
        Amount = (
            SELECT SUM(oi.Qty * p.UnitPrice)
            FROM t_orderitems oi
            JOIN t_product p ON oi.t_product_pid = p.pid
            WHERE oi.t_order_oid = t_order.oid
        )
    WHERE oid = (
            SELECT t_order_oid
            FROM t_orderitems
            WHERE oid = @OrderItemID
        );
END;
GO
USE [master]
GO
ALTER DATABASE [PurchaseOrderDB] SET  READ_WRITE 
GO
