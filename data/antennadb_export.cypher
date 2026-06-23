:begin
CREATE CONSTRAINT antenna_type_id FOR (node:AntennaType) REQUIRE (node.antennaTypeId) IS UNIQUE;
CREATE CONSTRAINT manufacturer_id FOR (node:Manufacturer) REQUIRE (node.manufacturerId) IS UNIQUE;
CREATE CONSTRAINT product_model FOR (node:Product) REQUIRE (node.modelNumber) IS UNIQUE;
CREATE CONSTRAINT radio_interface_id FOR (node:RadioInterface) REQUIRE (node.radioInterfaceId) IS UNIQUE;
CREATE CONSTRAINT UNIQUE_IMPORT_NAME FOR (node:`UNIQUE IMPORT LABEL`) REQUIRE (node.`UNIQUE IMPORT ID`) IS UNIQUE;
:commit
CALL db.awaitIndexes(300);
:begin
UNWIND [{manufacturerId:"APPLE", properties:{name:"Apple Inc."}}, {manufacturerId:"MIKROTIK", properties:{name:"MikroTik"}}, {manufacturerId:"NETGEAR", properties:{name:"NETGEAR, Inc."}}, {manufacturerId:"SPACEX", properties:{name:"SpaceX (Starlink)"}}, {manufacturerId:"CONTINENTAL", properties:{name:"Continental AG"}}, {manufacturerId:"COMET", properties:{name:"Comet Antenna, Inc."}}, {manufacturerId:"UBIQUITI", properties:{name:"Ubiquiti Inc."}}, {manufacturerId:"ANTOP", properties:{name:"Antop Technology Ltd."}}] AS row
CREATE (n:Manufacturer{manufacturerId: row.manufacturerId}) SET n += row.properties;
UNWIND [{antennaTypeId:"SMARTPHONE", properties:{coverageType:"Omnidirectional", beamwidth:"360°"}}, {antennaTypeId:"OMNI_5GHZ", properties:{coverageType:"Omnidirectional", beamwidth:"360°"}}, {antennaTypeId:"INTERNAL_PCB", properties:{coverageType:"Omnidirectional", beamwidth:"360°"}}, {antennaTypeId:"PHASED_ARRAY", properties:{coverageType:"Directional", beamwidth:"110°"}}, {antennaTypeId:"SHARK_FIN", properties:{coverageType:"Omnidirectional", beamwidth:"360°"}}, {antennaTypeId:"VHF_UHF_WHIP", properties:{coverageType:"Omnidirectional", beamwidth:"360°"}}, {antennaTypeId:"DIRECTIONAL_PANEL", properties:{coverageType:"Directional", beamwidth:"30°"}}, {antennaTypeId:"HDTV_DIRECTIONAL", properties:{coverageType:"Directional", beamwidth:"45°"}}] AS row
CREATE (n:AntennaType{antennaTypeId: row.antennaTypeId}) SET n += row.properties;
UNWIND [{radioInterfaceId:"RI_5G_WIFI7", properties:{description:"5G NR, LTE, Wi-Fi 7, Bluetooth, NFC, UWB", mimo:"4x4"}}, {radioInterfaceId:"RI_WIFI5", properties:{description:"Wi-Fi 5 (802.11ac @ 5 GHz)", mimo:"2x2"}}, {radioInterfaceId:"RI_WIFI6", properties:{description:"Wi-Fi 6 (802.11ax @ 2.4/5 GHz)", mimo:"2x2"}}, {radioInterfaceId:"RI_LTE_WIFI", properties:{description:"LTE, Wi-Fi, VoLTE", mimo:"2x2"}}, {radioInterfaceId:"RI_SAT_WIFI", properties:{description:"Ku/Ka satellite + Wi-Fi 6", mimo:"4x4"}}, {radioInterfaceId:"RI_AUTO_RF", properties:{description:"AM/FM, GNSS, LTE/5G", mimo:"2x2"}}, {radioInterfaceId:"RI_VHF_UHF", properties:{description:"VHF/UHF analog/digital", mimo:"None"}}, {radioInterfaceId:"RI_ATSC", properties:{description:"ATSC 1.0 / 3.0 (VHF/UHF)", mimo:"None"}}] AS row
CREATE (n:RadioInterface{radioInterfaceId: row.radioInterfaceId}) SET n += row.properties;
UNWIND [{modelNumber:"A3258", properties:{coverage:"~70 ft (LoS)", deviceRole:"Mobile handset", materials:"Copper / Metal", name:"Apple iPhone 17", power:"Passive", releaseYear:2025, gain:"3 dBi"}}, {modelNumber:"RBOmniTikG-5HacD-US", properties:{coverage:"~164,000 sq ft", deviceRole:"Wi-Fi access point", materials:"Copper / Alloy", name:"MikroTik OmniTik 5 ac", power:"Passive", releaseYear:2018, gain:"7.5 dBi"}}, {modelNumber:"MK73S", properties:{coverage:"~4,500 sq ft", deviceRole:"Wi-Fi access point", materials:"Copper", name:"Netgear Nighthawk Mesh System", power:"Passive", releaseYear:2021, gain:"3.5 dBi"}}, {modelNumber:"A2275", properties:{coverage:"~70 ft (LoS)", deviceRole:"Mobile handset", materials:"Copper / Alloy", name:"Apple iPhone SE (2nd Gen)", power:"Passive", releaseYear:2010, gain:"3 dBi"}}, {modelNumber:"UTA-232", properties:{coverage:"~300 miles", deviceRole:"Satellite internet terminal", materials:"Aluminum", name:"Starlink Standard Dish", power:"100 W", releaseYear:2024, gain:"20 dBi"}}, {modelNumber:"681021301", properties:{coverage:"~340 miles", deviceRole:"Automotive antenna", materials:"ABS / Plastic", name:"BMW 7 Series (G70) Shark-Fin Antenna", power:"Passive", releaseYear:2024, gain:"3 dBi"}}, {modelNumber:"CA-2X4SRNMO", properties:{coverage:"N/A", deviceRole:"Mobile communications", materials:"Stainless steel", name:"Comet CA-2X4SRNMO Mobile Whip", power:"Passive", releaseYear:2010, gain:"5 dBi"}}, {modelNumber:"SXT5", properties:{coverage:"~5 miles (LoS)", deviceRole:"Outdoor access point", materials:"Plastic", name:"Ubiquiti airMAX SXT 5", power:"7 W", releaseYear:2015, gain:"16 dBi"}}, {modelNumber:"AT-400BV", properties:{coverage:"~80 miles", deviceRole:"Broadcast reception", materials:"Aluminum", name:"Antop AT-400BV HDTV Antenna", power:"0.25 W", releaseYear:2020, gain:"10 dBi"}}] AS row
CREATE (n:Product{modelNumber: row.modelNumber}) SET n += row.properties;
UNWIND [{_id:40, properties:{name:"Directional Panel"}}, {_id:41, properties:{name:"Smartphone Antenna"}}, {_id:42, properties:{name:"Phased Array"}}, {_id:43, properties:{name:"Shark-Fin Antenna"}}, {_id:44, properties:{name:"HDTV Directional"}}] AS row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:AntennaType;
UNWIND [{_id:45, properties:{name:"Point-to-Point"}}, {_id:46, properties:{name:"Roaming"}}, {_id:47, properties:{name:"High-Gain Satellite Tracking"}}, {_id:48, properties:{name:"Automotive Connectivity"}}, {_id:49, properties:{name:"Broadcast Reception"}}] AS row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:UseCase;
UNWIND [{_id:33, properties:{gainId:"GAIN_3", unit:"dBi", value:3}}, {_id:34, properties:{gainId:"GAIN_3_5", unit:"dBi", value:3.5}}, {_id:35, properties:{gainId:"GAIN_5", unit:"dBi", value:5}}, {_id:36, properties:{gainId:"GAIN_7_5", unit:"dBi", value:7.5}}, {_id:37, properties:{gainId:"GAIN_10", unit:"dBi", value:10}}, {_id:38, properties:{gainId:"GAIN_16", unit:"dBi", value:16}}, {_id:39, properties:{gainId:"GAIN_20", unit:"dBi", value:20}}] AS row
CREATE (n:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row._id}) SET n += row.properties SET n:Gain;
:commit
:begin
UNWIND [{start: {_id:40}, end: {_id:45}, properties:{}}, {start: {_id:41}, end: {_id:46}, properties:{}}, {start: {_id:42}, end: {_id:47}, properties:{}}, {start: {_id:43}, end: {_id:48}, properties:{}}, {start: {_id:44}, end: {_id:49}, properties:{}}] AS row
MATCH (start:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.start._id})
MATCH (end:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.end._id})
CREATE (start)-[r:OPTIMIZED_FOR]->(end) SET r += row.properties;
UNWIND [{start: {modelNumber:"A3258"}, end: {radioInterfaceId:"RI_5G_WIFI7"}, properties:{}}, {start: {modelNumber:"RBOmniTikG-5HacD-US"}, end: {radioInterfaceId:"RI_WIFI5"}, properties:{}}, {start: {modelNumber:"MK73S"}, end: {radioInterfaceId:"RI_WIFI6"}, properties:{}}, {start: {modelNumber:"A2275"}, end: {radioInterfaceId:"RI_LTE_WIFI"}, properties:{}}, {start: {modelNumber:"UTA-232"}, end: {radioInterfaceId:"RI_SAT_WIFI"}, properties:{}}, {start: {modelNumber:"681021301"}, end: {radioInterfaceId:"RI_AUTO_RF"}, properties:{}}, {start: {modelNumber:"CA-2X4SRNMO"}, end: {radioInterfaceId:"RI_VHF_UHF"}, properties:{}}, {start: {modelNumber:"SXT5"}, end: {radioInterfaceId:"RI_WIFI5"}, properties:{}}, {start: {modelNumber:"AT-400BV"}, end: {radioInterfaceId:"RI_ATSC"}, properties:{}}] AS row
MATCH (start:Product{modelNumber: row.start.modelNumber})
MATCH (end:RadioInterface{radioInterfaceId: row.end.radioInterfaceId})
CREATE (start)-[r:SUPPORTS_INTERFACE]->(end) SET r += row.properties;
UNWIND [{start: {antennaTypeId:"SMARTPHONE"}, end: {_id:33}, properties:{}}, {start: {antennaTypeId:"OMNI_5GHZ"}, end: {_id:36}, properties:{}}, {start: {antennaTypeId:"INTERNAL_PCB"}, end: {_id:34}, properties:{}}, {start: {antennaTypeId:"PHASED_ARRAY"}, end: {_id:39}, properties:{}}, {start: {antennaTypeId:"SHARK_FIN"}, end: {_id:33}, properties:{}}, {start: {antennaTypeId:"VHF_UHF_WHIP"}, end: {_id:35}, properties:{}}, {start: {antennaTypeId:"DIRECTIONAL_PANEL"}, end: {_id:38}, properties:{}}, {start: {antennaTypeId:"HDTV_DIRECTIONAL"}, end: {_id:37}, properties:{}}] AS row
MATCH (start:AntennaType{antennaTypeId: row.start.antennaTypeId})
MATCH (end:`UNIQUE IMPORT LABEL`{`UNIQUE IMPORT ID`: row.end._id})
CREATE (start)-[r:HAS_GAIN]->(end) SET r += row.properties;
UNWIND [{start: {manufacturerId:"MIKROTIK"}, end: {modelNumber:"RBOmniTikG-5HacD-US"}, properties:{}}, {start: {manufacturerId:"SPACEX"}, end: {modelNumber:"UTA-232"}, properties:{}}] AS row
MATCH (start:Manufacturer{manufacturerId: row.start.manufacturerId})
MATCH (end:Product{modelNumber: row.end.modelNumber})
CREATE (start)-[r:MANUFACTURES]->(end) SET r += row.properties;
UNWIND [{start: {modelNumber:"A3258"}, end: {antennaTypeId:"SMARTPHONE"}, properties:{}}, {start: {modelNumber:"RBOmniTikG-5HacD-US"}, end: {antennaTypeId:"OMNI_5GHZ"}, properties:{}}, {start: {modelNumber:"MK73S"}, end: {antennaTypeId:"INTERNAL_PCB"}, properties:{}}, {start: {modelNumber:"A2275"}, end: {antennaTypeId:"SMARTPHONE"}, properties:{}}, {start: {modelNumber:"UTA-232"}, end: {antennaTypeId:"PHASED_ARRAY"}, properties:{}}, {start: {modelNumber:"681021301"}, end: {antennaTypeId:"SHARK_FIN"}, properties:{}}, {start: {modelNumber:"CA-2X4SRNMO"}, end: {antennaTypeId:"VHF_UHF_WHIP"}, properties:{}}, {start: {modelNumber:"SXT5"}, end: {antennaTypeId:"DIRECTIONAL_PANEL"}, properties:{}}, {start: {modelNumber:"AT-400BV"}, end: {antennaTypeId:"HDTV_DIRECTIONAL"}, properties:{}}] AS row
MATCH (start:Product{modelNumber: row.start.modelNumber})
MATCH (end:AntennaType{antennaTypeId: row.end.antennaTypeId})
CREATE (start)-[r:USES_ANTENNA_TYPE]->(end) SET r += row.properties;
:commit
:begin
MATCH (n:`UNIQUE IMPORT LABEL`)  WITH n LIMIT 20000 REMOVE n:`UNIQUE IMPORT LABEL` REMOVE n.`UNIQUE IMPORT ID`;
:commit
:begin
DROP CONSTRAINT UNIQUE_IMPORT_NAME;
:commit
