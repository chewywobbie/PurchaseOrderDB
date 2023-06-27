USE PurchaseOrderDB
GO


ALTER PROCEDURE SearchOrder
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

EXEC SearchOrder
   @CustomerID = 3, -- Replace with the desired customer ID or set to NULL
   @OrderDate = NULL, -- Replace with the desired order date or set to NULL
   @SortColumn = 'OrderID', -- Replace with the desired sorting column: 'OrderID', 'CustomerName', 'OrderDate'
   @SortOrder = 'ASC'; -- Replace with the desired sorting order: 'ASC' for ascending or 'DESC' for descending

EXEC SearchOrder @CustomerID = 2
EXEC SearchOrder @CustomerID = 6

EXEC SearchOrder @CustomerID = 1
EXEC SearchOrder @CustomerID = 2
EXEC SearchOrder @CustomerID = 3

EXEC SearchOrder @OrderDate = '2023-06-24'