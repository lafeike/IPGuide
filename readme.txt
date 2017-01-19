==================================================================================
Owner:
	This folder is created by Rafy Zhao on May 12, 2016.

For:
	To hold the ASP source code for IP Guide Request Management.

Reference:
	1) requirement document:
	2) design document:

Flies related to this function but not in this folder:[!!! Don't forget these files when deploy this project]
	../adovbs.inc
	../assets/css/printReport.css
	../assets/js/jquery.simulate.js
Version History:
	Version 1.5 -- Janauary 13, 2017
	Version 1.4 -- Janauary 10, 2017
	Version 1.3 -- December 12, 2016
	Version 1.2 -- Novermber 17, 2016
	Version 1.1 -- September 16, 2016
	Version 1.0 -- May 12, 2016
		
====================================================================================
Version: 	1.5 
	to improve user experience. (aroused by Paul)
Description:
•	When user edit IP Wish List, the table header keeps fixed in the positon while user scrolls the table content.
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Version: 	1.4 
	add 2 features to improve user experience. (aroused by Roxane)
Description:
•	When user check Dual Language, the system check the checkbox of Confirm automatically.
•	In Report, add column 'Dual Language'
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Version: 	1.3 
	In Convergence, there are 2 independent options that user can check: Legal Register or Checklist, which are different from 
	other ip types. In IPs, the option 'dual language' can be selected only when the user choose this IP resource. So the logic
	to save and display these options are different. 

Description:
•	in Table 'IPGuideRequestRecord', when IPType='Convergence', then dual_language is the index of the record type.
	- dual_language = 0, this is a 'checklist' request
	- dual_language = 1, this is a 'Legal Register' request
•	add editConvergence.asp, updateConvergence.asp to display and save the 'Convergence' type

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Version: 	1.2
•	Add ‘REG Tracking’ button,  and the related functionalities.  Users can list, edit, search and report the REG Tracking data now;
•	Make the ‘Contact’ and ‘REP’ columns editable. User can edit the contact and rep records in the IP request page;
•	Add a ‘report by company’ option in the Report page. Users can build reports by company besides by country now.
•	Some other minor changes, such as removing the dropdown list to accelerate page loading.

Description:	
	1. Add ‘REG Tracking’ button,  and the related functionalities:list, edit, search and report the REG Tracking data.
	2. Make the ‘Contact’ and ‘REP’ columns editable.
	3. Add a ‘report by company’ option in the Report page
	4. Some other minor changes, such as removing the dropdown list to accelerate page loading.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Version: 	1.1
Description:	
	1. Add REP number in the main page to display ip request.
	2. Add 'dual language' option in 'Edit IP Guide Request'
	3. improve code: 
		1) use DataTable to export excel
		2) get rid of FetchIPGuideList.asp, populating the IP request dropdown list when page is loaded.
		3) use Ajax to refresh page after 'Edit IP Guide Request'
Files affected:
	1. index.asp				-- many changes: add REP
	2. FetchIPGuideList.asp			-- 
	3. report.asp
	4. FetchReportData.asp
	5. editIPGuideRecord.asp
	6. updateDualLanguage.asp 		-- new file
	7. updateIPGuideRecord.asp
SQL Script:
	1. add 'dual_language(bit,null)' in table IPGuideRequestClient
	 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


************************************************************************************
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
************************************************************************************