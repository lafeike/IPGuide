/*
date:	June 2, 2016
author:	Rafy Zhao
for:	initialize database for IP Country Request project
data source: IP Guide Requests from Clients - October 2014 updated March 2016.xls [from Gail]
*/


use stp_online;

-- 1. clear all table
DELETE FROM IPguiderequestRecord
DBCC CHECKIDENT (IPguiderequestRecord, RESEED, 1)

DELETE FROM IPGuideRep

DELETE FROM IPguideRequestClient
DBCC CHECKIDENT (IPguideRequestClient, RESEED, 1)

DELETE FROM IPGuide
DBCC CHECKIDENT (IPGuide, RESEED, 1)


-- 2. Rep data
	-- Rep: 59, 84, 89, 188, 253, 278, 458, 717, 732, 733, 735, 736, 737, 740; 9999(for test)
	-- cannot find userid for thest REP: 59, 84, 253, 278, 458, 737 
insert into IPGuideRep(userid, rep) values(412, '89'); -- Lee Ferris
insert into IPGuideRep(userid, rep) values(438, '188'); -- Valerie Clark
insert into IPGuideRep(userid, rep) values(422, '717'); -- Gail Ankiewicz
insert into IPGuideRep(userid, rep) values(2325, '732'); -- Brigit Seppke
insert into IPGuideRep(userid, rep) values(467, '733'); -- Libbie Robinson
insert into IPGuideRep(userid, rep) values(908, '735'); -- Robert Stuart
insert into IPGuideRep(userid, rep) values(909, '736'); -- Barbra Newton
insert into IPGuideRep(userid, rep) values(3328, '740'); -- Leon Chabot
insert into IPGuideRep(userid, rep) values(8191, '9999'); -- Rafy Zhao for test only

-- 3. IP Resource data
	--1)Industry Specific data:  
	-- Coast Guard	Waste	Energy / Renewables / Carbon	Mining (MSHA)	Global Mining Regulations (International)	Warehousing	DHS Standards (Dept. of Homeland Security)	FDA	ISO 22 000	Manufacturing	Chemicals	Utilities	Pharmaceuticals	General	Air Quality	Paper & Pulp	ISO 50,0001	Wind	Solar	Coal	Nuclear	Gas	Petroleum	Electricity	On Shore	Off Shore	OilGas Canada	Pipeline Safety (Canada)	Upstream	Drilling	Wells	Ship Building	OSHA -shipyard enmployment/ship breaking 1915	Longshoring (1917)	Marine Terminals  (1918)			Social Responsibility Investing Checklists
insert into IPGuide(IPName,iptype) values
('Coast Guard', 'Industry Specific'), ('Waste', 'Industry Specific'), 
('Energy / Renewables / Carbon', 'Industry Specific'), ('Mining (MSHA)', 'Industry Specific'), 
('Global Mining Regulations (International)', 'Industry Specific'), ('Warehousing', 'Industry Specific'), 
('DHS Standards (Dept. of Homeland Security)', 'Industry Specific'), ('FDA', 'Industry Specific'), 
('ISO 22000', 'Industry Specific'), ('Manufacturing', 'Industry Specific'), ('Chemicals', 'Industry Specific'), 
('Utilities', 'Industry Specific'), ('Pharmaceuticals', 'Industry Specific'), ('General', 'Industry Specific'), 
('Air Quality', 'Industry Specific'), ('Paper & Pulp', 'Industry Specific'), ('ISO 50,0001', 'Industry Specific'), 
('Wind', 'Industry Specific'), ('Solar', 'Industry Specific'), ('Coal', 'Industry Specific'), ('Nuclear', 'Industry Specific'), 
('Gas', 'Industry Specific'), ('Petroleum', 'Industry Specific'), ('Electricity', 'Industry Specific'), 
('On Shore', 'Industry Specific'), ('Off Shore', 'Industry Specific'), ('OilGas Canada', 'Industry Specific'), 
('Pipeline Safety (Canada)', 'Industry Specific'), ('Upstream', 'Industry Specific'), ('Drilling', 'Industry Specific'), 
('Wells', 'Industry Specific'), ('Ship Building', 'Industry Specific'), ('OSHA -shipyard enmployment/ship breaking 1915', 'Industry Specific'),
 ('Longshoring (1917)', 'Industry Specific'), ('Marine Terminals  (1918)', 'Industry Specific'), 
 ('Social Responsibility Investing Checklists', 'Industry Specific');

	--2) IP's data:
	-- Algiers*Afganistan*Angola*Austria*Bahrain*Bangladesh*Belgium-Brussels*Belgium-Federal*Belgium-Flanders*Belgium-Wallonia*Bosnia*Bulgaria*Cambodia*Cameroon*Canada Quebec (in French)*Canada NB*Canada MT*Canada SK*Canada MB*Canada BC*Canada PEI*Canada NS*Canada NWT*Canada-NF& LB*Canada-Alberta*Chile*Columbia*Costa Rica*Croatia*Cyprus*Czech*Denmark*Dominican Republic*Egypt*El Salvador*Ecuador*Ethiopia*Eastonia*Finland*Georgia*Ghana*Guam*Greece*Holland*Honduras*Hong Kong*Hungary*Israel*Iraq*Iran*Jordan*Kazakhstan*Kenya*Khuzestan*Korea*Kurdistan*Kuwait*Kyrgyzstan*Latvia*Lebanon*Libya*Le Reunion*Lithuania*LuXmbourg*Marshall Island*Mongolia*Morocco*Myanmar*New Zealand*Nigeria*Northern Ireland*Norway*Oman*Pakistan *Paraguay*Panama*Papua New Guinea*Peru*Phillipines*Portugal*Qatar*Rwanda*Romania*Saskatchewan*Saudi Arabia*Senegal*Serbia*Slovakia*Slovenia*Sri Lanka*Switzerland*Sweden*Syria*Taiwan*Tanzania*Tunisia*Trinidad*Turkey*Ukraine*United Arab Em.*Uruguay*Venezuela*Vietnam*Yemen
