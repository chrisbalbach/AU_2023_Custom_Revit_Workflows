# AU_2023_Custom_Revit_Workflows
This repository contains the Revit Projects, OpenStudio Measures and Revit Workflows needed to reproduce the work presented at the AU 2023 Session 602389 Titled "Design and Analysis of Building Electrification with Revit Systems Analysis" 

## Table of Content 

* [Revit Projects](#revit-projects)
* [OS Measures used by Revit Workflows](#os-measures-used-by-revit-workflows)
* [Revit Workflow files](#revit-workflow-files)
* [Useful Scripts](#useful-scripts)
* [Useful Links](#useful-links)

# Revit Projects

The Revit File "Retail Big Box_Example.rvt" was used during the course. It can be found in the Revit Files directory of this repository. 
Users creating Revit workflows that include the "revit_analyze_all_electric_hvac_systems" measure should carefully review the
existing topology of Air Systems and Zone Equipment objects that have been created and using Revit Analytical Systems.
These Air Systems and Zone Equipment objects may be deleted/recreated, and connections to (conditioned) Analytical Spaces may
be redefined by the user, as part of exwercising these workflows.    

# OS Measures used by Revit Workflows

The following measures are included in this repository. These measures can be downloaded, edited, and used to create custom OS Based workflows, in Revit. 

Each measure requires the user to create (pre-process) at least (1) csv file.

## 1) revit_analyze_all_electric_hvac_systems

This measure is designed to allow Revit users to configure and model additional OpenStudio HVAC "Air Systems" and HVAC "Zone Equipment" 
that can be connected to Revit 'Analytical Spaces'. This measure uses methods such as "standard.model_add_hvac_system" 
from the 0.4.0 version of the OpenStudio Standards gem: "https://github.com/NREL/openstudio-standards/releases/tag/v0.4.0".


### csv file: "Building_Level_Mappings.csv"
The csv file for configuring this measure is named "Building_Level_Mappings.csv", and it is located in the /resources directory of the 
measure. Values should be provided in column B for Rows (2 - 5).  

1. Row 2: An ASHRAE Standard 90.1.2xxx - Used to determine regulated HVAC Equipment efficiencies and controls
2. Row 3: One type of new 'Air System' - Used to define the 'Air Systems' objects to model. In the OpenStudio energy model, these 'Air Systems' will replace ALL Air Systems 
previously created using Revit Systems Analysis.  
3. Row 4: One type of new 'Zone Equipment' - Used to define the 'Zone Equipment' objects to model. In the OpenStudio energy model, these 'Zone Equipment'
 will replace ALL 'Zone Equipment' previously created using Revit Systems Analysis.
4. Row 5: An ASHRAE Standard 169-2006  Climate Zone - Used by measure along with the ASHRAE Standard to determine HVAC system control requirements, such as air-side economizers

Optional (parameter override) values can be provided in Column B for Rows (6 - 10).

Measure code for using values in Column B for Rows (11 - 41) have not yet been written.


## 2) revit_analyze_electric_tariff

## 3) revit_create_baseline_building

## 4) revit_add_pv_add_storage_tou

## 5) revit_create_typical_shw_systems_using_os_standards_gem

# Revit Workflow files

## Example 1 Annual Building Energy Simulation

## Example 1 HVAC Systems Loads and Sizing

## Example 2 Annual Building Energy Simulation

## Example 2 HVAC Systems Loads and Sizing

# Useful Scripts

# Useful Links