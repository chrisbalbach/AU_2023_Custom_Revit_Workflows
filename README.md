# AU_2023_Custom_Revit_Workflows
This repository contains the Revit Projects, OpenStudio Measures and Revit Workflows needed to reproduce the work presented at the AU 2023 Session 602389 Titled "Design and Analysis of Building Electrification with Revit Systems Analysis" 

## Table of Content 

* [Revit Projects](#revit-projects)
* [OS Measures used by Revit Workflows](#os-measures-used-by-revit-workflows)
* [Revit Workflow files](#revit-workflow-files)
* [Useful Scripts](#useful-scripts)
* [Useful Links](#useful-links)

# Dependencies

Users attempting to recreate the work demonstrated during this AU class should ensure they install: 

1. Revit 2024.1 (this version of Revit does not support ASHRAE 90.1-2016 or ASHRAE90.1-2019) 
2. OpenStudio v3.4.0 
3. OpenStudio Application v1.4.0
4. A text editor (Visual Studio Code, Notepad++, etc.)

# Demonstration Revit Project

The Revit File **"Retail Big Box_Example.rvt"** was demonstrated during the course. This file can be found in the "Revit Files" directory of this repository. 

Users creating custom Revit workflows should carefully review the existing topology of "Air Systems" and "Zone Equipment" objects that have been created in 
this file, using the Revit UI for Analytical Systems.

Using Revit, the existing "Air Systems" and "Zone Equipment" objects and their connections to "Analytical Spaces" may be deleted/recreated. 
New "Air Systems" and "Zone Equipment" objects and connections to Analytical Spaces may be defined by the user, as part of exercising these workflows.    

# OS Measures used by Revit Workflows

The following OpenStudio measures are included in this repository. These measures can be downloaded, edited, and used to create custom OS Based workflows, in Revit. 

1. "revit_analyze_all_electric_hvac_systems" 
2. "revit_analyze_electric_tariff"
3. "revit_create_baseline_building" 
4. "revit_add_pv_add_storage_tou"
5. "revit_create_typical_shw_systems_using_os_standards_gem"

Each of these measures requires the user to create (pre-process) at least (1) .csv file. In some cases, the pre-processed csv files will need informaiton that 
can be found within the Revit gbXML file export. 

## Measure 1: "revit_analyze_all_electric_hvac_systems"

This "OpenStudio" measure is designed to allow Revit users to configure and model additional OpenStudio "Air Systems" and "Zone Equipment" HVAC Systems,  
beyond those available in the Revit Analytical Systems UI. The measure leverages HVAC system topologies created using the Revit UI, **replacing all**
pre-defined "Air System" and **replacing all**  predefined "Zone Equipment" OpenStudio objects with new "Air System" and "Zone Equipment" objects based on
user selections. 

For **all new** HVAC systems, existing System/Zone relationships are preserved. The OpenStudio Application can be used to open the "in.osm" file, where the 
detailed properties of the **new** HVAC systems can be inspected. All HVAC systems created by this measure are 'auto-sized' - the name of the HVAC system object 
(available by inspecting the 'in.osm' OpenStudio model file osm) OR EnergyPlus output reports) will contain the autosized capacities of coils, pumps, etc. 

This measure uses powerful model articulation methods such as "standard.model_add_hvac_system", included in v0.4.0 of the OpenStudio Standards gem: "https://github.com/NREL/openstudio-standards/releases/tag/v0.4.0".
The measure creates many different HVAC systems, whose properties are either: 
1. Defaulted to values set within the OpenStudio Standards gem
2. Set to 'regulated' values defined by the selected ASHRAE standard.

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

## Measure 2: "revit_analyze_electric_tariff"

This "EnergyPlus" measure is designed to allow a Revit user to apply electric tariffs of different levels of complexity to OpenStudio models created using Revit. The measure can be used to model very 
simple tariffs such as a fixed $/kWh rate for all hours or the year. The measure can also be used to model seperate 'time-of-use' and accumulating block tarrifs for power and energy, 
for both a electricity supplier and an electricity tranmission and distribution provider. Scenarios of differing tariff complexity can be mapped into the 

### csv file #1: "Electric_Utility_Tariff_Arguments.csv"

The .csv file for configuring this measure is named "Electric_Utility_Tariff_Arguments.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B of the .csv file, for **Row 2 through Row 65**. 

For all Rows, Column E of the .csv file describes the allowable enumarations. 

#### example csv file #1 Simple Tariff

This table shows the configuraton of the .csv file for a **flat energy tariff of $0.15 / kWh**. 

* No demand charges are modeled.
* No (peak/on peak) hourly time-of-use charges are modeled.
* No seasonal (summer/nonsummer) charges are modeled.
* A single supplier tariff is modeled (**all** energy cost values associated with the T&D Tariff are zero).

|**Argument Name**                             |**Value**    |**Type**|**Units** |**Source of Value**                                                                                   |**Element Category**         |**Required/Optional**|
|----------------------------------------------|-------------|-------|-----------|------------------------------------------------------------------------------------------------------|-----------------------------|---Required--------------|
|tariff_name                                   |Simple Tariff|       |N/A        |user defined                                                                                          |General Info                 |Required         |
|demand_window_length                          |QuarterHour  |String |N/A        |measure.rb lines (1218 - 1222)                                                                        |General Info                 | Required                |
|summer_start_month                            |5            |Integer|month      |user defined                                                                                          |General Info                 |Required                 |
|summer_start_day                              |15           |Integer|day        |user defined                                                                                          |General Info                 |Required                 |
|summer_end_month                              |9            |Integer|month      |user defined                                                                                          |General Info                 |Required                |
|summer_end_day                                |15           |Integer|day        |user defined                                                                                          |General Info                 |Required                 |
|peak_start_hour                               |12           |Integer|hour of day|user defined                                                                                          |General Info                 |Required                |
|peak_end_hour                                 |18           |Integer|hour of day|user defined                                                                                          |General Info                 |Required                 |
|supply_elec_rate_sum_peak                     |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_elec_rate_sum_nonpeak                  |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_elec_rate_nonsum_peak                  |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_elec_rate_nonsum_nonpeak               |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_elec_demand_sum                        |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_elec_demand_nonsum                     |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_monthly_charge                         |0            |Double |$          |user defined                                                                                          |Supplier                     |                 |
|supply_qualifying_min_monthly_demand          |1            |Double |kW         |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_block_1_size               |30000        |Double |kWh        |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_block_1_cost_per_kwh       |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_block_2_size               |50000        |Double |kWh        |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_block_2_cost_per_kwh       |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_remaining_cost_per_kwh     |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_block_1_size               |30000        |Double |kWh        |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_block_1_cost_per_kwh       |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_block_2_size               |50000        |Double |kWh        |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_block_2_cost_per_kwh       |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_remaining_cost_per_kwh     |0.15         |Double |$/kWh      |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_demand_block_1_size        |0            |Double |kW         |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_demand_block_1_cost_per_kw |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_demand_block_2_size        |0            |Double |kW         |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_demand_block_2_cost_per_kw |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_summer_elec_remaining_cost_per_kw      |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_demand_block_1_size        |0            |Double |kW         |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_demand_block_1_cost_per_kw |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_demand_block_2_size        |0            |Double |kW         |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_demand_block_2_cost_per_kw |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|supply_winter_elec_remaining_cost_per_kw      |0            |Double |$/kW       |user defined                                                                                          |Supplier                     |                 |
|t_and_d_elec_rate_sum_peak                    |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_elec_rate_sum_nonpeak                 |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_elec_rate_nonsum_peak                 |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_elec_rate_nonsum_nonpeak              |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_elec_demand_sum                       |0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_elec_demand_nonsum                    |0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_monthly_charge                        |0            |Double |$          |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_qualifying_min_monthly_demand         |0            |Double |kW         |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_block_1_size              |30000        |Double |kWh        |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_block_2_size              |50000        |Double |kWh        |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_remaining_cost_per_kwh    |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_block_1_size              |30000        |Double |kWh        |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_block_1_cost_per_kwh      |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_block_2_size              |50000        |Double |kWh        |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_block_2_cost_per_kwh      |0            |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_remaining_cost_per_kwh    |5.3          |Double |$/kWh      |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_demand_block_1_size       |10           |Double |kW         |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_demand_block_2_size       |50           |Double |kW         |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_summer_elec_remaining_cost_per_kw     |0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_demand_block_1_size       |10           |Double |kW         |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_demand_block_1_cost_per_kw|0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_demand_block_2_size       |0            |Double |kW         |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_demand_block_2_cost_per_kw|0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |
|t_and_d_winter_elec_remaining_cost_per_kw     |0            |Double |$/kW       |user defined                                                                                          |Transmission and Distribution|                 |



## Measure #3 "revit_create_baseline_building"

## Measure #4 "revit_add_pv_add_storage_tou"

This "OpenStudio" measure is designed to allow Revit users to estimate the energy and power impacts from a 'behind the meter' BES (Battery Energy Storage) system composed of a 
configurable PV System, a configurable Lithium Ion Battery Bank, and a configurable Battery Manageement System.
The measure **adds new** objects for these components, based on user-defined parameters. The Standard EnergyPlus Output report can be viewed 
from within Revit, to show the annual energy and peak power impacts of the BES. 

The measure can be used to model a 'Storage Only" scenario by specifying a PV System with a very small value  for the PV 'Max Power Output' variable (for example, 0.1 kW).
The measure can be used to model a 'PV Only" scenario by specifying a Battery System with a very small value Battery 'Usable Capacity' variable (for example, 0.1 kW).
'Matched' BES systems (PV + PowerWall, PV + PowerPack, etc.) can be modeled by carefully defining PV System and BES properties.

This measure is often combined with the OpenStudo Tariff measure into custom Revit Workflows for evaluating BES arbitrage opportunities for facilities with known periods of high cost 
seasonal and time-of-day tariffs. The BES system is desinged to offset 'purchased' electricity demands when it is most expensive (on-peak periods), leveraging the PV/BES to and 
meet facilty energy demands.

#### csv file #1 revit_add_pv_add_storage_tou: "PV_Battery_Inputs.csv"

|**Argument Name**                                           |**Units**|**Value**      |**System Component**      |**Source of Value**                                    |
|------------------------------------------------------------|---------|---------------|--------------------------|-------------------------------------------------------|
|Max Power Output                                            |kW       |30             |PV                        |defined by user                                        |
|Array Type                                                  |N/A      |OneAxis        |PV                        |See measure.rb lines (36-40) for allowable enumerations|
|Module Type                                                 |N/A      |Premium        |PV                        |See measure.rb lines (50-52) for allowable enumerations|
|System Losses Fraction                                      |(0 - 100)|17             |PV                        |defined by user                                        |
|Array Tilt                                                  |Degrees  |30             |PV                        |defined by user                                        |
|Array Azimuth                                               |Degrees  |270            |PV                        |defined by user                                        |
|Ground Coverage Ratio                                       |(0 - 100)|35             |PV                        |defined by user                                        |
|Inverter Efficiency                                         |(0-1)    |0.96           |Inverter                  |defined by user                                        |
|DC to AC Size Ratio                                         |N/A      |1.1            |Inverter                  |defined by user                                        |
|Converter Simple Fixed Efficiency                           |(0-1)    |0.94           |Converter                 |defined by user                                        |
|Converter Ancillary Power Consumed In Standby               |W        |100            |Converter                 |defined by user                                        |
|Converter Radiative Fraction                                |(0-1)    |0.25           |Converter                 |defined by user                                        |
|Battery Make Model                                          |N/A      |Tesla PowerWall|Storage/Inverter/Converter|defined by user                                        |
|Nominal Capacity                                            |kWh      |10             |Storage                   |defined by user                                        |
|Usable Capacity                                             |kWh      |9.5            |Storage                   |defined by user                                        |
|Rated Power Output                                          |kW       |5              |Storage                   |defined by user                                        |
|Nominal Voltage                                             |V        |50             |Storage                   |defined by user                                        |
|Round Trip Efficiency                                       |(0-1)    |0.95           |Storage                   |defined by user                                        |
|Minimum State Of Charge Fraction                            |(0-1)    |0.1            |Storage                   |defined by user                                        |
|Maximum State Of Charge Fraction                            |(0-1)    |0.97           |Storage                   |defined by user                                        |
|Lifetime Model                                              |N/A      |KandlerSmith   |Storage                   |defined by user                                        |
|Initial Fraction State of Charge                            |(0-1)    |0.95           |Storage                   |defined by user                                        |
|Percentage of Maximum Charge Power to use for Charging      |fraction |0.8            |ELCD                      |defined by user                                        |
|Percentage of Maximum Discharge Power to use for Discharging|fraction |0.95           |ELCD                      |defined by user                                        |
|Summer Month to Begin Storage Season                        |Integer  |3              |ELCD                      |defined by user                                        |
|Summer Day to Begin Storage Season                          |Integer  |1              |ELCD                      |defined by user                                        |
|Summer Month to End Storage Season                          |Integer  |9              |ELCD                      |defined by user                                        |
|Summer Day to End Storage Season                            |Integer  |15             |ELCD                      |defined by user                                        |
|Winter Weekday Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |defined by user                                        |
|Winter Weekday Hour To End Storage Discharge                |Integer  |22             |ELCD                      |defined by user                                        |
|Winter Weekend Hour To Begin Storage Discharge              |Integer  |9              |ELCD                      |defined by user                                        |
|Winter Weekend Hour To End Storage Discharge                |Integer  |22             |ELCD                      |defined by user                                        |
|Summer Weekday Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |defined by user                                        |
|Summer Weekday Hour To End Storage Discharge                |Integer  |20             |ELCD                      |defined by user                                        |
|Summer Weekend Hour To Begin Storage Discharge              |Integer  |11             |ELCD                      |defined by user                                        |
|Summer Weekend Hour To End Storage Discharge                |Integer  |20             |ELCD                      |defined by user                                        |
|Design Storage Control Charge Power Per Battery             |kW       |1927           |ELCD                      |defined by user                                        |
|Design Storage Control Discharge Power Per Battery          |kW       |1927           |ELCD                      |defined by user                                        |
|Storage Control Utility Demand Target                       |kW       |450            |ELCD                      |defined by user                                        |
|Minimum Storage State Of Charge Fraction                    |(0-1)    |0.05           |ELCD                      |defined by user                                        |
|Maximum Storage State Of Charge Fraction                    |(0-1)    |0.96           |ELCD                      |defined by user                                        |
 

## 5) revit_create_typical_shw_systems_using_os_standards_gem

# Revit Workflow files

## Example 1 Annual Building Energy Simulation

## Example 1 HVAC Systems Loads and Sizing

## Example 2 Annual Building Energy Simulation

## Example 2 HVAC Systems Loads and Sizing

# Useful Scripts

# Useful Links