insert into IPGuide(IPName,iptype) values
('Algiers', 'IP''s'), ('Afganistan', 'IP''s'), ('Angola', 'IP''s'), ('Austria', 'IP''s'), ('Bahrain', 'IP''s'), 
('Bangladesh', 'IP''s'), ('Belgium-Brussels', 'IP''s'), ('Belgium-Federal', 'IP''s'), ('Belgium-Flanders', 'IP''s'), 
('Belgium-Wallonia', 'IP''s'), ('Bosnia', 'IP''s'), ('Bulgaria', 'IP''s'), ('Cambodia', 'IP''s'), ('Cameroon', 'IP''s'), 
('Canada Quebec (in French)', 'IP''s'), ('Canada NB', 'IP''s'), ('Canada MT', 'IP''s'), ('Canada SK', 'IP''s'), 
('Canada MB', 'IP''s'), ('Canada BC', 'IP''s'), ('Canada PEI', 'IP''s'), ('Canada NS', 'IP''s'), ('Canada NWT', 'IP''s'), 
('Canada-NF& LB', 'IP''s'), ('Canada-Alberta', 'IP''s'), ('Chile', 'IP''s'), ('Columbia', 'IP''s'), 
('Costa Rica', 'IP''s'), ('Croatia', 'IP''s'), ('Cyprus', 'IP''s'), ('Czech', 'IP''s'), ('Denmark', 'IP''s'), 
('Dominican Republic', 'IP''s'), ('Egypt', 'IP''s'), ('El Salvador', 'IP''s'), ('Ecuador', 'IP''s'), ('Ethiopia', 'IP''s'), 
('Eastonia', 'IP''s'), ('Finland', 'IP''s'), ('Georgia', 'IP''s'), ('Ghana', 'IP''s'), ('Guam', 'IP''s'), ('Greece', 'IP''s'), 
('Holland', 'IP''s'), ('Honduras', 'IP''s'), ('Hong Kong', 'IP''s'), ('Hungary', 'IP''s'), ('Israel', 'IP''s'), ('Iraq', 'IP''s'), 
('Iran', 'IP''s'), ('Jordan', 'IP''s'), ('Kazakhstan', 'IP''s'), ('Kenya', 'IP''s'), ('Khuzestan', 'IP''s'), ('Korea', 'IP''s'), 
('Kurdistan', 'IP''s'), ('Kuwait', 'IP''s'), ('Kyrgyzstan', 'IP''s'), ('Latvia', 'IP''s'), ('Lebanon', 'IP''s'), ('Libya', 'IP''s'),
 ('Le Reunion', 'IP''s'), ('Lithuania', 'IP''s'), ('LuXmbourg', 'IP''s'), ('Marshall Island', 'IP''s'), ('Mongolia', 'IP''s'), 
 ('Morocco', 'IP''s'), ('Myanmar', 'IP''s'), ('New Zealand', 'IP''s'), ('Nigeria', 'IP''s'), ('Northern Ireland', 'IP''s'), 
 ('Norway', 'IP''s'), ('Oman', 'IP''s'), ('Pakistan ', 'IP''s'), ('Paraguay', 'IP''s'), ('Panama', 'IP''s'), ('Papua New Guinea', 'IP''s'), 
 ('Peru', 'IP''s'), ('Phillipines', 'IP''s'), ('Portugal', 'IP''s'), ('Qatar', 'IP''s'), ('Rwanda', 'IP''s'), ('Romania', 'IP''s'), 
 ('Saskatchewan', 'IP''s'), ('Saudi Arabia', 'IP''s'), ('Senegal', 'IP''s'), ('Serbia', 'IP''s'), ('Slovakia', 'IP''s'),
  ('Slovenia', 'IP''s'), ('Sri Lanka', 'IP''s'), ('Switzerland', 'IP''s'), ('Sweden', 'IP''s'), ('Syria', 'IP''s'),
   ('Taiwan', 'IP''s'), ('Tanzania', 'IP''s'), ('Tunisia', 'IP''s'), ('Trinidad', 'IP''s'), ('Turkey', 'IP''s'), 
   ('Ukraine', 'IP''s'), ('United Arab Em.', 'IP''s'), ('Uruguay', 'IP''s'), ('Venezuela', 'IP''s'), ('Vietnam', 'IP''s'), 
   ('Yemen', 'IP''s' );

	--3) Mining data:
