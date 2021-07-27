/*
--cleaning data in sql queries
______________________________________________

select*
from portfolioproject.dbo.nashville


______________________________________________
--standardize Date format

Select saleDateconverted, CONVERT(Date,saleDate)
from portfolioproject.dbo.nashville

update Nashville
SET saledate = CONVERT(Date,saleDate)

ALTER TABLE nashville
Add SaleDateconverted Date;

update nashville
SET saledateconverted = CONVERT(Date,saleDate)
________________________________________________________________

--populate property address date

Select PropertyAddress
from portfolioproject.dbo.nashville
Where PropertyAddress is null

select*
from portfolioproject.dbo.nashville
Where PropertyAddress is null
order by ParcelID

select a.parcelID, a.propertyAddress, b.parcelID, b.propertyAddress, ISNULL (a.propertyAddress,b.propertyAddress)
from portfolioproject.dbo.nashville a
JOIN portfolioproject.dbo.nashville b
     on a.parcelID = b.parcelID
	 AND a. [uniqueID ] <> b.[uniqueID]
Where a. PropertyAddress is null


update a
SET propertyAddress = ISNULL(a.propertyAddress,b.propertyAddress)
from portfolioproject.dbo.nashville a
JOIN portfolioproject.dbo.nashville b
     on a.parcelID = b.parcelID
	 AND a. [uniqueID ] <> b.[uniqueID]

	 ____________________________________________________________________________________

	 ---Breaking out address into individual columns (Address, City , State)
	 

select PropertyAddress
from portfolioproject.dbo.nashville
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(propertyAddress,1, CHARINDEX(',', propertyAddress)-1 )as Address
, SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress)+1 , LEN(propertyAddress)) as Address
from portfolioproject.dbo.nashville


ALTER TABLE nashville
Add ProprtySplitAddress Nvarchar(255);

update nashville
SET ProprtySplitAddress = SUBSTRING(propertyAddress,1, CHARINDEX(',', propertyAddress)-1 )


ALTER TABLE nashville
Add PropSplitCity Nvarchar(255);

update nashville
SET PropertySplitCity = SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress)+1 , LEN(propertyAddress))


select*
from portfolioproject.dbo.nashville

ALTER TABLE nashville
Add OwnerSplitAddress Nvarchar(255);

update nashville
SET OwnerSplitAddress = SUBSTRING(propertyAddress,1, CHARINDEX(',', propertyAddress)-1 )


ALTER TABLE nashville
Add OwnerSplitCity Nvarchar(255);

update nashville
SET OwnerSplitState = SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress)+1 , LEN(propertyAddress))



ALTER TABLE nashville
Add PropertySplitCity Nvarchar(255);

update nashville
SET PropertySplitCity = SUBSTRING(propertyAddress, CHARINDEX(',', propertyAddress)+1 , LEN(propertyAddress))


______________________________________________________________________________________________________________________________

--CHANGE Y AND N to Yes and No in "sold as vacant' field


select Distinct(soldAsVacant) , count(soldAsVacant)
from portfolioproject.dbo.nashville
Group by SoldAsVacant
order by 2

Select soldAsVacant
, CASE When SoldAsVacant ='Y' THEN 'YES'
       when SoldAsVacant ='N' THEN 'NO'
	   ELSE SoldAsVacant
	   END
from portfolioproject.dbo.nashville


update nashville
SET SoldAsVacant =CASE When SoldAsVacant ='Y' THEN 'YES'
       when SoldAsVacant ='N' THEN 'NO'
	   ELSE SoldAsVacant
	   END


___________________________________________________________________________________________________________________________________________________________

---Remove Duplicates
Select*,
    ROW-NUMBER() OVER (
	PARTITION BY ParcelID,
	             ProprtyAddress,
				 Saleprice,
				 SaleDate,
				 LegalReference
				 ORDER BY
				   UniqueID
				   )row_num

from portfolioproject.dbo.nashville
order by parcelID
select*
from portfolioproject.dbo.nashville


______________________________________________________________________________________________________________________________________________________________

----Delete Unused columns


select*
from portfolioproject.dbo.nashville

ALTER TABLE portfolioproject.dbo.nashville
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SalesDate