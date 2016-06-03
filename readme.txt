
Owner:
	This folder is created by Rafy Zhao on May 12, 2016.

For:
	To hold the ASP source code for IP Guide Request Management.

Reference:
	1) requirement document:
	2) design document:

Flies related to this function but not in this folder:
	../adovbs.inc
	../assets/css/printReport.css

Files Description:
 * index.asp  		-- main page, 
 
 ** search.asp 		-- search page, click search button in main page will redirect here
 ** report.asp		-- report page, click report button in main page will redirect here
 ** add.asp		-- add client page, click add button in main page will redirect here
 
 *** FetchIPGuideList.asp	-- populate the IP request dropdown list in main page, fired when click the dropdown list
 *** editIPGuideRecord.asp	-- display edit page when 'Edit' link in the record list in main page is clicked
 *** updateIPGuideRecord.asp	-- update database of ip record, fired when checkbox changed in the edit page. 
 *** DelClientData.asp		-- delete the client record in database, fired when click 'Delete client' link in the record list in main page
 *** checkRep.asp		-- to check if the user has a Rep number in database

 *** FetchSearchSelect.asp	-- populate the 3 dropdown list in search page, fired when page loaded or when radio button clicked.
 *** queryIPRecord.asp		-- query the IP record, fired when 'Search' button clicked in search page.

 *** FetchReportData.asp	-- query and display the IP request in report page, it is included in the report.asp
 *** ExportReportData.asp	-- export the report to an Excel file, fired when 'Export' button clicked in report page

 *** AddClientData.asp		-- insert client data in database, fired when 'Confirm' button clicked in add page.

SQL Script:
 1. ipguide_create_table.sql	-- create data table for the project
 2. database_initial.sql	-- import the initial data into the database