-- Australia	Western Australia	Finland	Turkey	Zambia	Mauritania	Spain	Panama	Peru	Argentina	Dominican Republic	USA	Canada	Japan	China	Korea	India	Afghanistan	Kazakhstan	Guinea	Zimbabwe	South Africa	Mexico	UAE	Brazil	Ireland		
insert into IPGuide(IPName,iptype) values
('Australia', 'Mining'), 
('Western Australia', 'Mining'), 
('Finland', 'Mining'), 
('Turkey', 'Mining'), 
('Zambia', 'Mining'), 
('Mauritania', 'Mining'), 
('Spain', 'Mining'), 
('Panama', 'Mining'), ('Peru', 'Mining'), ('Argentina', 'Mining'), ('Dominican Republic', 'Mining'), 
('USA', 'Mining'), ('Canada', 'Mining'), ('Japan', 'Mining'), ('China', 'Mining'), 
('Korea', 'Mining'), ('India', 'Mining'), ('Afghanistan', 'Mining'), 
('Kazakhstan', 'Mining'), ('Guinea', 'Mining'), ('Zimbabwe', 'Mining'), 
('South Africa', 'Mining'), ('Mexico', 'Mining'), ('UAE', 'Mining'), ('Brazil', 'Mining'), ('Ireland', 'Mining');


	--4) ISO data:
-- ISO 1540-Lifestyle Assessment	ISO 22000-Food Safe	ISO 37000-Risk Management	  ISO 50,0001	 
insert into IPGuide(IPName,iptype) 
values
('ISO 1540-Lifestyle Assessment', 'ISO'),	
('ISO 22000-Food Safe', 'ISO'),	
('ISO 37000-Risk Management', 'ISO'),	  
('ISO 50,0001', 'ISO');

	--5) Convergence:
-- New Zealand, Pakistan, Vietnam, Hungary, Czech Republic, Slovakia, Greece, Columbia
insert into IPGuide(IPName,iptype) values
('New Zealand', 'Convergence'), ('Pakistan', 'Convergence'), ('Vietnam', 'Convergence'), 
('Hungary', 'Convergence'), ('Czech Republic', 'Convergence'), ('Slovakia', 'Convergence'), 
('Greece', 'Convergence'), ('Columbia', 'Convergence');

-- 3. import client data to IPguideRequestClient
	--1) client in Industry Specific sheet
