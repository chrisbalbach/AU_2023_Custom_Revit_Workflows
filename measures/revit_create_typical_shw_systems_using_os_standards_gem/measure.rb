# insert your copyright here

# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

# load OpenStudio Libraries
require 'openstudio-standards'
require 'openstudio-extension'
require 'openstudio/extension/core/os_lib_helper_methods'
require 'openstudio/extension/core/os_lib_model_generation'

# include OsLib_HelperMethods
include OsLib_ModelGeneration

# start the measure
class RevitCreateTypicalSHWSystemsUsingOSStandardsGem < OpenStudio::Measure::ModelMeasure

  # human readable name
  def name
    return "Revit_Create_Typical_SHW_Systems_Using_OS_Standards_Gem"
  end

  # human readable description
  def description
    return "This measure adds Service Hot Water loads and Service Hot Water equipment to a Revit generated OpenStudio model, using the OpenStudio Standards Gem."
  end

  # human readable description of modeling approach
  def modeler_description
    return "This measure uses 'sidecar' .csv files to provied a mapping of Revit Analytical Space objects (visible in the Revit generated gbxml file) and (Template/Building/Space) strings that define how water loads and generation, inside the OpenStudio Standards Gem."
  end

  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Measure::OSArgumentVector.new

    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)  # Do **NOT** remove this line

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end

    # Allowable enumeratuions for the (Building Level) value of the Standards 'Template' and the Building Type. 
    # This is used to set the efficiency of SHW System(s) added to the Revit generated .osm 
    # NOT ALL (Template*Building Type) choices are valid - see supported list, below: 
    # 90.1-2004*Courthouse
    # 90.1-2007*Courthouse
    # 90.1-2010*Courthouse
    # 90.1-2013*Courthouse
    # DOE Ref 1980-2004*Courthouse
    # DOE Ref Pre-1980*Courthouse
    # 90.1-2004*FullServiceRestaurant
    # 90.1-2007*FullServiceRestaurant
    # 90.1-2010*FullServiceRestaurant
    # 90.1-2013*FullServiceRestaurant
    # DOE Ref 1980-2004*FullServiceRestaurant
    # DOE Ref Pre-1980*FullServiceRestaurant
    # NREL ZNE Ready 2017*FullServiceRestaurant
    # 90.1-2004*HighriseApartment
    # 90.1-2007*HighriseApartment
    # 90.1-2010*HighriseApartment
    # 90.1-2013*HighriseApartment
    # 90.1-2004*Hospital
    # 90.1-2007*Hospital
    # 90.1-2010*Hospital
    # 90.1-2013*Hospital
    # DOE Ref 1980-2004*Hospital
    # DOE Ref Pre-1980*Hospital
    # 90.1-2004*LargeDataCenterHighITE
    # 90.1-2007*LargeDataCenterHighITE
    # 90.1-2010*LargeDataCenterHighITE
    # 90.1-2013*LargeDataCenterHighITE
    # 90.1-2004*LargeDataCenterLowITE
    # 90.1-2007*LargeDataCenterLowITE
    # 90.1-2010*LargeDataCenterLowITE
    # 90.1-2013*LargeDataCenterLowITE
    # 90.1-2004*LargeHotel
    # 90.1-2007*LargeHotel
    # 90.1-2010*LargeHotel
    # 90.1-2013*LargeHotel
    # DOE Ref 1980-2004*LargeHotel
    # DOE Ref Pre-1980*LargeHotel
    # NREL ZNE Ready 2017*LargeHotel
    # 90.1-2004*LargeOffice
    # 90.1-2007*LargeOffice
    # 90.1-2010*LargeOffice
    # 90.1-2013*LargeOffice
    # DOE Ref 1980-2004*LargeOffice
    # DOE Ref Pre-1980*LargeOffice
    # 90.1-2004*LargeOfficeDetailed
    # 90.1-2007*LargeOfficeDetailed
    # 90.1-2010*LargeOfficeDetailed
    # 90.1-2013*LargeOfficeDetailed
    # DOE Ref 1980-2004*LargeOfficeDetailed
    # DOE Ref Pre-1980*LargeOfficeDetailed
    # 90.1-2004*MediumOffice
    # 90.1-2007*MediumOffice
    # 90.1-2010*MediumOffice
    # 90.1-2013*MediumOffice
    # DOE Ref 1980-2004*MediumOffice
    # DOE Ref Pre-1980*MediumOffice
    # NREL ZNE Ready 2017*MediumOffice
    # 90.1-2004*MediumOfficeDetailed
    # 90.1-2007*MediumOfficeDetailed
    # 90.1-2010*MediumOfficeDetailed
    # 90.1-2013*MediumOfficeDetailed
    # DOE Ref 1980-2004*MediumOfficeDetailed
    # DOE Ref Pre-1980*MediumOfficeDetailed
    # 90.1-2004*MidriseApartment
    # 90.1-2007*MidriseApartment
    # 90.1-2010*MidriseApartment
    # 90.1-2013*MidriseApartment
    # DOE Ref 1980-2004*MidriseApartment
    # DOE Ref Pre-1980*MidriseApartment
    # NREL ZNE Ready 2017*MidriseApartment
    # 90.1-2004*Outpatient
    # 90.1-2007*Outpatient
    # 90.1-2010*Outpatient
    # 90.1-2013*Outpatient
    # DOE Ref 1980-2004*Outpatient
    # DOE Ref Pre-1980*Outpatient
    # 90.1-2004*PrimarySchool
    # 90.1-2007*PrimarySchool
    # 90.1-2010*PrimarySchool
    # 90.1-2013*PrimarySchool
    # DOE Ref 1980-2004*PrimarySchool
    # DOE Ref Pre-1980*PrimarySchool
    # 90.1-2004*QuickServiceRestaurant
    # 90.1-2007*QuickServiceRestaurant
    # 90.1-2010*QuickServiceRestaurant
    # 90.1-2013*QuickServiceRestaurant
    # DOE Ref 1980-2004*QuickServiceRestaurant
    # DOE Ref Pre-1980*QuickServiceRestaurant
    # NREL ZNE Ready 2017*QuickServiceRestaurant
    # 90.1-2004*RetailStandalone
    # 90.1-2007*RetailStandalone
    # 90.1-2010*RetailStandalone
    # 90.1-2013*RetailStandalone
    # DOE Ref 1980-2004*RetailStandalone
    # DOE Ref Pre-1980*RetailStandalone
    # NREL ZNE Ready 2017*RetailStandalone
    # 90.1-2004*RetailStripmall
    # 90.1-2007*RetailStripmall
    # 90.1-2010*RetailStripmall
    # 90.1-2013*RetailStripmall
    # DOE Ref 1980-2004*RetailStripmall
    # DOE Ref Pre-1980*RetailStripmall
    # NREL ZNE Ready 2017*RetailStripmall
    # 90.1-2004*SecondarySchool
    # 90.1-2007*SecondarySchool
    # 90.1-2010*SecondarySchool  
    # 90.1-2013*SecondarySchool
    # DOE Ref 1980-2004*SecondarySchool
    # DOE Ref Pre-1980*SecondarySchool
    # 90.1-2004*SmallDataCenterHighITE
    # 90.1-2007*SmallDataCenterHighITE
    # 90.1-2010*SmallDataCenterHighITE
    # 90.1-2013*SmallDataCenterHighITE
    # 90.1-2004*SmallDataCenterLowITE
    # 90.1-2007*SmallDataCenterLowITE
    # 90.1-2010*SmallDataCenterLowITE
    # 90.1-2013*SmallDataCenterLowITE
    # 90.1-2004*SmallHotel
    # 90.1-2007*SmallHotel
    # 90.1-2010*SmallHotel
    # 90.1-2013*SmallHotel
    # DOE Ref 1980-2004*SmallHotel
    # DOE Ref Pre-1980*SmallHotel
    # 90.1-2004*SmallOffice
    # 90.1-2007*SmallOffice
    # 90.1-2010*SmallOffice
    # 90.1-2013*SmallOffice
    # DOE Ref 1980-2004*SmallOffice
    # DOE Ref Pre-1980*SmallOffice
    # 90.1-2004*SmallOfficeDetailed
    # 90.1-2007*SmallOfficeDetailed
    # 90.1-2010*SmallOfficeDetailed
    # 90.1-2013*SmallOfficeDetailed
    # DOE Ref 1980-2004*SmallOfficeDetailed
    # DOE Ref Pre-1980*SmallOfficeDetailed
    # 90.1-2004*SuperMarket
    # 90.1-2007*SuperMarket
    # 90.1-2010*SuperMarket
    # 90.1-2013*SuperMarket
    # DOE Ref 1980-2004*SuperMarket
    # DOE Ref Pre-1980*SuperMarket
    # 90.1-2004*Warehouse
    # 90.1-2007*Warehouse
    # 90.1-2010*Warehouse
    # 90.1-2013*Warehouse
    # DOE Ref 1980-2004*Warehouse
    # DOE Ref Pre-1980*Warehouse
    ####################################'
    
    # Allowable enumeratuions for Space level existing Hot Water LOAD values. These properties are from buildings defined as 
    # 'prototypes', by the OS Standards Gem. 

    # NOT ALL possible (Template*BuildingType*Spacetype) choices are valid - see supported list, below: 
    # 189.1-2009*Office*WholeBuilding - Lg Office
    # 90.1-2013*Hospital*PhysTherapy
    # 90.1-2013*Hospital*Radiology
    # 189.1-2009*Office*WholeBuilding - Md Office
    # 90.1-2013*Office*WholeBuilding - Lg Office
    # 90.1-2010*Office*WholeBuilding - Sm Office
    # 189.1-2009*Hospital*Lab
    # 90.1-2004*Office*WholeBuilding - Md Office
    # 189.1-2009*Outpatient*PhysicalTherapy
    # 189.1-2009*Outpatient*Xray
    # 90.1-2013*Outpatient*PhysicalTherapy
    # 90.1-2004*SuperMarket*Deli
    # 90.1-2004*SuperMarket*Bakery
    # 90.1-2004*Outpatient*Xray
    # 189.1-2009*Outpatient*MRI
    # 189.1-2009*LargeHotel*GuestRoom
    # 189.1-2009*Hospital*ER_Exam
    # 189.1-2009*Hospital*ER_Trauma
    # 189.1-2009*Hospital*ER_Triage
    # 189.1-2009*Hospital*OR
    # 189.1-2009*Outpatient*ProcedureRoom
    # 90.1-2013*Hospital*PatRoom
    # 90.1-2004*HighriseApartment*Apartment
    # 90.1-2004*MidriseApartment*Apartment
    # 189.1-2009*Outpatient*PreOp
    # 90.1-2004*Outpatient*MRI
    # 90.1-2004*LargeHotel*GuestRoom2
    # 189.1-2009*SmallHotel*GuestRoom
    # 189.1-2009*Outpatient*MRI_Control
    # 90.1-2004*SmallHotel*GuestRoom123Occ
    # 90.1-2013*Outpatient*PACU
    # 90.1-2004*Outpatient*ProcedureRoom
    # 90.1-2013*SecondarySchool*Gym
    # 90.1-2013*Outpatient*PreOp
    # 189.1-2009*Outpatient*Anesthesia
    # 189.1-2009*Outpatient*PACU
    # 90.1-2013*Outpatient*MRI_Control
    # 189.1-2009*Outpatient*OR
    # 90.1-2010*Hospital*Kitchen
    # 90.1-2004*Outpatient*Anesthesia
    # 189.1-2009*SecondarySchool*Restroom
    # 90.1-2004*Outpatient*OR
    # 189.1-2009*PrimarySchool*Restroom
    # 189.1-2009*QuickServiceRestaurant*Kitchen
    # 90.1-2013*PrimarySchool*Kitchen
    # 189.1-2009*SecondarySchool*Kitchen
    # 189.1-2009*SmallHotel*Laundry
    # 90.1-2013*FullServiceRestaurant*Kitchen
    # 90.1-2013*LargeHotel*Kitchen
    # 90.1-2013*LargeHotel*Laundry
    ##########################################
    
    # Enumeraitons for the Service Water Equipment Heating Fuel source - The source of heating to be used by (new) SWH systems. 
    # Valid choices are 'NaturalGas', 'Electricity', 'HeatPump'
    # Note: If HeatPump" is chosen, a HPWH is modeled as an Electric Storage Water Heater with a CONSTANT (temperature independent) COP of 2.8  
    # This CAN sufficiently represent the annual performance of a HPWH, highly depending on the HPWH ambient temperature conditions (weather file location). 
    # A possible improvement to this HPWH 'work around' would be to have an (HDD based) constant COP.  
  
    # declare variables for proper scope
    gbxml_space_ids = []
    space_shw_load_mapping_csv_file_name = nil 
    os_standards_shw_equip_fuel_source = nil 
    os_standards_shw_template_buildingtype_spacetype = []
    os_standards_shw_equip_template_building_type = nil

    # report initial condition of model
    num_water_heater_mixed = model.getWaterHeaterMixeds.size
    num_water_heater_heatpump = model.getWaterHeaterHeatPumps.size
    runner.registerInitialCondition("The measure with #{model.getWaterUseEquipmentDefinitions.size} Service Water Use Objects and #{num_water_heater_mixed + num_water_heater_heatpump} Service Water Heating objects.")

    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "Bldg_Level_SHW_Systems_Equip_Eff_Map.csv"))), headers: true) do |row|
      space_shw_load_mapping_csv_file_name = row[1].to_s if (row[0] == "space_shw_load_mapping_csv_file_name")
      os_standards_shw_equip_template_building_type = row[1].to_s if (row[0] == "os_standards_shw_equip_template_building_type")
      os_standards_shw_equip_fuel_source = row[1].to_s if (row[0] == "os_standards_shw_equip_fuel_source")
    end
    
    if not ["Electricity", "NaturalGas", "HeatPump"].include? os_standards_shw_equip_fuel_source
      runner.registerError("The value of the SHW Systems Fuel Source of '#{os_standards_shw_equip_fuel_source}' is not recognized. Please correct the enumeration in the csv file.") 
    end
    
    # ensure space shw map_csv_filename exists as a .csv file
    if space_shw_load_mapping_csv_file_name == nil
      runner.registerError("No value found for Argument Name: 'Space SHW Map .csv file name' in Bldg_Level_Exg_SHW_Systems_Equip_Eff_Map.csv file")
    end
    file_path = File.expand_path(File.join(File.dirname(__FILE__), 'resources', "#{space_shw_load_mapping_csv_file_name}"))
    unless File.exist?(file_path) && file_path.downcase.end_with?('.csv')
      runner.registerError("'#{space_shw_load_mapping_csv_file_name}' does not exist in the resources directory of this measure, or the file does not end with a .csv extension.")
    end
    
    # Split the 'os_standards_shw_equip_template_building_type' string into an array of (2) seperate strings based on the * character
    equip_array = os_standards_shw_equip_template_building_type.split("*", 2)
    
    # Retrieve template and buildingtype values from the array and assign them to the OS model  
    template = equip_array[0]
    buildingtype = equip_array[1]
    
    # store original values of StandardsTemplate and StandardsBuildingType for later re-assignment
    exg_standards_template = nil
    if model.getBuilding.standardsTemplate.is_initialized
      exg_standards_template = model.getBuilding.standardsTemplate.get
    end
    exg_standards_buildingtype = nil
    if model.getBuilding.standardsBuildingType.is_initialized
      exg_standards_buildingtype = model.getBuilding.standardsBuildingType.get
    end
    
    # set values of building.StandardsTemplate and building.StandardsBuildingType to values needed for Hot Water System equipment generation    
    model.getBuilding.setStandardsTemplate(template)
    model.getBuilding.setStandardsBuildingType(buildingtype)
    
    # For Hot Water Loads, declare arrays for holding the 'typical' service water loads and behavior, each space in the model will need to be mapped to an OpenStudio spacetype.
    # defined in the standrds gem. The spacetype defines SHW system properties such as shw system type, shw systems temperature, flow rate fractions, etc. 
    # Unlike lighting, constructions, etc, these SHW properties are stored in standards json files, keyed by the spacetype name.
    # As such, spacetypes holding the proper strings for a template, a buildingtype and a spacetype need to be created.
    # space types from different building types can be applied to a space. See "Space Types" tab at 
    # https://docs.google.com/spreadsheets/d/15-mlZrWbA4srtFHtWRP1dgPeuI5plFdjCb1B79fEukI/edit?usp=sharing  
    os_standards_shw_template = []
    os_standards_shw_building_type = []
    os_standards_shw_spacetype = []

    # Retrieve informaiton for creating typical SHW Loads from csv file (ignore header row) 
    # The unique key in the file is the gbxml space 'id' attribute. The order of the rows in the file does not matter
    # Note: It is possible for the 'wrong' type of argument (integer vs string, etc.) to be provided in the csv file. 
    # Variable type checking should be performed at the interface layer that creates the csv file
    # See commented data in arguments method above for variable types and allowable string enumerations, for the arguments
    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "#{space_shw_load_mapping_csv_file_name}"))), headers: true) do |row|
      if (row[2].to_s != "No SHW")
        gbxml_space_ids << row[0]
        # Split the string into an array of (3) strings: (template, buildingtype, spacetype), based on the '*' character
        os_standards_shw_template_buildingtype_spacetype = row[2].to_s.split("*", 3)
        
        # Retrieve SHW template, building and spacetype values from the array and append them to arrays
        os_standards_shw_template << os_standards_shw_template_buildingtype_spacetype[0]
        os_standards_shw_building_type << os_standards_shw_template_buildingtype_spacetype[1]
        os_standards_shw_spacetype << os_standards_shw_template_buildingtype_spacetype[2]
        runner.registerInfo("Revit/gbXML Space named '#{row[1]}' will have hot water loads added using the OS Standards Gem: Template='#{os_standards_shw_template_buildingtype_spacetype[0]}', BuildingType='#{os_standards_shw_template_buildingtype_spacetype[1]}', SpaceType='#{os_standards_shw_template_buildingtype_spacetype[2]}'.")
      end
    end

    # Loop through gbxml space ID's to find a matching OS Space, using the OS Space name. When found, create a new OS Spacetype object and assign it to the OS Space object 
    gbxml_space_ids.each_with_index do |gbxml_space_id, index|
      space_id_found = false
      model.getSpaces.each do |space|
        if (space.name.get == gbxml_space_id)
          space_id_found = true
          revit_dhw_space_type = OpenStudio::Model::SpaceType.new(model)
          revit_dhw_space_type.setStandardsTemplate(os_standards_shw_template[index])
          revit_dhw_space_type.setStandardsBuildingType(os_standards_shw_building_type[index])
          revit_dhw_space_type.setStandardsSpaceType(os_standards_shw_spacetype[index])
          revit_dhw_space_type.setName("Revit DHW #{os_standards_shw_template[index]}-#{os_standards_shw_building_type[index]}-#{os_standards_shw_spacetype[index]}")
          
          space.setSpaceType(revit_dhw_space_type)
          runner.registerInfo("Adding SHW Generation SpaceType named '#{revit_dhw_space_type.name}' to the OS Space named '#{space.name}'.")
        end
      end
      runner.registerError("No OpenStudio Space with a name '#{gbxml_space_id}' was found. Please check the 1st row of the csv file named '#{space_shw_load_mapping_csv_file_name}' to confirm the Space id's are correct.") if (space_id_found == false)
    end
    
    # Set whether the SHW system is recirculating or not. Valid choices are "circulating", "noncirculating" or nil, where nil models the 
    # default circulation behavior. These Building Types have default circulating SHW systems: 'Office', 'PrimarySchool', 'Outpatient', 'Hospital',
    # 'SmallHotel', 'LargeHotel', 'FullServiceRestaurant', 'HighriseApartment',
    # NOTE CAB review of OS Standards Gem v0.4.0 reveal that the 'shw_loop_type' variable currently IS NOT USED.
    # instead, (for each spacetype) a circulation pump is added to the SHW water loop IF the spacetype.standardsBuildingType attribute is one of the following: 
    # DOE Building Types: 'Office', 'PrimarySchool', 'Outpatient', 'Hospital', 'SmallHotel', 'LargeHotel', 'FullServiceRestaurant', 'HighriseApartment',
    # DEER Building Types 'Asm', 'ECC', 'EPr', 'ERC', 'ESe', 'EUn', 'Gro', 'Hsp', 'Htl', 'MBT', 'MFm', 'Mtl', 'Nrs', 'OfL', 'RSD'
    shw_loop_type = "nil"

    # Remove all existing water use equipment and water use connections from the model
    model.getWaterUseEquipments.each(&:remove)
    model.getWaterUseConnectionss.each(&:remove)
    
    standard = Standard.build(template)
    # Adds typical service water demand objects, SHW loop(s), and supply equipment loop(s) to the model
    # This method returns an array of shw loops that include demand abnd supply objects and controls 
    typical_swh_systems = standard.model_add_typical_swh(model, water_heater_fuel: os_standards_shw_equip_fuel_source, pipe_insul_in: nil, circulating: nil)
    
    # Add newly created SHW loop demands to OS WaterUseConnection objects 
    midrise_swh_loops = []
    stripmall_swh_loops = []
    typical_swh_systems.each do |loop|
      if loop.name.get.include?('MidriseApartment')
        midrise_swh_loops << loop
      elsif loop.name.get.include?('RetailStripmall')
        stripmall_swh_loops << loop
      else
        water_use_connections = []
        loop.demandComponents.each do |component|
          next if !component.to_WaterUseConnections.is_initialized
          water_use_connections << component
        end
        runner.registerInfo("Adding Service Hot Water Plant Loop named '#{loop.name}' to the model. It has #{water_use_connections.size} water use connections.")
      end
    end
    if !midrise_swh_loops.empty?
      runner.registerInfo("Adding #{midrise_swh_loops.size} MidriseApartment service water heating loops.")
    end
    if !stripmall_swh_loops.empty?
      runner.registerInfo("Adding #{stripmall_swh_loops.size} RetailStripmall service water heating loops.")
    end
    
    # Now that water use equipment has been added, remove the spacetypes that were needed, from the model
    model.getSpaceTypes.each do |spacetype|
      runner.registerInfo("Removing SHW generation spacetype named '#{spacetype.name}' associated with OS Space named '#{spacetype.spaces[0].name}'.") 
      spacetype.remove
    end

    # reset original values of StandardsTemplate and StandardsBuildingType for later re-assignment
    if not (exg_standards_template == nil)
      model.getBuilding.setStandardsTemplate(exg_standards_template)
    end
    if not (exg_standards_buildingtype == nil)
      model.getBuilding.setStandardsBuildingType(exg_standards_buildingtype)
    end

    # report initial condition of model
    num_water_heater_mixed = model.getWaterHeaterMixeds.size
    num_water_heater_heatpump = model.getWaterHeaterHeatPumps.size
    runner.registerFinalCondition("The measure ended with #{model.getWaterUseEquipmentDefinitions.size} Service Water Use Objects and #{num_water_heater_mixed + num_water_heater_heatpump} Service Water Heating objects.")
    return true
    
  end # end run method 

end

# register the measure to be used by the application
RevitCreateTypicalSHWSystemsUsingOSStandardsGem.new.registerWithApplication
