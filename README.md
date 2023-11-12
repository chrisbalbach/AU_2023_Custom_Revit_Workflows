# AU_2023_Custom_Revit_Workflows
This repository contains the Revit Projects, OpenStudio Measures and Revit Workflows needed to reproduce the work presented at the AU 2023 Session 602389 Titled "Design and Analysis of Building Electrification with Revit Systems Analysis" 

# Dependencies

Users attempting to recreate the work demonstrated during this AU class should ensure they install: 

1. Revit 2024.1 (this Revit version **does not support creating ASHRAE 90.1-2016 or ASHRAE 90.1-2019**  baselines or hot water system/loads.) 
2. OpenStudio SDK/API v3.4.0 
3. OpenStudio Application v1.4.0
4. A text editor (Visual Studio Code, Notepad++, etc.)

## Table of Content 

* [Revit File](#revit-file)
* [OS Measures used by Revit Workflows](#os-measures-used-by-revit-workflows)
* [Revit Workflow files](#revit-workflow-files)
* [Useful Scripts](#useful-scripts)
* [Useful Links](#useful-links)



# Revit File

The Revit File **"Retail Big Box_Example.rvt"** was demonstrated during the course. This file can be found in the "Revit Files" directory of this repository. 

Users creating custom Revit workflows should carefully review the existing topology of "Air Systems" and "Zone Equipment" objects that have been created in 
this file, using the Revit UI for Analytical Systems.

Using Revit, the existing "Air Systems" and "Zone Equipment" objects and their connections to "Analytical Spaces" may be deleted/recreated. 
New "Air Systems" and "Zone Equipment" objects and connections to Analytical Spaces may be defined by the user, as part of exercising these workflows.    

# OS Measures used by Revit Workflows

The following OpenStudio measures are included in this repository. Users can downloaded and edit these measures to create custom OS workflows, in Revit. 

1. ["revit_analyze_all_electric_hvac_systems"](https://github.com/chrisbalbach/chrisbalbach.github.io#measure-1-revit_analyze_all_electric_hvac_systems) 
2. ["revit_analyze_electric_tariff"](https://github.com/chrisbalbach/chrisbalbach.github.io#measure-2-revit_analyze_electric_tariff)
3. ["revit_create_baseline_building"](https://github.com/chrisbalbach/chrisbalbach.github.io#measure-3-revit_create_baseline_building) 
4. ["revit_add_pv_add_storage_tou"](https://github.com/chrisbalbach/chrisbalbach.github.io#measure-4-revit_add_pv_add_storage_tou)
5. ["revit_create_typical_shw_systems_using_os_standards_gem"](https://github.com/chrisbalbach/chrisbalbach.github.io#measure-5-revit_create_typical_shw_systems_using_os_standards_gem)

Each of these measures requires the user to create (pre-process) at least (1) .csv file. In some cases, the pre-processed csv files will need information that 
can be found within the Revit gbXML file export. 

## Measure #1: "revit_analyze_all_electric_hvac_systems"

This "OpenStudio" measure is designed to allow Revit users to configure and model additional OpenStudio "Air Systems" and "Zone Equipment" HVAC Systems,
beyond those available in the Revit Analytical Systems UI. The measure leverages HVAC system topologies created using the Revit UI, **replacing all**
pre-defined "Air System" and **replacing all**  predefined "Zone Equipment" OpenStudio objects with new "Air System" and "Zone Equipment" objects based on
user selections. 

While **NEW** HVAC systems are created, the existing HVAC System/Zone relationships are preserved. The OpenStudio Application can be used to open the "in.osm" file, where the 
detailed properties of the **new** HVAC systems can be inspected. All HVAC systems created by this measure are 'auto-sized' - the name of the HVAC system object 
(available by inspecting the 'in.osm' OpenStudio model file osm) OR EnergyPlus output reports) will contain the autosized capacities of coils, pumps, etc. 

This measure uses powerful model articulation methods such as "standard.model_add_hvac_system", included in v0.4.0 of the OpenStudio Standards gem: "https://github.com/NREL/openstudio-standards/releases/tag/v0.4.0".
The measure creates many different HVAC systems, whose properties are either: 
1. Defaulted to values set within the OpenStudio Standards gem
2. Set to 'regulated' values defined by the selected ASHRAE standard.

This measures includes (1) configurable .csv file.
### csv file #1: "Building_Level_Mappings.csv"

The .csv file for configuring this measure is named "Building_Level_Mappings.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 5**. 

For all Rows, Column E of the .csv file describes the allowable enumarations.

1. **Row 2**: An ASHRAE Standard 90.1.2xxx - Used to determine regulated HVAC Equipment efficiencies and controls.
2. **Row 3**: One type of new 'Air System' - Used to define the 'Air Systems' objects to model. In the OpenStudio energy model, these 'Air Systems' will replace ALL Air Systems 
previously created using Revit Systems Analysis.  
3. **Row 4**: One type of new 'Zone Equipment' - Used to define the 'Zone Equipment' objects to model. In the OpenStudio energy model, these 'Zone Equipment'
 will replace ALL 'Zone Equipment' previously created using Revit Systems Analysis.
4. **Row 5**: An ASHRAE Standard 169-2006  Climate Zone - Used by measure along with the ASHRAE Standard to determine HVAC system control requirements, such as air-side economizers

Optional (parameter override) values can be provided in Column B for Rows (6 - 10).

OpenStudio measure code to use the values in Column B for **Rows (11 - 41)** have not been written/tested. 

## Measure #2: "revit_analyze_electric_tariff"

This "EnergyPlus" measure is designed to allow a Revit user to apply electric tariffs of different levels of complexity to OpenStudio models created using Revit. The measure can be used to model very 
simple tariffs such as a fixed $/kWh rate for all hours or the year. The measure can also be used to model seperate 'time-of-use' and accumulating block tarrifs for power and energy, 
for both a electricity supplier and an electricity tranmission and distribution provider. Scenarios of differing tariff complexity can be mapped into the 

This measures includes (1) configurable .csv file.

### csv file #1: "Electric_Utility_Tariff_Arguments.csv"

The .csv file for configuring this measure is named "Electric_Utility_Tariff_Arguments.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 65**. 

Allowable enumerations for 'demand_window_length' can be found in measure.rb lines (1218 - 1222). 

#### example csv file #1: Simple Tariff

This table shows the configuraton of the .csv file for a **flat energy tariff of $0.15 / kWh**. 

* No demand charges are modeled.
* No (peak/on peak) hourly time-of-use charges are modeled.
* No seasonal (summer/nonsummer) charges are modeled.
* A single supplier tariff is modeled (**all** energy cost values associated with the T&D Tariff are zero).

|**Argument Name**                             |**Value**    |**Type**|**Units** |**Element Category**         |
|----------------------------------------------|-------------|-------|-----------|-----------------------------|
|tariff_name                                   |Simple Tariff|       |N/A        |General Info                 |
|demand_window_length                          |QuarterHour  |String |N/A        |General Info                 |
|summer_start_month                            |5            |Integer|month      |General Info                 |
|summer_start_day                              |15           |Integer|day        |General Info                 |
|summer_end_month                              |9            |Integer|month      |General Info                 |
|summer_end_day                                |15           |Integer|day        |General Info                 |
|peak_start_hour                               |12           |Integer|hour of day|General Info                 |
|peak_end_hour                                 |18           |Integer|hour of day|General Info                 |
|supply_elec_rate_sum_peak                     |0.15         |Double |$/kWh      |Supplier                     |
|supply_elec_rate_sum_nonpeak                  |0.15         |Double |$/kWh      |Supplier                     |
|supply_elec_rate_nonsum_peak                  |0.15         |Double |$/kWh      |Supplier                     |
|supply_elec_rate_nonsum_nonpeak               |0.15         |Double |$/kWh      |Supplier                     |
|supply_elec_demand_sum                        |0            |Double |$/kW       |Supplier                     |
|supply_elec_demand_nonsum                     |0            |Double |$/kW       |Supplier                     |
|supply_monthly_charge                         |0            |Double |$          |Supplier                     |
|supply_qualifying_min_monthly_demand          |1            |Double |kW         |Supplier                     |
|supply_summer_elec_block_1_size               |30000        |Double |kWh        |Supplier                     |
|supply_summer_elec_block_1_cost_per_kwh       |0.15         |Double |$/kWh      |Supplier                     |
|supply_summer_elec_block_2_size               |50000        |Double |kWh        |Supplier                     |
|supply_summer_elec_block_2_cost_per_kwh       |0.15         |Double |$/kWh      |Supplier                     |
|supply_summer_elec_remaining_cost_per_kwh     |0.15         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_block_1_size               |30000        |Double |kWh        |Supplier                     |
|supply_winter_elec_block_1_cost_per_kwh       |0.15         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_block_2_size               |50000        |Double |kWh        |Supplier                     |
|supply_winter_elec_block_2_cost_per_kwh       |0.15         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_remaining_cost_per_kwh     |0.15         |Double |$/kWh      |Supplier                     |
|supply_summer_elec_demand_block_1_size        |0            |Double |kW         |Supplier                     |
|supply_summer_elec_demand_block_1_cost_per_kw |0            |Double |$/kW       |Supplier                     |
|supply_summer_elec_demand_block_2_size        |0            |Double |kW         |Supplier                     |
|supply_summer_elec_demand_block_2_cost_per_kw |0            |Double |$/kW       |Supplier                     |
|supply_summer_elec_remaining_cost_per_kw      |0            |Double |$/kW       |Supplier                     |
|supply_winter_elec_demand_block_1_size        |0            |Double |kW         |Supplier                     |
|supply_winter_elec_demand_block_1_cost_per_kw |0            |Double |$/kW       |Supplier                     |
|supply_winter_elec_demand_block_2_size        |0            |Double |kW         |Supplier                     |
|supply_winter_elec_demand_block_2_cost_per_kw |0            |Double |$/kW       |Supplier                     |
|supply_winter_elec_remaining_cost_per_kw      |0            |Double |$/kW       |Supplier                     |
|t_and_d_elec_rate_sum_peak                    |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_sum_nonpeak                 |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_nonsum_peak                 |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_nonsum_nonpeak              |0            |Double |$/kWh      |T & D|                 
|t_and_d_elec_demand_sum                       |0            |Double |$/kW       |T & D|
|t_and_d_elec_demand_nonsum                    |0            |Double |$/kW       |T & D|
|t_and_d_monthly_charge                        |0            |Double |$          |T & D|
|t_and_d_qualifying_min_monthly_demand         |0            |Double |kW         |T & D|
|t_and_d_summer_elec_block_1_size              |30000        |Double |kWh        |T & D|
|t_and_d_summer_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_summer_elec_block_2_size              |50000        |Double |kWh        |T & D|
|t_and_d_summer_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_summer_elec_remaining_cost_per_kwh    |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_block_1_size              |30000        |Double |kWh        |T & D|
|t_and_d_winter_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_block_2_size              |50000        |Double |kWh        |T & D|
|t_and_d_winter_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_remaining_cost_per_kwh    |5.3          |Double |$/kWh      |T & D|
|t_and_d_summer_elec_demand_block_1_size       |10           |Double |kW         |T & D|
|t_and_d_summer_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |T & D
|t_and_d_summer_elec_demand_block_2_size       |50           |Double |kW         |T & D|
|t_and_d_summer_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_summer_elec_remaining_cost_per_kw     |0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_demand_block_1_size       |10           |Double |kW         |T & D|
|t_and_d_winter_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_demand_block_2_size       |0            |Double |kW         |T & D|
|t_and_d_winter_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_remaining_cost_per_kw     |0            |Double |$/kW       |T & D|

#### example csv file #2: Complex Tariff

This table shows the configuraton of the .csv file for a **complex energy tariff**. 

* A 'Summer' season occurs between June 15 - September 15. The Non-Summer season includes all other days.   
* A 'Summer' on-peak' period occurs between 3:00PM and 6:00PM
* The Electric Supplier charges an Energy rate of $0.125/kWh during Summer Peak Hours $0.181/kWh during Summer Non-Peak Hours
* The Electric Supplier charges an Energy rate of $0.103/kWh during Non-Summer Peak Hours $0.072/kWh during Non-Summer Non-Peak Hours
* The Electric Supplier charges an Demand rate of $2.48/kW during Summer Hours and $1.59/kW during Non-Summer Hours
* The Electric Supplier charges a fixed amount of $13.543 per Monthly billing period
* The Electric Supplier has no minimum monthly demand for the tariff.
* The During the Summer Period, The Electric Supplier uses this cumulative block structure for determining additional energy charges for each billing period
    - $0.082/kWh for the First 10,000 kWh
    - $0.072/kWh for the Next 10,000 kWh
    - $0.062/kWh for all remaining kWh
* The During the Non-Summer Period, The Electric Supplier uses this cumulative block structure for determining additional energy charges for each billing period
    - $0.062/kWh for the First 10,000 kWh
    - $0.052/kWh for the Next 10,000 kWh
    - $0.042/kWh for all remaining kWh
* The During the Summer Period, The Electric Supplier uses this cumulative block structure for determining additional power charges for each billing period
    - $6.45/kW for the First 50 kW
    - $7.12/kW for the Next 100 kW
    - $9.21/kW for all remaining kW
* The During the Summer Period, The Electric Supplier uses this cumulative block structure for determining additional power charges for each billing period
    - $3.45/kW for the First 50 kW
    - $4.12/kW for the Next 100 kW
    - $5.21/kW for all remaining kW
* No Transmission and Disrribution Provider is used.

|**Argument Name**                             |**Value**    |**Type**|**Units** |**Element Category**         |
|----------------------------------------------|-------------|-------|-----------|-----------------------------|
|tariff_name                                   |Simple Tariff|       |N/A        |General Info                 |
|demand_window_length                          |QuarterHour  |String |N/A        |General Info                 |
|summer_start_month                            |6            |Integer|month      |General Info                 |
|summer_start_day                              |15           |Integer|day        |General Info                 |
|summer_end_month                              |9            |Integer|month      |General Info                 |
|summer_end_day                                |15           |Integer|day        |General Info                 |
|peak_start_hour                               |15           |Integer|hour of day|General Info                 |
|peak_end_hour                                 |18           |Integer|hour of day|General Info                 |
|supply_elec_rate_sum_peak                     |0.125        |Double |$/kWh      |Supplier                     |
|supply_elec_rate_sum_nonpeak                  |0.181        |Double |$/kWh      |Supplier                     |
|supply_elec_rate_nonsum_peak                  |0.103         |Double |$/kWh      |Supplier                     |
|supply_elec_rate_nonsum_nonpeak               |0.072         |Double |$/kWh      |Supplier                     |
|supply_elec_demand_sum                        |2.48           |Double |$/kW       |Supplier                     |
|supply_elec_demand_nonsum                     |1.59            |Double |$/kW       |Supplier                     |
|supply_monthly_charge                         |13.5430            |Double |$          |Supplier                     |
|supply_qualifying_min_monthly_demand          |1            |Double |kW         |Supplier                     |
|supply_summer_elec_block_1_size               |10000        |Double |kWh        |Supplier                     |
|supply_summer_elec_block_1_cost_per_kwh       |0.082         |Double |$/kWh      |Supplier                     |
|supply_summer_elec_block_2_size               |20000        |Double |kWh        |Supplier                     |
|supply_summer_elec_block_2_cost_per_kwh       |0.072        |Double |$/kWh      |Supplier                     |
|supply_summer_elec_remaining_cost_per_kwh     |0.062         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_block_1_size               |10000        |Double |kWh        |Supplier                     |
|supply_winter_elec_block_1_cost_per_kwh       |0.062         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_block_2_size               |20000        |Double |kWh        |Supplier                     |
|supply_winter_elec_block_2_cost_per_kwh       |0.052         |Double |$/kWh      |Supplier                     |
|supply_winter_elec_remaining_cost_per_kwh     |0.042         |Double |$/kWh      |Supplier                     |
|supply_summer_elec_demand_block_1_size        |50            |Double |kW         |Supplier                     |
|supply_summer_elec_demand_block_1_cost_per_kw |6.45            |Double |$/kW       |Supplier                     |
|supply_summer_elec_demand_block_2_size        |100            |Double |kW         |Supplier                     |
|supply_summer_elec_demand_block_2_cost_per_kw |7.12            |Double |$/kW       |Supplier                     |
|supply_summer_elec_remaining_cost_per_kw      |9.21            |Double |$/kW       |Supplier                     |
|supply_winter_elec_demand_block_1_size        |50            |Double |kW         |Supplier                     |
|supply_winter_elec_demand_block_1_cost_per_kw |3.45            |Double |$/kW       |Supplier                     |
|supply_winter_elec_demand_block_2_size        |100            |Double |kW         |Supplier                     |
|supply_winter_elec_demand_block_2_cost_per_kw |4.12            |Double |$/kW       |Supplier                     |
|supply_winter_elec_remaining_cost_per_kw      |5.21           |Double |$/kW       |Supplier                     |
|t_and_d_elec_rate_sum_peak                    |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_sum_nonpeak                 |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_nonsum_peak                 |0            |Double |$/kWh      |T & D|
|t_and_d_elec_rate_nonsum_nonpeak              |0            |Double |$/kWh      |T & D|                 
|t_and_d_elec_demand_sum                       |0            |Double |$/kW       |T & D|
|t_and_d_elec_demand_nonsum                    |0            |Double |$/kW       |T & D|
|t_and_d_monthly_charge                        |0            |Double |$          |T & D|
|t_and_d_qualifying_min_monthly_demand         |0            |Double |kW         |T & D|
|t_and_d_summer_elec_block_1_size              |30000        |Double |kWh        |T & D|
|t_and_d_summer_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_summer_elec_block_2_size              |50000        |Double |kWh        |T & D|
|t_and_d_summer_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_summer_elec_remaining_cost_per_kwh    |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_block_1_size              |30000        |Double |kWh        |T & D|
|t_and_d_winter_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_block_2_size              |50000        |Double |kWh        |T & D|
|t_and_d_winter_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |T & D|
|t_and_d_winter_elec_remaining_cost_per_kwh    |5.3          |Double |$/kWh      |T & D|
|t_and_d_summer_elec_demand_block_1_size       |10           |Double |kW         |T & D|
|t_and_d_summer_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |T & D
|t_and_d_summer_elec_demand_block_2_size       |50           |Double |kW         |T & D|
|t_and_d_summer_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_summer_elec_remaining_cost_per_kw     |0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_demand_block_1_size       |10           |Double |kW         |T & D|
|t_and_d_winter_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_demand_block_2_size       |0            |Double |kW         |T & D|
|t_and_d_winter_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |T & D|
|t_and_d_winter_elec_remaining_cost_per_kw     |0            |Double |$/kW       |T & D|


## Measure #3 "revit_create_baseline_building"
## Measure #1: "revit_analyze_all_electric_hvac_systems"

This "OpenStudio" measure is designed to allow Revit users to creat an "ASHRAE" baseline OpenStudio model. The measure calls several methods from the "OpenStudio Standard Gem" to accomplish this. 
Revit.

This measures includes (21) configurable .csv files.

### csv file #1: "Building_Baseline_Mappings.csv"

The first .csv file for configuring this measure is named "Building_Baseline_Mappings.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 9**. 

For all Rows, Column C of the .csv file describes the allowable enumarations. 

1. **Row 2**: The name of the user-created .csv fileused to link gbXML Space/SpaceTypes to SpaceTypes supported by the OpenStudio Standard Gem.
2. **Row 3**: A text string for the 'ASHRAE Standard' that the baseline will be constructed to. Allowable enumerations are decribed in lines (31 - 37) of the measure.rb file.
3. **Row 4**: A text string for the 'Building Type' that will be used by the ASHRAE Standard. Allowable enumerations are decribed in lines (45 - 59) of the measure.rb file.
4. **Row 5**: A text string for the Climate Zone that will be used by the ASHRAE Standard. Allowable enumerations are decribed in lines (147 - 161) of the measure.rb file.
4. **Row 6**: A debug boolean variable, NOTE debug output is not visible to Revit users.
4. **Row 6**: A debug boolean variable, NOTE debug output is not visible to Revit users.
5. **Row 7**: A text string for the (ASHRAE 90.1-2016 or 90.1-2019) building type for the baseline HVAC system. Allowable enumerations are decribed in lines (66 - 73) of the measure.rb file. 
5. **Row 8**: A text string for the (ASHRAE 90.1-2016 or 90.1-2019) building type for the window/wall ratio. Allowable enumerations are decribed in lines (80 - 96) of the measure.rb file. 
5. **Row 9**: A text string for the (ASHRAE 90.1-2016 or 90.1-2019) building type for the baseline SHW system. Allowable enumerations are decribed in lines (103 - 139) of the measure.rb file. 

### csv file #2: "<file_name_is_set_by_user>.csv"

The second .csv file for configuring this measure is named by the user, and this file should saved to the /resources directory of the 
measure. Values should be provided in columns A, B and C of the .csv file, with one row created for each 'Space" object found in the 
gbXML file. 

A seperate row shoudl be created for **each** Space object found in the gbXML file.

1. **Column A**: The gbXML Spaceid, extracted from the gbXML file exported by Revit.
2. **Column B**: The gbXML Space Name, extracted from the gbXML file exported by Revit.
3. **Column C**: A string composed of (3) sub-strings whose values are defined within the OS Standards Gem. 
   This string maps regulated values (Space Lighting Power Densities, Lighting System Controls, etc.) of the ASHRAE Standard OS Standrds gem to the Revit space.

    "**Standard**-**BuildingType**-**SpaceType**" 

## Measure #4 "revit_add_pv_add_storage_tou"

This "OpenStudio" measure is designed to allow Revit users to estimate the energy and power impacts from a 'behind the meter' BES (Battery Energy Storage) system composed of a 
configurable PV System, a configurable Lithium Ion Battery Bank, and a configurable Battery Manageement System.
The measure **adds new** objects for these components, based on user-defined parameters. The Standard EnergyPlus Output report can be viewed 
from within Revit, to show the annual energy and peak power impacts of the BES. 

This measure is often combined with the OpenStudo Tariff measure into custom Revit Workflows for evaluating BES arbitrage opportunities for facilities with known periods of high cost 
seasonal and time-of-day tariffs. The BES system is desinged to offset 'purchased' electricity demands when it is most expensive (on-peak periods), leveraging the PV/BES to and 
meet facilty energy demands.

The measure .csv file can be configured to model a 'Storage Only" scenario by specifying a PV System with a very small value  for the PV 'Max Power Output' variable (for example, 0.1 kW).
The measure .csv file can be configured to model a 'PV Only" scenario by specifying a Battery System with a very small value Battery 'Usable Capacity' variable (for example, 0.1 kW).
'Matched' BES systems (PV + PowerWall, PV + PowerPack, etc.) can be modeled by carefully configuring the .csv file to defining both a PV System and BES properties.

This measures includes (1) configurable .csv file.

### csv file #1: "PV_Battery_Inputs.csv"

The .csv file for configuring this measure is named "PV_Battery_Inputs.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 42**. 

Allowable enumerations for 'Array Type' can be found in measure.rb lines (36-40). 
Allowable enumerations for 'Module Type' can be found in measure.rb lines (50-52). 

#### Example csv file #1: Model PV System Only

This table shows the configuraton of the measure .csv file to model the performance of a 75 kW Fixed (Roof Mounted) South Facing PV System. 
When the sun is ahining, the PV System will generate Power, which will offset electricity purchases. No energy will be stored. 

|**Argument Name**                                           |**Units/Range**|**Value**      |**System Component**      |
|------------------------------------------------------------|---------|---------------|--------------------------|
|Max Power Output                                            |kW       |75             |PV                        |
|Array Type                                                  |N/A      |OneAxis        |PV                        |
|Module Type                                                 |N/A      |Premium        |PV                        |
|System Losses Fraction                                      |(0 - 100)|17             |PV                        |
|Array Tilt                                                  |Degrees  |30             |PV                        |
|Array Azimuth                                               |Degrees  |180            |PV                        |
|Ground Coverage Ratio                                       |(0 - 100)|35             |PV                        |
|Inverter Efficiency                                         |(0-1)    |0.96           |Inverter                  |
|DC to AC Size Ratio                                         |N/A      |1.1            |Inverter                  |
|Converter Simple Fixed Efficiency                           |(0-1)    |0.94           |Converter                 |
|Converter Ancillary Power Consumed In Standby               |W        |100            |Converter                 |
|Converter Radiative Fraction                                |(0-1)    |0.25           |Converter                 |
|Battery Make Model                                          |N/A      |<empty>        |
|Nominal Capacity                                            |kWh      |0.1            |Storage                   |
|Usable Capacity                                             |kWh      |0.1            |Storage                   |
|Rated Power Output                                          |kW       |0.01           |Storage                   |
|Nominal Voltage                                             |V        |50             |Storage                   |
|Round Trip Efficiency                                       |(0-1)    |0.95           |Storage                   |
|Minimum State Of Charge Fraction                            |(0-1)    |0.1            |Storage                   |
|Maximum State Of Charge Fraction                            |(0-1)    |0.97           |Storage                   |
|Lifetime Model                                              |N/A      |KandlerSmith   |Storage                   |
|Initial Fraction State of Charge                            |(0-1)    |0.95           |Storage                   |
|Percentage of Maximum Charge Power to use for Charging      |fraction |0.8            |ELCD                      |
|Percentage of Maximum Discharge Power to use for Discharging|fraction |0.95           |ELCD                      |
|Summer Month to Begin Storage Season                        |Integer  |3              |ELCD                      |
|Summer Day to Begin Storage Season                          |Integer  |1              |ELCD                      |
|Summer Month to End Storage Season                          |Integer  |9              |ELCD                      |
|Summer Day to End Storage Season                            |Integer  |15             |ELCD                      |
|Winter Weekday Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |
|Winter Weekday Hour To End Storage Discharge                |Integer  |22             |ELCD                      |
|Winter Weekend Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |
|Winter Weekend Hour To End Storage Discharge                |Integer  |22             |ELCD                      |
|Summer Weekday Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |
|Summer Weekday Hour To End Storage Discharge                |Integer  |20             |ELCD                      |
|Summer Weekend Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |
|Summer Weekend Hour To End Storage Discharge                |Integer  |20             |ELCD                      |
|Design Storage Control Charge Power Per Battery             |kW       |1927           |ELCD                      |
|Design Storage Control Discharge Power Per Battery          |kW       |1927           |ELCD                      |
|Storage Control Utility Demand Target                       |kW       |450            |ELCD                      |
|Minimum Storage State Of Charge Fraction                    |(0-1)    |0.05           |ELCD                      |
|Maximum Storage State Of Charge Fraction                    |(0-1)    |0.96           |ELCD                      |

#### Example csv file #2: Battery Storage System Only

This table shows the configuraton of the measure .csv file to model the performance of a 100 kWh Battery System that has been configured to charges
the battery during non-peak hours (differeing by season) and discharge the battery during peak hours, to avoid purchasing on-peak energy 
unitl the battery reaches it's iminimal alowable state of charge (SOC). No on-site energy will be generated. 

The measure uses EnergyPlus "ElectricLoadCenter:Storage:LiIonNMCBattery" object to model battery performance.
EnergPlus documentation for the LiIonNMCBattery object can be found here: https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/InputOutputReference.pdf.

|**Argument Name**                                           |**Units/Range**|**Value**      |**System Component**      |
|------------------------------------------------------------|---------|---------------|--------------------------|
|Max Power Output                                            |kW       |0.01             |PV                        |
|Array Type                                                  |N/A      |OneAxis        |PV                        |
|Module Type                                                 |N/A      |Premium        |PV                        |
|System Losses Fraction                                      |(0 - 100)|17             |PV                        |
|Array Tilt                                                  |Degrees  |30             |PV                        |
|Array Azimuth                                               |Degrees  |180            |PV                        |
|Ground Coverage Ratio                                       |(0 - 100)|35             |PV                        |
|Inverter Efficiency                                         |(0-1)    |0.96           |Inverter                  |
|DC to AC Size Ratio                                         |N/A      |1.1            |Inverter                  |
|Converter Simple Fixed Efficiency                           |(0-1)    |0.94           |Converter                 |
|Converter Ancillary Power Consumed In Standby               |W        |100            |Converter                 |
|Converter Radiative Fraction                                |(0-1)    |0.25           |Converter                 |
|Battery Make Model                                          |N/A      |10 Tesla PowerWall|Storage/Inverter/Converter|
|Nominal Capacity                                            |kWh      |100            |Storage                   |
|Usable Capacity                                             |kWh      |95.0            |Storage                   |
|Rated Power Output                                          |kW       |50              |Storage                   |
|Nominal Voltage                                             |V        |50             |Storage                   |
|Round Trip Efficiency                                       |(0-1)    |0.95           |Storage                   |
|Minimum State Of Charge Fraction                            |(0-1)    |0.1            |Storage                   |
|Maximum State Of Charge Fraction                            |(0-1)    |0.97           |Storage                   |
|Lifetime Model                                              |N/A      |KandlerSmith   |Storage                   |
|Initial Fraction State of Charge                            |(0-1)    |0.95           |Storage                   |
|Percentage of Maximum Charge Power to use for Charging      |fraction |0.8            |ELCD                      |
|Percentage of Maximum Discharge Power to use for Discharging|fraction |0.95           |ELCD                      |
|Summer Month to Begin Storage Season                        |Integer  |3              |ELCD                      |
|Summer Day to Begin Storage Season                          |Integer  |1              |ELCD                      |
|Summer Month to End Storage Season                          |Integer  |9              |ELCD                      |
|Summer Day to End Storage Season                            |Integer  |15             |ELCD                      |
|Winter Weekday Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |
|Winter Weekday Hour To End Storage Discharge                |Integer  |22             |ELCD                      |
|Winter Weekend Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |
|Winter Weekend Hour To End Storage Discharge                |Integer  |22             |ELCD                      |
|Summer Weekday Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |
|Summer Weekday Hour To End Storage Discharge                |Integer  |20             |ELCD                      |
|Summer Weekend Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |
|Summer Weekend Hour To End Storage Discharge                |Integer  |20             |ELCD                      |
|Design Storage Control Charge Power Per Battery             |kW       |19270           |ELCD                      |
|Design Storage Control Discharge Power Per Battery          |kW       |19270           |ELCD                      |
|Storage Control Utility Demand Target                       |kW       |450            |ELCD                      |
|Minimum Storage State Of Charge Fraction                    |(0-1)    |0.05           |ELCD                      |
|Maximum Storage State Of Charge Fraction                    |(0-1)    |0.96           |ELCD                      |

## Measure #5 "revit_create_typical_shw_systems_using_os_standards_gem"
This "OpenStudio" measure is designed to allow Revit users to add 'typical' service hot water peak loads, usage profiles, distribution 
systems and equipment for generating SHW. The measure calls several methods from the "OpenStudio Standard Gem" to accomplish this. 
Revit Users must populate (2) csv files for thos measure to properly operate. 

This measures includes (21) configurable .csv files.

### csv file #1: "Bldg_Level_SHW_Systems_Equip_Eff_Map.csv"

The first .csv file for configuring this measure is named "Bldg_Level_SHW_Systems_Equip_Eff_Map.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 4**. 

For all Rows, Column E of the .csv file describes the allowable enumarations. 

1. **Row 2**: The name of the user-created .csv fileused to link gbXML Space/SpaceTypes to SpaceTypes supported by the OpenStudio Standard Gem.
2. **Row 3**: A text string combining an 'Standard' and a 'BuildingType'. The 'Standard' value will be used to set the SHW equipment efficiency level. 
   Allowable enumerations are decribed in lines (47 - 193) of the measure.rb file.
3. **Row 4**: The type of electric water heater that will be created. Allowable enumerations are described in line 253 of the measure.rb file.

### csv file #2: "<file_name_is_set_by_user>.csv"

The second .csv file for configuring this measure is named by the user, and this file should saved to the /resources directory of the 
measure. Values should be provided in columns A, B and C of the .csv file, with one row created for each 'Space" object found in the 
gbXML file. 

A seperate row shoudl be created for **each** Space object found in the gbXML file.

1. **Column A**: The gbXML Spaceid, extracted from the gbXML file exported by Revit.
2. **Column B**: The gbXML Space Name, extracted from the gbXML file exported by Revit.
3. **Column C**: Either "No SHW" or a string composed of (3) sub-strings whose values are defined within the OS Standards Gem. 
   This string defines the peak hot water temperature and flow rate of hot water consuming fixtures associated with each gbXML Space. 

    "**Standard**-**BuildingType**-**SpaceType**" 

# Revit Workflow Files

## File: "Example 1 Annual Building Energy Simulation.osw" 

This table shows the configuraton of the measure .csv file to model the performance of a 100 kWh Battery System that has been configured to charges
the battery during non-peak hours (differeing by season) and discharge the battery during peak hours, to avoid purchasing on-peak energy 
unitl the battery reaches it's iminimal alowable state of charge (SOC). No on-site energy will be generated. 

The measure uses EnergyPlus "ElectricLoadCenter:Storage:LiIonNMCBattery" object to model battery performance.
EnergPlus documentation for the LiIonNMCBattery object can be found here: https://energyplus.net/assets/nrel_custom/pdfs/pdfs_v23.2.0/InputOutputReference.pdf.

- Add SHW loads and equipment to the Revit generated OpenStudio Model
- Replace Revit generated HVAC systems with user-defined ALL Electric HVAC Systems, using the topology of existing Air Systems and Zone Equipment 
- Apply a user-defined Tariff to monotize predicted energy usage.

The list below describes the sequential order of the measures that are used to create this workflow .osw file. Note that OpenStudio Measures are executed first, followed by EnergyPlus Measures,with the workflow finishing by 
executing all reporting measures. Within these (3) categories, mesures execute sequentially, with the results (outpout)
 from one measure passing as (input) into the next measure.

  1. "Change Building Location" <sup>1</sup>
  2. "ImportGbxml" <sup>1</sup>
  3. "Advanced Import Gbxml" <sup>1</sup>
  4. "GBXML HVAC Import" <sup>1</sup>
  5. "Set Simulation Control" <sup>1</sup>
  6. "gbxml_to_openstudio_cleanup" <sup>1</sup>
  7.  **"Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"** <sup>1</sup>
  8.  **"revit_analyze_all_electric_hvac_systems"** <sup>1</sup>
  9. "Add XML Output Control Style"  <sup>2</sup>
  10. **"revit_analyze_electric_tariff"** <sup>2</sup>
  11. "OpenStudio Results" <sup>3</sup>
  12. "Systems Analysis Report" <sup>3</sup>

 <sup>1</sup>OpenStudio Measure
 <sup>2</sup>EnergyPlus Measure
 <sup>3</sup>Reporting Measure

The Revit command **'File->Options->File Locations'** can be executed, to point Revit to the location of the workflow file.

## File: "Example 1 HVAC Systems Loads and Sizing.osw"

This workflow generates a **HVAC Loads and Sizing"** report" by chaining together these measures into a new json .osw file. 
The workflow extends a 'default' Revit Loads and Sizing workflow by adding (3) new measures that will:

- Add SHW loads and equipment to the Revit generated OpenStudio Model
- Replace Revit generated HVAC systems with user-defined ALL Electric HVAC Systems, using the topology of existing Air Systems and Zone Equipment 
- Apply a user-defined Tariff to monotize predicted energy usage.

The list below describes the sequential order of the measures that are used to create this workflow .osw file. Note that OpenStudio Measures are executed first, followed by EnergyPlus Measures,with the workflow finishing by 
executing all reporting measures. Within these (3) categories, mesures execute sequentially, with the results (outpout)
 from one measure passing as (input) into the next measure.
   
  1. "Change Building Location" <sup>1</sup>
  2. "ImportGbxml" <sup>1</sup>
  3. "Advanced Import Gbxml" <sup>1</sup>
  4. "GBXML HVAC Import" <sup>1</sup>
  5. "Set Simulation Control" <sup>1</sup>
  6. "gbxml_to_openstudio_cleanup" <sup>1</sup>
  7.  **"Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"** <sup>1</sup>
  8.  **"revit_analyze_all_electric_hvac_systems"** <sup>1</sup>
  9. "Add XML Output Control Style"  <sup>2</sup>
  10. **"revit_analyze_electric_tariff"** <sup>2</sup>
  11. "OpenStudio Results" <sup>3</sup>
  12. "Systems Analysis Report" <sup>3</sup>

 <sup>1</sup>OpenStudio Measure
 <sup>2</sup>EnergyPlus Measure
 <sup>3</sup>Reporting Measure

The Revit command **'File->Options->File Locations'** can be executed, to point Revit to the location of the workflow file.

## File: "Example 2 Annual Building Energy Simulation.osw"

This workflow generates an **"Energy Analysis"**  Report" by chaining together these measures into a new json .osw file. 
The workflow extends a 'default' Revit Energy workflow by adding (4) new measures that will:

- Add SHW loads and equipment to the Revit generated OpenStudio Model
- Replace Revit generated HVAC systems with user-defined ALL Electric HVAC Systems, using the topology of existing Air Systems and Zone Equipment 
- Transform this model into an ASHRAE 90.1 Appendix G variant (a 'baseline' building).
- Apply a user-defined Tariff to monetize predicted energy usage.

The list below describes the sequential order of the measures that are used to create this workflow .osw file. Note that OpenStudio Measures are executed first, followed by EnergyPlus Measures,with the workflow finishing by 
executing all reporting measures. Within these (3) categories, mesures execute sequentially, with the results (outpout)
 from one measure passing as (input) into the next measure.
   
  1. "Change Building Location" <sup>1</sup>
  2. "ImportGbxml" <sup>1</sup>
  3. "Advanced Import Gbxml" <sup>1</sup>
  4. "GBXML HVAC Import" <sup>1</sup>
  5. "Set Simulation Control" <sup>1</sup>
  6. "gbxml_to_openstudio_cleanup"<sup>1</sup>
  7.  **"Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"** <sup>1</sup>
  8.  **"revit_analyze_all_electric_hvac_systems"** <sup>1</sup>
  9. **revit_create_baseline_building** <sup>1</sup> 
  10. "Add XML Output Control Style" <sup>2</sup>
  11. **"revit_analyze_electric_tariff"** <sup>2</sup>
  12. "OpenStudio Results" <sup>3</sup>
  13. "Systems Analysis Report" <sup>3</sup>

 <sup>1</sup>OpenStudio Measure
 <sup>2</sup>EnergyPlus Measure
 <sup>3</sup>Reporting Measure

The Revit command **'File->Options->File Locations'** can be executed, to point Revit to the location of the workflow file.

## File: "Example 2 HVAC Systems Loads and Sizing.osw"

This workflow generates a **"HVAC Loads and Sizing"**  Report" by chaining together measures into a new json .osw file. 
The workflow extends a 'default' Revit Energy workflow by adding (4) new measures that will:

- Add SHW loads and equipment to the Revit generated OpenStudio Model
- Replace Revit generated HVAC systems with user-defined ALL Electric HVAC Systems, using the topology of existing Air Systems and Zone Equipment 
- Transform this model into an ASHRAE 90.1 Appendix G variant (a 'baseline' building).
- Apply a user-defined Tariff to monetize predicted energy usage.

The list below describes the sequential order of the measures that are used to create this workflow .osw file. Note that OpenStudio Measures are executed first, followed by EnergyPlus Measures,with the workflow finishing by 
executing all reporting measures. Within these (3) categories, mesures execute sequentially, with the results (outpout)
 from one measure passing as (input) into the next measure.
 
  1. "Change Building Location" <sup>1</sup>
  2. "ImportGbxml" <sup>1</sup>
  3. "Advanced Import Gbxml" <sup>1</sup>
  4. "GBXML HVAC Import" <sup>1</sup>
  5. "Set Simulation Control" <sup>1</sup>
  6. "gbxml_to_openstudio_cleanup"<sup>1</sup>
  7.  **"Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"** <sup>1</sup>
  8.  **"revit_analyze_all_electric_hvac_systems"** <sup>1</sup>
  9. **revit_create_baseline_building** <sup>1</sup> 
  10. "Add XML Output Control Style" <sup>2</sup>
  11. **"revit_analyze_electric_tariff"** <sup>2</sup>
  12. "OpenStudio Results" <sup>3</sup>
  13. "Systems Analysis Report" <sup>3</sup>

 <sup>1</sup>OpenStudio Measure
 <sup>2</sup>EnergyPlus Measure
 <sup>3</sup>Reporting Measure

The Revit command **'File->Options->File Locations'** can be executed, to point Revit to the location of the workflow file.

# Useful Scripts

The "LF_ExtractRevitgbXML.rb" ruby script can be found in the 'scripts' folder of this repository. 
This script can be used with a Revit generated gbXML file to populate a .csv file with the data in the first two columns (needed 
by both the **"revit_create_baseline_building"** and **"Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"** OpenStudio measures). 

A special shoutout to **Lucas Denit @ Lake|Flato Architects**  for developing and sharing this useful script. 

# Useful Links
Revit 2024 installations include a 'special' (slimmed down) build of the OpenStudio v3.4.0 Command Line Interface (CLI).  
Users authoring custom OpenStudio measures for Revit 2024 should seperately download:

1. [OpenStudio API/SDK (v3.4.0)](https://github.com/NREL/OpenStudio/releases/tag/v3.4.0) 
2. [OpenStudio Application (v1.4.0)](https://github.com/openstudiocoalition/OpenStudioApplication/releases/tag/v1.4.0)

"Everything" is a search engine for Windows that locates files and folders by filename instantly. For developing and testing custom workflows,
It can be a useful debugging tool, primarilly for visualizing how OpenStudio workflows are executing and to see where and when log files are created. 
"Everything" can be downloaded here: https://www.voidtools.com/downloads/