--Charles Riverlab	Phillip Clemons		978 658 6000														
--Clark Health																																			
--General Electric	McKund		513 774 1004																										
--Goodyear	Dave Woodring		330 796 0565																										
--Bridgestone	Debra Rollins		615 937 1000																										
--Chevron Phillips	Rick Lemons		832 813 4222																										
--Veoliaes	Kevin McGrath		402 991 6666																										
--Waste Connection	Tom Riley		925 672 3800																										
--Wastequip	Rick Daudert 		1800 645 7106 x116																										
--Talisman Energy	Ted Jones		403 237 1371																										
--Wood Group	Jeff Bieghle/ Larry Watrous																								 	 			
--Fibrek	JP Benoite	458	450 677 7857																												
--RMT	Kristy Stewart	89	713 358 6862																									 	 		
--Maersk	Blake Harmon	188/717																										 	 			
--Corn Products	Bruce Hendrik	188																														
--Baytex	John Kemdrik	458/717	587 952 3000																										
--Bay Ship Building	Glen Nelson																															
--P & H Mine Pro	Nick Vranak	730	414 670 7960																										
--Nippon Express	William Tanaka	89	310-535-7297																									
--Nike		733																																			
--Avon		733																																			
--Borden Ladner Gervais	David Farmer	89																												
--Tervita	Shad Watts	89																																
--AIL Mining		89																																	
--Propak	Deb Hlushak	733																																
--Texas United		732																																	
--The Benteler Group		735																															
--Luminant	Gene Rek	730/188																															
--US Silica		735																																		
--Fenner Dunlop		735																																	
--Vertellus		733																																		
--Osler, Hoskins & Harcourt LLP	Martin Tomlinson	736																								
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Charles Riverlab', 'Phillip Clemons', '', '978 658 6000');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Clark Health', '', '', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('General Electric', 'McKund', '', '513 774 1004');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Goodyear', 'Dave Woodring', '', '330 796 0565');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Bridgestone', 'Debra Rollins', '', '615 937 1000');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Chevron Phillips', 'Rick Lemons', '', '832 813 4222');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Veoliaes', 'Kevin McGrath', '', '402 991 6666');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Waste Connection', 'Tom Riley', '', '925 672 3800');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Wastequip', 'Rick Daudert ', '', '1800 645 7106 x116');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Talisman Energy', 'Ted Jones', '', '403 237 1371');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Wood Group', 'Jeff Bieghle/ Larry Watrous', '', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Fibrek', 'JP Benoite', '458', '450 677 7857');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('RMT', 'Kristy Stewart', '89', '713 358 6862');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Maersk', 'Blake Harmon', '188/717', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Corn Products', 'Bruce Hendrik', '188', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Baytex', 'John Kemdrik', '458/717', '587 952 3000');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Bay Ship Building', 'Glen Nelson', '', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('P & H Mine Pro', 'Nick Vranak', '730', '414 670 7960');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Nippon Express', 'William Tanaka', '89', '310-535-7297');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Nike', '', '733', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Avon', '', '733', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Borden Ladner Gervais', 'David Farmer', '89', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Tervita', 'Shad Watts', '89','');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('AIL Mining', '', '89', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Propak', 'Deb Hlushak', '733','');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Texas United', '', '732', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('The Benteler Group', '', '735','');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Luminant', 'Gene Rek', '730/188', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('US Silica', '', '735','');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Fenner Dunlop', '', '735', '');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Vertellus', '', '733','');
insert into IPGuideRequestClient (clientname,contact_firstname,rep,contact_number) values('Osler, Hoskins & Harcourt LLP', 'Martin Tomlinson', '736', '');														
	--2) client in IP's
	/*
	CLIENT	CONTACT NAME	Rep
Polaris Seismic Int		188
Parker Drilling		188
Agrium	Jack MacGregor	736
Calfrac Well Services	Bob Brownlee	188
Teva Pharma		717
Calmena	Ralf Deweerd	458
		
Juniper Networks	David Aplund	717
Carnegie Mellon uni	Jefferey Harris	717/188
Sempra	Jaime Orozco	188/732
TRC		
Barrick Gold		736
Siemens		188
Nova chemical		188
Clorox		188
SNC Lavalin		458
		
Williams Energy	AleXs Rojas	188
Centerra Gold	Gorgon Reid	458
Antea Group(Delta Consult)	Daniel Pierce 	188
Konecranes	Greg Dougherty 	188
MacAndrews & Forbes Holding inc		717
Deloitte		717
Ernst & Young		717
Transcanada Pipeline		736
Direct Energy		717
Banda Group		717
Solar Turbines		717
John Crane		89
AON		717
CHS Inc		717
Saint Gobain Norpro		717
		
Centerra Gold, Toronto Ontario	Gary Tipper	458
Pika International Inc	Srini Neraha	278
Fruit of the Loom	Barbara Veith 	732
Transalta		188
Chevron	Scott Haney	188
Invista	Judith Ciulis	188
Gates International (Corp.)	Ron Stiles	188
Norbrook Labs	Stephen Mitchell	188
CF Industires	Elizabeth Paredes	732
Styrolution		188
Devon Energy		188
Hanes		188
Fenwel	Arlene Farrar	188
Lubrizol	Dan Issacson	717
		
URS		
Avery Dennison	Scott Snyder	717
McMahon&Degullis (STC Client)	Melanie @ STC	717
Chevron Phillips	Jerry Smith	188
Sealed Air	David Day	732
		
Delphi Corporation	Salish Patel	735
Hoffman LaRoche	Bob Moody	188
Hoffman LaRoche	Johannes Pudewell	188
Environ	Christine Anastos	188
Environ	Nina Cross	188
Occidental Petroleum	Chris Young/Matt Barmasse	188
Parker Drilling		188
HESS Corporation	Mark Fox	732
Chevron		188
Redco Construction		736
Seagate	Rose Khan 	717/732
VanBreusegen & Associates		188
Danaher Corp.	Diana Cosgrove	717/736
EXlis		188
		
Mosaic	Elizabeth Guse	188
AGC Glass		188
Jarden		188
MeadWestvaco		736
		
Dresser Rand	Greg Stubs	735
Ecolab	Laura Schaffer	736
Ecolab	Gary Williams	736
		
Smith Management Group	Clayton Whitney	89
Borden Ladner Gervais	David Farmer	89
GE	Gretchen Hancock	89
Jost Chemical	Jim Moore	188
Axalta	Jill Henry	736
Agrium	Jack MacGregor	736
Atlas Copco	VJ	
Schneider Electric	Bryce Wendland/Kent Chai	735
Williams Energy Services	Mark Gebbia	188
Air Products		735
Hayes Lemmerz	Michael Coffman	188
Panasonic - Japan	Risa Onishi	89
Remy International	Dean Glenn	188
MEG Energy	Allyson Kaybidge	732
Cabot Corp.	Rich D'Ermilio	732
Rolls Royce		188
		
Tetra Tech		89
Tervita	Shad Watts	89
Parkland Pipeline		89
		
GlaxoSmithKline	Alexander Akpieyi	717
		
Amec		717
Beam Global Spirits		188/717
GWL Realty Advisors		89
Gulf Drilling International	Andrew Scarry	89
RPS Group		89
Cardinal Health	Jim Cline	732
ERM Calgary		89
Momentive Performance Materials	Sergio Vanalli	188
Asco Aerospace	Tim Wilson	89
		
		
General Mills	Ty Oberlin	89
North American Terminal Services	Cindy Van Duyne	188
Merck	Warren Bird	732
Clifton Associates		89
Hologic		188
Exxon Mobil	Adam Cantu	188
		
Arrmaz Custom Chemicals	Ron Thomas	188
Sikorsky Aircraft		89
Concurrent Technologies Corp.	Chris Cox	188
Textron		188
Columbian Chemicals	Larry Schelindflug	732
Ashland	Blair Norris	736
InterOil Corporation		89
RPM International		89
Xylem	Luis Salinas	188
	*/
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Polaris Seismic Int', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Parker Drilling', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Agrium', 'Jack MacGregor', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Calfrac Well Services', 'Bob Brownlee', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Teva Pharma', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Calmena', 'Ralf Deweerd', '458');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Juniper Networks', 'David Aplund', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Carnegie Mellon uni', 'Jefferey Harris', '717/188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Sempra', 'Jaime Orozco', '188/732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('TRC', '', '');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Barrick Gold', '', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Siemens', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Nova chemical', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Clorox', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('SNC Lavalin', '', '458');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Williams Energy', 'AleXs Rojas', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Centerra Gold', 'Gorgon Reid', '458');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Antea Group(Delta Consult)', 'Daniel Pierce ', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Konecranes', 'Greg Dougherty ', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('MacAndrews & Forbes Holding inc', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Deloitte', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Ernst & Young', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Transcanada Pipeline', '', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Direct Energy', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Banda Group', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Solar Turbines', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('John Crane', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('AON', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('CHS Inc', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Saint Gobain Norpro', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Centerra Gold, Toronto Ontario', 'Gary Tipper', '458');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Pika International Inc', 'Srini Neraha', '278');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Fruit of the Loom', 'Barbara Veith ', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Transalta', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Chevron', 'Scott Haney', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Invista', 'Judith Ciulis', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Gates International (Corp.)', 'Ron Stiles', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Norbrook Labs', 'Stephen Mitchell', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('CF Industires', 'Elizabeth Paredes', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Styrolution', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Devon Energy', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Hanes', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Fenwel', 'Arlene Farrar', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Lubrizol', 'Dan Issacson', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('URS', '', '');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Avery Dennison', 'Scott Snyder', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('McMahon&Degullis (STC Client)', 'Melanie @ STC', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Chevron Phillips', 'Jerry Smith', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Sealed Air', 'David Day', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Delphi Corporation', 'Salish Patel', '735');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Hoffman LaRoche', 'Bob Moody', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Hoffman LaRoche', 'Johannes Pudewell', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Environ', 'Christine Anastos', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Environ', 'Nina Cross', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Occidental Petroleum', 'Chris Young/Matt Barmasse', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Parker Drilling', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('HESS Corporation', 'Mark Fox', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Chevron', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Redco Construction', '', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Seagate', 'Rose Khan ', '717/732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Van Breusegen & Associates', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Danaher Corp.', 'Diana Cosgrove', '717/736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('EXlis', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Mosaic', 'Elizabeth Guse', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('AGC Glass', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Jarden', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Mead Westvaco', '', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Dresser Rand', 'Greg Stubs', '735');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Ecolab', 'Laura Schaffer', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Ecolab', 'Gary Williams', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Smith Management Group', 'Clayton Whitney', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Borden Ladner Gervais', 'David Farmer', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('GE', 'Gretchen Hancock', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Jost Chemical', 'Jim Moore', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Axalta', 'Jill Henry', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Agrium', 'Jack MacGregor', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Atlas Copco', 'VJ', '');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Schneider Electric', 'Bryce Wendland/Kent Chai', '735');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Williams Energy Services', 'Mark Gebbia', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Air Products', '', '735');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Hayes Lemmerz', 'Michael Coffman', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Panasonic - Japan', 'Risa Onishi', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Remy International', 'Dean Glenn', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('MEG Energy', 'Allyson Kaybidge', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Cabot Corp.', 'Rich D''Ermilio', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Rolls Royce', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Tetra Tech', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Tervita', 'Shad Watts', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Parkland Pipeline', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Glaxo Smith Kline', 'Alexander Akpieyi', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Amec', '', '717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Beam Global Spirits', '', '188/717');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('GWL Realty Advisors', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Gulf Drilling International', 'Andrew Scarry', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('RPS Group', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Cardinal Health', 'Jim Cline', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('ERM Calgary', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Momentive Performance Materials', 'Sergio Vanalli', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Asco Aerospace', 'Tim Wilson', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('General Mills', 'Ty Oberlin', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('North American Terminal Services', 'Cindy Van Duyne', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Merck', 'Warren Bird', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Clifton Associates', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Hologic', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Exxon Mobil', 'Adam Cantu', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Arrmaz Custom Chemicals', 'Ron Thomas', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Sikorsky Aircraft', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Concurrent Technologies Corp.', 'Chris Cox', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Textron', '', '188');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Columbian Chemicals', 'Larry Schelindflug', '732');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Ashland', 'Blair Norris', '736');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('InterOil Corporation', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('RPM International', '', '89');
insert into IPGuideRequestClient(clientname,contact_firstname,rep)values('Xylem', 'Luis Salinas', '188');

	--3) client data in Mining sheet
	/*
	CLIENT	CONTACT NAME	Rep
Orica	Jeff Wilman	732
First Quantum Minerals Ltd.	Christopher Scholl	740
GE (Mining)	Bruce Adler/Geoff Knox	89
ERM	Karen Claussen	89
AIL Mining	Tim Dexter	89
P&H Mining		89/188
T&M Associates	Jim Alvarez	89
AECOM	John Nagy	89
CB&I	Kent Kading	89
Oman Oil Company / OXEA		89
RPS Group	Rob Larson	89
Fordia	Luc Arnaldi	

	*/
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('Orica', 'Jeff Wilman', '732');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('First Quantum Minerals Ltd.', 'Christopher Scholl', '740');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('GE (Mining)', 'Bruce Adler/Geoff Knox', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('ERM', 'Karen Claussen', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('AIL Mining', 'Tim Dexter', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('P&H Mining', '', '89/188');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('T&M Associates', 'Jim Alvarez', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('AECOM', 'John Nagy', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('CB&I', 'Kent Kading', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('Oman Oil Company / OXEA', '', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('RPS Group', 'Rob Larson', '89');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('Fordia', 'Luc Arnaldi', '');

	--4 client in ISO sheet
	/*
	CLIENT	CONTACT NAME	Rep
Uni Toronto	Edwin Tam	717
The Benteler Group		735
	*/
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('Uni Toronto', 'Edwin Tam', '717');
insert into IPGuideRequestClient(clientname, contact_firstname,rep)values('The Benteler Group', '', '735');

	--5 client in Convergence sheet
	/*
	Company	Contact	Rep
Henry Schein		Lee
Target		Lee
DTZ		Lee
Abbott Laboratories		Lee
	*/
	insert into IPGuideRequestClient(clientname,rep)values('Henry Schein', '89');
	insert into IPGuideRequestClient(clientname,rep)values('Target', '89');
	insert into IPGuideRequestClient(clientname,rep)values('DTZ', '89');
	insert into IPGuideRequestClient(clientname,rep)values('Abbott Laboratories', '89');

-- 4 import request record data

	--1) IP's request
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Polaris Seismic Int' ) cl where ip.ipname in('Mongolia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Parker Drilling' ) cl where ip.ipname in('Iraq', 'Kazakhstan', 'Khuzestan', 'PapuaNewGuinea', 'Trinidad') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Agrium' ) cl where ip.ipname in('CanadaSK', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Calfrac WellServices' ) cl where ip.ipname in('CanadaSK', 'Canada-Alberta', 'Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Teva Pharma' ) cl where ip.ipname in('Chile', 'Peru', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Calmena' ) cl where ip.ipname in('Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Juniper Networks' ) cl where ip.ipname in('Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Carnegie Mellonuni' ) cl where ip.ipname in('SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Sempra' ) cl where ip.ipname in('Chile', 'Peru') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='TRC' ) cl where ip.ipname in('Trinidad') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Barrick Gold' ) cl where ip.ipname in('Pakistan', 'Peru', 'Tanzania') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Siemens' ) cl where ip.ipname in('SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Novachemical' ) cl where ip.ipname in('Chile') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Clorox' ) cl where ip.ipname in('') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='SNCLavalin' ) cl where ip.ipname in('Algiers', 'Columbia', 'Kenya', 'Libya', 'Nigeria') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Williams Energy' ) cl where ip.ipname in('Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Centerra Gold' ) cl where ip.ipname in('Mongolia', 'Pakistan') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='AnteaGroup(DeltaConsult)' ) cl where ip.ipname in('Hungary', 'Romania') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Konecranes' ) cl where ip.ipname in('Chile', 'Columbia', 'Peru') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='MacAndrews&ForbesHoldinginc' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Deloitte' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Ernst & Young' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Transcanada Pipeline' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Direct Energy' ) cl where ip.ipname in('CanadaSK') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Banda Group' ) cl where ip.ipname in('Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Solar Turbines' ) cl where ip.ipname in('Czech') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='John Crane' ) cl where ip.ipname in('') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='AON' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia', 'Chile') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='CHS Inc' ) cl where ip.ipname in('Ukraine') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Saint Gobain Norpro' ) cl where ip.ipname in('Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='CenterraGold, TorontoOntario' ) cl where ip.ipname in('Kyrgyzstan', 'Mongolia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='PikaInternational Inc' ) cl where ip.ipname in('Kuwait') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Fruit of the Loom' ) cl where ip.ipname in('ElSalvador', 'Honduras') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Transalta' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Chevron' ) cl where ip.ipname in('Peru', 'SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Invista' ) cl where ip.ipname in('Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Gates International(Corp.)' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia', 'Czech', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Norbrook Labs' ) cl where ip.ipname in('Czech', 'Kenya') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='CFIndustires' ) cl where ip.ipname in('') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Styrolution' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Devon Energy' ) cl where ip.ipname in('CanadaSK', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Hanes' ) cl where ip.ipname in('CostaRica', 'DominicanRepublic', 'ElSalvador', 'Honduras', 'SriLanka', 'Vietnam') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Fenwel' ) cl where ip.ipname in('Austria', 'Belgium-Flanders', 'DominicanRepublic', 'Tunisia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Lubrizol' ) cl where ip.ipname in('Belgium-Flanders', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='URS' ) cl where ip.ipname in('Guam') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Avery Dennison' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia', 'Czech', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='McMahon&Degullis(STCClient)' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Chevron Phillips' ) cl where ip.ipname in('Belgium-Wallonia', 'Qatar', 'SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Sealed Air' ) cl where ip.ipname in('Columbia', 'Israel', 'NewZealand', 'Portugal', 'Taiwan', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Delphi Corporation' ) cl where ip.ipname in('Austria', 'Belgium-Flanders', 'Belgium-Wallonia', 'Czech', 'Hungary', 'LuXmbourg', 'Morocco', 'Portugal', 'Romania', 'Slovakia', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Hoffman LaRoche' ) cl where ip.ipname in('Norway', 'Panama', 'Peru', 'Uruguay', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Hoffman LaRoche' ) cl where ip.ipname in('Vietnam') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Environ' ) cl where ip.ipname in('Georgia', 'Oman', 'Peru') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Environ' ) cl where ip.ipname in('Denmark', 'Sweden') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Occidental Petroleum' ) cl where ip.ipname in('Chile', 'Oman', 'Qatar') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Parker Drilling' ) cl where ip.ipname in('Columbia', 'Czech', 'Egypt', 'Holland', 'Iraq', 'Kazakhstan', 'Kurdistan', 'PapuaNewGuinea', 'SaudiArabia', 'Trinidad', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='HESS Corporation' ) cl where ip.ipname in('Denmark') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Chevron' ) cl where ip.ipname in('Qatar') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Redco Construction' ) cl where ip.ipname in('Qatar') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Seagate' ) cl where ip.ipname in('Belgium-Flanders') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Van Breusegen & Associates' ) cl where ip.ipname in('CostaRica', 'Trinidad', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Danaher Corp.' ) cl where ip.ipname in('Belgium-Flanders', 'Czech', 'Denmark', 'Norway', 'Slovakia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='EXlis' ) cl where ip.ipname in('Afganistan', 'Iraq', 'Qatar') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Mosaic' ) cl where ip.ipname in('Saskatchewan') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='AGC Glass' ) cl where ip.ipname in('Saskatchewan') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Jarden' ) cl where ip.ipname in('Chile', 'Columbia', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Mead Westvaco' ) cl where ip.ipname in('Czech', 'Hungary') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Dresser Rand' ) cl where ip.ipname in('Angola', 'Morocco', 'Nigeria', 'Norway', 'SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Ecolab' ) cl where ip.ipname in('Angola', 'DominicanRepublic', 'Korea', 'Nigeria', 'Phillipines', 'Qatar', 'Slovenia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Ecolab' ) cl where ip.ipname in('Canada-Alberta', 'Ecuador') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Smith Management Group' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Borden Ladner Gervais' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='GE' ) cl where ip.ipname in('') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Jost Chemical' ) cl where ip.ipname in('Belgium-Flanders') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Axalta' ) cl where ip.ipname in('Belgium-Flanders', 'Turkey', 'Venezuela') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Agrium' ) cl where ip.ipname in('CanadaMT', 'CanadaSK') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Atlas Copco' ) cl where ip.ipname in('Belgium-Flanders', 'Belgium-Wallonia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Schneider Electric' ) cl where ip.ipname in('Algiers', 'Austria', 'Bahrain', 'Bangladesh', 'Belgium-Flanders', 'Belgium-Wallonia', 'Bosnia', 'Bulgaria', 'Cambodia', 'Cameroon', 'CanadaNB', 'CanadaMT', 'CanadaSK', 'CanadaPEI', 'CanadaNWT', 'Canada-NF&LB', 'Canada-Alberta', 'Chile', 'Columbia', 'CostaRica', 'Croatia', 'Cyprus', 'Czech', 'Denmark', 'DominicanRepublic', 'Egypt', 'Ecuador', 'Eastonia', 'Finland', 'Greece', 'Hungary', 'Iraq', 'Iran', 'Jordan', 'Kazakhstan', 'Kuwait', 'Latvia', 'Lebanon', 'Libya', 'LeReunion', 'Lithuania', 'Mongolia', 'Morocco', 'Myanmar', 'Nigeria', 'Norway', 'Oman', 'Pakistan', 'Paraguay', 'Peru', 'Phillipines', 'Portugal', 'Qatar', 'Romania', 'SaudiArabia', 'Senegal', 'Serbia', 'Slovakia', 'Slovenia', 'SriLanka', 'Syria', 'Tunisia', 'Turkey', 'Ukraine', 'Uruguay', 'Venezuela', 'Vietnam', 'Yemen') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Williams Energy Services' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='AirProducts' ) cl where ip.ipname in('Canada-Alberta', 'Peru') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Hayes Lemmerz' ) cl where ip.ipname in('Czech', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Panasonic-Japan' ) cl where ip.ipname in('') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Remy International' ) cl where ip.ipname in('CanadaMT', 'Tunisia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='MEG Energy' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Cabot Corp.' ) cl where ip.ipname in('Belgium-Flanders', 'Latvia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Rolls Royce' ) cl where ip.ipname in('Finland', 'Norway', 'Vietnam') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Tetra Tech' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Tervita' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Parkland Pipeline' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Glaxo Smith Kline' ) cl where ip.ipname in('Ethiopia', 'Ghana', 'Kenya', 'Nigeria', 'Rwanda') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Amec' ) cl where ip.ipname in('CanadaSK', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Beam Global Spirits' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='GWL Realty Advisors' ) cl where ip.ipname in('CanadaSK', 'CanadaMB', 'CanadaBC', 'CanadaNS', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Gulf Drilling International' ) cl where ip.ipname in('Qatar') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='RPS Group' ) cl where ip.ipname in('CanadaNB', 'CanadaSK', 'CanadaNS', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Cardinal Health' ) cl where ip.ipname in('CanadaNB', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='ERM Calgary' ) cl where ip.ipname in('CanadaBC', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Momentive Performance Materials' ) cl where ip.ipname in('Belgium-Flanders', 'Canada-Alberta', 'Columbia', 'Czech', 'Turkey') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Asco Aerospace' ) cl where ip.ipname in('Belgium-Federal', 'Belgium-Flanders', 'Belgium-Wallonia', 'CanadaBC') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='General Mills' ) cl where ip.ipname in('CanadaQuebec(inFrench)', 'CanadaSK', 'CanadaMB', 'Greece', 'NewZealand', 'Taiwan') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='North American Terminal Services' ) cl where ip.ipname in('Columbia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Merck' ) cl where ip.ipname in('Belgium-Brussels') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Clifton Associates' ) cl where ip.ipname in('CanadaSK', 'Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Hologic' ) cl where ip.ipname in('CostaRica') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Exxon Mobil' ) cl where ip.ipname in('Sweden') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Arrmaz Custom Chemicals' ) cl where ip.ipname in('SaudiArabia') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Sikorsky Aircraft' ) cl where ip.ipname in('Czech') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Concurrent Technologies Corp.' ) cl where ip.ipname in('CanadaBC') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Textron' ) cl where ip.ipname in('Czech', 'Romania', 'Switzerland', 'UnitedArabEm.') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Columbian Chemicals' ) cl where ip.ipname in('Chile', 'Czech', 'Hungary') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Ashland' ) cl where ip.ipname in('Belgium-Federal', 'Finland') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Inter Oil Corporation' ) cl where ip.ipname in('Canada-Alberta') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='RPM International' ) cl where ip.ipname in('Belgium-Flanders') and ip.iptype='IP''s'
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id,cl.clientid,'IP''s' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Xylem' ) cl where ip.ipname in('Panama', 'Portugal', 'Turkey', 'Venezuela') and ip.iptype='IP''s'

	--2) Mining data
	/*
	CLIENT	CONTACT NAME	Rep	Australia	WesternAustralia	Finland	Turkey	Zambia	Mauritania	Spain	Panama	Peru	Argentina	DominicanRepublic	USA	Canada	Japan	China	Korea	India	Afghanistan	Kazakhstan	Guinea	Zimbabwe	SouthAfrica	Mexico	UAE	Brazil	Ireland
Orica			Australia	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
First Quantum Minerals Ltd.			0	WesternAustralia	Finland	Turkey	Zambia	Mauritania	Spain	Panama	Peru	Argentina	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
GE (Mining)			0	0	0	0	0	0	0	0	Peru	Argentina	DominicanRepublic	USA	Canada	Japan	China	Korea	India	Afghanistan	Kazakhstan	Guinea	Zimbabwe	SouthAfrica	Mexico	0	0	0
ERM			0	0	0	0	0	0	0	0	0	0	0	USA	0	0	0	0	0	0	0	0	0	0	0	0	0	0
AIL Mining			0	0	0	0	0	0	0	0	0	0	0	USA	Canada	0	0	0	0	0	0	0	0	0	0	0	0	0
P&H Mining			0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
T&M Associates			0	0	0	0	0	0	0	0	0	0	0	USA	0	0	0	0	0	0	0	0	0	0	0	0	0	0
AECOM			0	0	0	0	0	0	0	0	0	0	0	USA	0	0	0	0	0	0	0	0	0	0	0	0	0	0
CB&I			0	0	0	0	0	0	0	0	0	0	0	USA	Canada	0	0	0	0	0	0	0	0	0	0	0	0	0
Oman Oil Company / OXEA			0	0	0	0	0	0	0	0	0	0	0	USA	0	0	0	0	0	0	0	0	0	0	0	UAE	0	0
RPS Group			Australia	0	0	0	0	0	0	0	0	0	0	USA	Canada	0	0	0	0	0	0	0	0	0	0	0	Brazil	Ireland
Fordia			0	0	0	0	0	0	0	0	0	0	0	0	Canada	0	China	0	0	0	0	0	0	SouthAfrica	0	0	0	0

	*/
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='Orica' ) cl where ip.ipname in('Australia') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='First Quantum Minerals Ltd.' ) cl where ip.ipname in('Western Australia', 'Finland', 'Turkey', 'Zambia', 'Mauritania', 'Spain', 'Panama', 'Peru', 'Argentina') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='GE (Mining)' ) cl where ip.ipname in('Peru', 'Argentina', 'Dominican Republic', 'USA', 'Canada', 'Japan', 'China', 'Korea', 'India', 'Afghanistan', 'Kazakhstan', 'Guinea', 'Zimbabwe', 'SouthAfrica', 'Mexico') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='ERM' ) cl where ip.ipname in('USA') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='AIL Mining' ) cl where ip.ipname in('USA', 'Canada') and ip.iptype='Mining';
																														
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='T&M Associates' ) cl where ip.ipname in('USA') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='AECOM' ) cl where ip.ipname in('USA') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='CB&I' ) cl where ip.ipname in('USA', 'Canada') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='Oman Oil Company / OXEA' ) cl where ip.ipname in('USA', 'UAE') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='RPS Group' ) cl where ip.ipname in('Australia', 'USA', 'Canada', 'Brazil', 'Ireland') and ip.iptype='Mining';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Mining' from IPGuide ip cross join (select max(id) clientid from IPguiderequestClient cl where cl.ClientName='Fordia' ) cl where ip.ipname in('Canada', 'China', 'South Africa') and ip.iptype='Mining';

	--3) ISO data
	/*
	CLIENT	CONTACT NAME	Rep	CONTACT NUMBER	ISO 1540- Lifestyle Assessment	ISO 22000- Food Safe	ISO 37000- Risk Management	  ISO 50,0001
Uni Toronto	Edwin Tam	717		X			
 		 		 	X		
 	 	 				X	 
The Benteler Group		735				 	X

	*/
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'ISO' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='RPS Group' ) cl where ip.ipname in('ISO 1540-Lifestyle Assessment') and ip.iptype='ISO';
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'ISO' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Fordia' ) cl where ip.ipname in('ISO 50,0001') and ip.iptype='ISO';
 

 --4) Convergence data
 /*
 Abbott Laboratories		Lee	New Zealand, Pakistan, Vietnam, Hungary, Czech Republic, Slovakia, Greece, Columbia
*/
insert into IPGuideRequestRecord(ip_id,client_id,iptype) select ip.id, cl.clientid, 'Convergence' from IPGuide ip cross join (select max(id) clientid from IPGuideRequestClient where ClientName='Abbott Laboratories' ) cl where ip.ipname in('New Zealand', 'Pakistan', 'Vietnam', 'Hungary', 'Czech Republic', 'Slovakia', 'Greece', 'Columbia') and ip.iptype='Convergence';