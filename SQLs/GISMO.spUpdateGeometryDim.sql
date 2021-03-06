USE [CWRKS]
GO
/****** Object:  StoredProcedure [GISMO].[spUpdateGeometryDim]    Script Date: 4/8/2022 8:10:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Update azteca.Request set [TILENO] = , [MAPPAGE] = , [PROBDISTRICT] = 
--geometry::STGeomFromText('Point(' + convert(varchar(30), SRX) + ' ' + convert(varchar(30) , SRY) + ') ' , 3776)


ALTER Proc [GISMO].[spUpdateGeometryDim]
as

Begin
		


		--Update Tile No of SR with Legal Desc
		Update azteca.Request set [TILENO] = Q.Legal_Desc
		from azteca.Request R
		inner join Maint.RV.QSECTION Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.SRX) + ' ' + convert(varchar(30) , R.SRY) + ') ' , 3776) ) =1
		where SRX is not null and Len(TileNo) < 3


		--Update Tile No of WO with Legal Desc
		Update azteca.WORKORDER set [TILENO] = Q.Legal_Desc
		from azteca.WORKORDER R
		inner join Maint.RV.QSECTION Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.WOXCOORDINATE) + ' ' + convert(varchar(30) , R.WOYCOORDINATE) + ') ' , 3776) ) =1
		where R.WOXCOORDINATE is not null and R.WOYCOORDINATE is not null and Len(DISTRICT) < 3

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--Update District of SR with Electoral Division
		Update azteca.Request set [PROBDISTRICT] = 'Division ' + Q.vchDivision
		from azteca.Request R
		inner join Maint.RV.ELECTORALDIVISIONS Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.SRX) + ' ' + convert(varchar(30) , R.SRY) + ') ' , 3776) ) =1
		where SRX is not null and Len(PROBDISTRICT) < 3 


		--Update District of WO with Electoral Division
		Update azteca.WORKORDER set [DISTRICT] = 'Division ' + Q.vchDivision
		from azteca.WORKORDER R
		inner join Maint.RV.ELECTORALDIVISIONS Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.WOXCOORDINATE) + ' ' + convert(varchar(30) , R.WOYCOORDINATE) + ') ' , 3776) ) =1
		where WOXCOORDINATE is not null and Len(DISTRICT) < 3

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------		

		--Update [MAPPAGE] of SR
		Update azteca.Request set MAPPAGE = Q.vchSubdivision
		from azteca.Request R
		inner join Maint.RV.NEIGHBORHOODBOUNDARIES Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.SRX) + ' ' + convert(varchar(30) , R.SRY) + ') ' , 3776) ) =1
		where SRX is not null and len(Mappage) < 3


		--Update [MAPPAGE] of WO
		Update azteca.WorkOrder set MAPPAGE = Q.vchSubdivision
		from azteca.WORKORDER R
		inner join Maint.RV.NEIGHBORHOODBOUNDARIES Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.WOXCOORDINATE) + ' ' + convert(varchar(30) , R.WOYCOORDINATE) + ') ' , 3776) ) =1
		where WOXCOORDINATE is not null and len(Mappage) < 3

	
		--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

		--Update District of SR with Electoral Division
		Update azteca.Request set SHOP = 'Quadrant ' + Convert(varchar(3) ,Q.Quadrant)
		from azteca.Request R
		inner join Maint.RV.QUADRANT Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.SRX) + ' ' + convert(varchar(30) , R.SRY) + ') ' , 3776) ) =1
		where SRX is not null and Len(Shop) < 3


		--Update District of WO with Electoral Division
		Update azteca.WORKORDER set SHOP = 'Quadrant ' + Convert(varchar(3) ,Q.Quadrant)
		from azteca.WORKORDER R
		inner join Maint.RV.QUADRANT Q 
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.WOXCOORDINATE) + ' ' + convert(varchar(30) , R.WOYCOORDINATE) + ') ' , 3776) ) =1
		where WOXCOORDINATE is not null and Len(Shop) < 3

		---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



		--Update District of SR with Township
		Update azteca.Request set FACILITY_ID = 'TWP ' + Convert(varchar(3) ,Q.strTownshipNum)
		from azteca.Request R
		inner join Build.RV.TOWNSHIP Q
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.SRX) + ' ' + convert(varchar(30) , R.SRY) + ') ' , 3776) ) =1
		where SRX is not null --and Len(FACILITY_ID) < 3


		--Update District of WO with Township
		Update azteca.WORKORDER set FACILITY_ID = 'TWP ' + Convert(varchar(3) ,Q.strTownshipNum)
		from azteca.WORKORDER R
		inner join Build.RV.TOWNSHIP Q
		on Q.Shape.STIntersects(geometry::STGeomFromText('Point(' + convert(varchar(30), R.WOXCOORDINATE) + ' ' + convert(varchar(30) , R.WOYCOORDINATE) + ') ' , 3776) ) =1
		where WOXCOORDINATE is not null --and Len(FACILITY_ID) < 3




End







