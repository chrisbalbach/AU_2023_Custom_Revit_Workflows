# insert your copyright here
# READ ONLY OS Standards google spreadsheets located here: https://drive.google.com/drive/folders/1x7yEU4jnKw-gskLBih8IopStwl0KAMEi

# Start the measure
class RevitCreateBaselineBuilding < OpenStudio::Measure::ModelMeasure
  require 'openstudio-standards'

  # Define the name of the Measure.
  def name
    return "Revit Create Baseline Building"
  end
  # Human readable description
  def description
    return "Creates the Performance Rating Method baseline building. For 90.1, this is the Appendix G aka LEED Baseline.  For India ECBC, this is the Appendix D Baseline.  Note: for 90.1, this model CANNOT be used for code compliance; it is not the same as the Energy Cost Budget baseline."
  end
  # Human readable description of modeling approach
  def modeler_description
    return ""
  end
  # Define the arguments that the user will input.
  def arguments(model)
    args = OpenStudio::Measure::OSArgumentVector.new
  
    # arg = OpenStudio::Measure::OSArgument.makeStringArgument('Space Baseline Mapping .csv file name', true)
    # arg.setDisplayName('Space Baseline Mapping .csv file name')
    # arg.setDescription('path of the Space Baseline Mapping .csv file name.')
    # args << arg
  
    # # Make an argument for the standard
    # standard_chs = OpenStudio::StringVector.new
    # standard_chs << '90.1-2004'
    # standard_chs << '90.1-2007'
    # standard_chs << '90.1-2010'
    # standard_chs << '90.1-2013'
    # standard_chs << '90.1-2016'
    # standard_chs << '90.1-2019'
    # standard_chs << '90.1-2013'
    # standard = OpenStudio::Measure::OSArgument.makeChoiceArgument('standard', standard_chs, true)
    # standard.setDisplayName('ASHRAE Standard (Appendix G) that the Baseline should meet.')
    # standard.setDefaultValue('90.1-2013')
    # args << standard`

    # # Make an argument for the building type
    # building_type_chs = OpenStudio::StringVector.new
    # building_type_chs << 'MidriseApartment'
    # building_type_chs << 'SecondarySchool'
    # building_type_chs << 'PrimarySchool'
    # building_type_chs << 'SmallOffice'
    # building_type_chs << 'MediumOffice'
    # building_type_chs << 'LargeOffice'
    # building_type_chs << 'SmallHotel'
    # building_type_chs << 'LargeHotel'
    # building_type_chs << 'Warehouse'
    # building_type_chs << 'RetailStandalone'
    # building_type_chs << 'RetailStripmall'
    # building_type_chs << 'QuickServiceRestaurant'
    # building_type_chs << 'FullServiceRestaurant'
    # building_type_chs << 'Hospital'
    # building_type_chs << 'Outpatient'
    # building_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('building_type', building_type_chs, true)
    # building_type.setDisplayName('Building Type.')
    # building_type.setDefaultValue('SmallOffice')
    # args << building_type

    # # Make an argument for the hvac building type - used by 90.1-2016 or later
    # os_standards_baseline_hvac_building_type_chs = OpenStudio::StringVector.new
    # os_standards_baseline_hvac_building_type_chs << 'heated only storage'
    # os_standards_baseline_hvac_building_type_chs << 'hospital'
    # os_standards_baseline_hvac_building_type_chs << 'public assembly'
    # os_standards_baseline_hvac_building_type_chs << 'retail'
    # os_standards_baseline_hvac_building_type_chs << 'other nonresidential'
    # os_standards_baseline_hvac_building_type_chs << 'residential'
    # os_standards_baseline_hvac_building_type_chs << 'unconditioned'
    # os_standards_baseline_hvac_building_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('os_standards_baseline_hvac_building_type', os_standards_baseline_hvac_building_type_chs, true)
    # os_standards_baseline_hvac_building_type.setDisplayName('HVAC Building Type.')
    # os_standards_baseline_hvac_building_type.setDefaultValue('other nonresidential')
    # args << os_standards_baseline_hvac_building_type

    # # Make an argument for the wwr building type - used by 90.1-2016 or later
    # os_standards_baseline_wwr_building_type_chs = OpenStudio::StringVector.new
    # os_standards_baseline_wwr_building_type_chs << 'Warehouse (nonrefrigerated)'
    # os_standards_baseline_wwr_building_type_chs << 'School (secondary and university)'
    # os_standards_baseline_wwr_building_type_chs << 'School (primary)'
    # os_standards_baseline_wwr_building_type_chs << 'Retail (strip mall)'
    # os_standards_baseline_wwr_building_type_chs << 'Retail (stand alone)'
    # os_standards_baseline_wwr_building_type_chs << 'Restaurant (quick service)'
    # os_standards_baseline_wwr_building_type_chs << 'Restaurant (full serivce)'
    # os_standards_baseline_wwr_building_type_chs << 'Office > 50,000 sq ft'
    # os_standards_baseline_wwr_building_type_chs << 'Office <= 5,000 sq ft'
    # os_standards_baseline_wwr_building_type_chs << 'Office 5,000 to 50,000 sq ft'
    # os_standards_baseline_wwr_building_type_chs << 'Hotel/motel > 75 rooms'
    # os_standards_baseline_wwr_building_type_chs << 'Hotel/motel <= 75 rooms'
    # os_standards_baseline_wwr_building_type_chs << 'Hospital'
    # os_standards_baseline_wwr_building_type_chs << 'Healthcare (outpatient)'
    # os_standards_baseline_wwr_building_type_chs << 'Grocery store'
    # os_standards_baseline_wwr_building_type_chs << 'All other'
    # os_standards_baseline_wwr_building_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('os_standards_baseline_hvac_building_type', os_standards_baseline_wwr_building_type_chs, true)
    # os_standards_baseline_hvac_building_type.setDisplayName('Window Wall Ratio Building Type.')
    # os_standards_baseline_hvac_building_type.setDefaultValue('SmallOffice')
    # args << os_standards_baseline_hvac_building_type

    # # Make an argument for the shw building type - used by 90.1-2016 or later
    # os_standards_baseline_shw_building_type_chs = OpenStudio::StringVector.new
    # os_standards_baseline_shw_building_type_chs << 'Workshop'
    # os_standards_baseline_shw_building_type_chs << 'Warehouse'
    # os_standards_baseline_shw_building_type_chs << 'Transportation'
    # os_standards_baseline_shw_building_type_chs << 'Town hall'
    # os_standards_baseline_shw_building_type_chs << 'Sport arena'
    # os_standards_baseline_shw_building_type_chs << 'School/university'
    # os_standards_baseline_shw_building_type_chs << 'Retail'
    # os_standards_baseline_shw_building_type_chs << 'Religious facility'
    # os_standards_baseline_shw_building_type_chs << 'Post office'
    # os_standards_baseline_shw_building_type_chs << 'Police station'
    # os_standards_baseline_shw_building_type_chs << 'Performing arts theater'
    # os_standards_baseline_shw_building_type_chs << 'Penitentiary'
    # os_standards_baseline_shw_building_type_chs << 'Parking garage'
    # os_standards_baseline_shw_building_type_chs << 'Office'
    # os_standards_baseline_shw_building_type_chs << 'Museum'
    # os_standards_baseline_shw_building_type_chs << 'Multifamily'
    # os_standards_baseline_shw_building_type_chs << 'Motion picture theater'
    # os_standards_baseline_shw_building_type_chs << 'Motel'
    # os_standards_baseline_shw_building_type_chs << 'Manufacturing facility'
    # os_standards_baseline_shw_building_type_chs << 'Library'
    # os_standards_baseline_shw_building_type_chs << 'Hotel'
    # os_standards_baseline_shw_building_type_chs << 'Hospital and outpatient surgery center'
    # os_standards_baseline_shw_building_type_chs << 'Health-care clinic'
    # os_standards_baseline_shw_building_type_chs << 'Gymnasium'
    # os_standards_baseline_shw_building_type_chs << 'Grocery store'
    # os_standards_baseline_shw_building_type_chs << 'Fire station'
    # os_standards_baseline_shw_building_type_chs << 'Exercise center'
    # os_standards_baseline_shw_building_type_chs << 'Domitory'
    # os_standards_baseline_shw_building_type_chs << 'Dining:Family'
    # os_standards_baseline_shw_building_type_chs << 'Dining: Cafeteria/fast food'
    # os_standards_baseline_shw_building_type_chs << 'Dining: Bar lounge/leisure'
    # os_standards_baseline_shw_building_type_chs << 'Courthouse'
    # os_standards_baseline_shw_building_type_chs << 'Convention center'
    # os_standards_baseline_shw_building_type_chs << 'Convenience store'
    # os_standards_baseline_shw_building_type_chs << 'Automotive facility'
    # os_standards_baseline_shw_building_type_chs << 'All others'
    # os_standards_baseline_shw_building_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('os_standards_baseline_shw_building_type', os_standards_baseline_shw_building_type_chs, true)
    # os_standards_baseline_shw_building_type.setDisplayName('Service Hot Water Building Type.')
    # os_standards_baseline_shw_building_type.setDefaultValue('SmallOffice')
    # args << os_standards_baseline_shw_building_type

    # # Make an argument for the climate zone
    # climate_zone_chs = OpenStudio::StringVector.new
    # climate_zone_chs << 'ASHRAE 169-2013-1A'
    # climate_zone_chs << 'ASHRAE 169-2013-2A'
    # climate_zone_chs << 'ASHRAE 169-2013-2B'
    # climate_zone_chs << 'ASHRAE 169-2013-3A'
    # climate_zone_chs << 'ASHRAE 169-2013-3B'
    # climate_zone_chs << 'ASHRAE 169-2013-3C'
    # climate_zone_chs << 'ASHRAE 169-2013-4A'
    # climate_zone_chs << 'ASHRAE 169-2013-4B'
    # climate_zone_chs << 'ASHRAE 169-2013-4C'
    # climate_zone_chs << 'ASHRAE 169-2013-5A'
    # climate_zone_chs << 'ASHRAE 169-2013-5B'
    # climate_zone_chs << 'ASHRAE 169-2013-6A'
    # climate_zone_chs << 'ASHRAE 169-2013-6B'
    # climate_zone_chs << 'ASHRAE 169-2013-7A'
    # climate_zone_chs << 'ASHRAE 169-2013-8A'
    # climate_zone = OpenStudio::Measure::OSArgument.makeChoiceArgument('climate_zone', climate_zone_chs, true)
    # climate_zone.setDisplayName('Climate Zone.')
    # climate_zone.setDefaultValue('ASHRAE 169-2013-2A')
    # args << climate_zone

    # # Make an argument for the debug
    # debug_chs = OpenStudio::StringVector.new
    # debug_chs << 'true'
    # debug_chs << 'false'
    # debug = OpenStudio::Measure::OSArgument.makeChoiceArgument('debug', debug_chs, true)
    # debug.setDisplayName('Debug Flag')
    # debug.setDefaultValue('true')
    # args << debug

    # # Make an argument for running all orientations
    # run_all_orientations_chs = OpenStudio::StringVector.new
    # run_all_orientations_chs << 'true'
    # run_all_orientations_chs << 'false'
    # run_all_orientations = OpenStudio::Measure::OSArgument.makeChoiceArgument('run_all_orientations', run_all_orientations_chs, true)
    # run_all_orientations.setDisplayName('Run All Orientations Flag')
    # run_all_orientations.setDefaultValue('true')
    # args << run_all_orientations

    return args
  end

  # Define what happens when the measure is run.
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # Use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end
    
    # declare variables for proper scope
    gbxml_space_ids = []
    space_baseline_mapping_csv_file_name = nil
    os_standards_baseline_template = nil
    os_standards_baseline_building_type = nil
    climate_zone = nil
    debug = false
    os_standards_baseline_hvac_building_type = nil # only needed if ASHRAE baseline = 90.1-206 or later
    os_standards_baseline_wwr_building_type = nil # only needed if ASHRAE baseline = 90.1-206 or later
    os_standards_baseline_shw_building_type = nil # only needed if ASHRAE baseline = 90.1-206 or later

    # Load 'building' level parameters needed to generate an ASHRAE baseline
    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "Building_Baseline_Mappings.csv"))), headers: true) do |row|
    
      space_baseline_mapping_csv_file_name = row[1].to_s if (row[0] == "space_baseline_mapping_csv_file_name")
      os_standards_baseline_template = row[1].to_s if (row[0] == "os_standards_baseline_template")
      os_standards_baseline_building_type = row[1].to_s if (row[0] == "os_standards_baseline_building_type")
      climate_zone = row[1].to_s if (row[0] == "climate_zone")
      debug = row[1].to_s.downcase if (row[0] == "debug")
      os_standards_baseline_hvac_building_type = row[1].to_s if (row[0] == "os_standards_baseline_hvac_building_type")
      os_standards_baseline_wwr_building_type = row[1].to_s if (row[0] == "os_standards_baseline_wwr_building_type")
      os_standards_baseline_shw_building_type = row[1].to_s if (row[0] == "os_standards_baseline_shw_building_type")
    end

    # map debug string variable (required by .csv) to boolean variable
    run_debug = nil
    if debug == "true"
      run_debug = true
    elsif debug == "false"
      run_debug = false
    else
      fail ("Lowercase value of csv argument named 'Debug' of #{debug.downcase} is not equal to 'true' or 'false'.")       
    end
 
    # ensure space_baseline_mapping_csv_filename exists as a csv file
    if space_baseline_mapping_csv_file_name == nil
      runner.registerError("No value found for Argument Name: 'Space Baseline Mapping .csv file name' in Building_Baseline_Mappings.csv file")
    end
    file_path = File.expand_path(File.join(File.dirname(__FILE__), 'resources', "#{space_baseline_mapping_csv_file_name}"))
    unless File.exist?(file_path) && file_path.downcase.end_with?('.csv')
      runner.registerError("'#{space_baseline_mapping_csv_file_name}' does not exist in the resources directory of this measure, or the file does not end with a .csv extension.")
    end
 
    # Load gbxml 'space' level parameters needed to generate an ASHRAE baseline
    os_standards_baseline_template_array = []
    os_standards_baseline_building_type_array = []
    os_standards_baseline_spacetype_array = []
    
    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "#{space_baseline_mapping_csv_file_name}"))), headers: true) do |row|
      gbxml_space_ids << row[0] # NOTE: Revit System Analysis Workflow generated OpenStudio Model Space Object Names are EQUAL to gbXML file "Space id' attribute values
      
      # Split the string into an array of (3) strings: (template, buildingtype, spacetype), based on the '*' character
      template_buildingtype_spacetype_string = row[2].to_s.split("*", 3)
      
      # Retrieve template, building and spacetype values from the array and append them to arrays
      os_standards_baseline_template_array << template_buildingtype_spacetype_string[0]
      os_standards_baseline_building_type_array << template_buildingtype_spacetype_string[1]
      os_standards_baseline_spacetype_array << template_buildingtype_spacetype_string[2]
      runner.registerInfo("Revit Analytical Space named #{row[1]}  will have BASELINE lighting loads added using the OS Standards Gem, using Template:#{template_buildingtype_spacetype_string[0]}, BuildingType:#{template_buildingtype_spacetype_string[1]}, Spacetype:#{template_buildingtype_spacetype_string[2]}")
    end
    
    # Remove ALL Hard Assigned Lighting Loads (directly assigned to spaces) in the Revit model. 
    # Downstream, the PRM method will add the baseline lights to the model, using appropriate user-assigned spacetypes, for each space
    model.getSpaces.each do |space|
      lights = space.lights
      lights.each do |light|
        runner.registerInfo("Removing Hard Assigned Lightiing Instance named #{light.name.get} from the space named #{space.name.get}")
        light.remove  
      end   
    end  
    
    # Loop through gbxml space ID's to find a matching OS Space, using the OS Space Name. When found, create a new OS SpaceType object and assign it to the OS Space object 
    # Create new OS SpaceType objects such that baseline lighting can be assigned to the model, by mapping a OS Space Type to each Revit/gbxml Space object.
    # Each OS SpaceType should include a valid name (recognizable by openstudio standards) for the template, building type and spacetype.
    gbxml_space_ids.each_with_index do |gbxml_space_id, index|
      space_id_found = false
      model.getSpaces.each do |space|
        if (space.name.get == gbxml_space_id) # NOTE: Revit System Analysis Workflow generated OpenStudio Model Space Object Names are EQUAL to gbXML file "Space id' attribute values
          space_id_found = true
          revit_baseline_space_type = OpenStudio::Model::SpaceType.new(model)
          revit_baseline_space_type.setStandardsTemplate(os_standards_baseline_template_array[index])
          revit_baseline_space_type.setStandardsBuildingType(os_standards_baseline_building_type_array[index])
          revit_baseline_space_type.setStandardsSpaceType(os_standards_baseline_spacetype_array[index])
          revit_baseline_space_type.setName("Revit Baseline #{os_standards_baseline_template_array[index]}-#{os_standards_baseline_building_type_array[index]}-#{os_standards_baseline_spacetype_array[index]}")
          
          space.setSpaceType(revit_baseline_space_type)
          runner.registerInfo("For assigning Baseline Lighting loads, an OS SpaceType object named #{revit_baseline_space_type.name.get} has been created and added to the OS Space Object named #{space.name.get}")
        end
      end
      runner.registerError("No OpenStudio Space object having the name of '#{gbxml_space_id}' was found in the file named '#{space_baseline_mapping_csv_filename}'. Please check the 1st row this file to confirm the Space id values are correct.") if (space_id_found == false)
    end

    # Open a channel to log info/warning/error messages
    @msg_log = OpenStudio::StringStreamLogSink.new
    if debug
      @msg_log.setLogLevel(OpenStudio::Debug)
    else
      @msg_log.setLogLevel(OpenStudio::Info)
    end
    @start_time = Time.new
    @runner = runner

    # Contact info for where to report issues
    contact = "While this Measure aims to be comprehensive and was tested against a suite of models of actual building designs, there are bound to be situations that it will not handle correctly.  It is your responsibility as a modeler to review the results of this Measure and adjust accordingly.  If you find issues (beyond those listed below), please <a href='https://github.com/NREL/openstudio-standards/issues'>report them here</a>.  Please include a detailed description, the proposed model, and references to the pertinent sections of 90.1, ASHRAE interpretations, or LEED interpretations."
    OpenStudio.logFree(OpenStudio::Info, 'openstudio.standards.Model', contact)

    # List of unsupported things
    us = []
    us << 'Lighting controls (occ/vac sensors) are assumed to already be present in proposed lighting schedules, and will not be added or removed'
    us << 'Exterior lighting in the baseline model is left as found in proposed'
    us << 'Optimal start of HVAC systems is not supported'
    us << 'Skylights are not added to model, but existing skylights are scaled per Appendix G skylight-to-roof areas'
    us << 'Changing baseline glazing types based on WWR and orientation' if os_standards_baseline_template == '90.1-2004'
    us << 'No fan power allowances for MERV filters or ducted supply/return present in proposed model HVAC'
    us << 'Laboratory-specific ventilation is not handled'
    us << 'Kitchen ventilation is not handled; exhaust fans left as found in proposed'
    us << 'Commercial refrigeration equipment is left as found in proposed'
    us << 'Transformers are not added to the baseline model'
    us << 'System types 11 (for data centers) and 12/13 (for public assembly buildings)' if os_standards_baseline_template == '90.1-2013'
    us << 'Zone humidity control present in the proposed model HVAC systems is not added to baseline HVAC'

    # Report out to users
    OpenStudio.logFree(OpenStudio::Info, 'openstudio.standards.Model', '*** Currently unsupported ***')
    us.each do |msg|
      OpenStudio.logFree(OpenStudio::Info, 'openstudio.standards.Model', msg)
    end

    # List of known issues or limitations
    issues = []
    issues << 'Some control and efficiency determinations do not scale capacities/flow rates down to reflect zone multipliers'
    issues << 'Daylighting control illuminance setpoint does not vary based on space type'
    issues << 'Daylighting area calcs do not include windows in non-vertical walls'
    issues << 'Daylighting area calcs do not include skylights in non-horizontal roofs'

    # Report out to users
    OpenStudio.logFree(OpenStudio::Info, 'openstudio.standards.Model', '*** Known issues ***')
    issues.each do |msg|
      OpenStudio.logFree(OpenStudio::Info, 'openstudio.standards.Model', msg)
    end

    # Set necessary arguments for the ASHRAE PRM method 
    custom = nil # Valid Choices are 'Xcel Energy CO EDA' or '90.1-2007 with addenda dn'
    model_deep_copy = true
    run_all_orients = false # defaulted to reduce simulation time 
    unmet_load_hours_check = false

    # Make a directory to save the resulting models for debugging
    build_dir = "#{Dir.pwd}/output"
    if !Dir.exist?(build_dir)
      Dir.mkdir(build_dir)
    end

    std = Standard.build(os_standards_baseline_template)
    
    if (os_standards_baseline_template == "90.1-2016") || (os_standards_baseline_template == "90.1-2019")
      # Method used for 90.1-2016 and onward (uses ASHRAE PRM Approach)
      # std.model_create_prm_stable_baseline_building(model, climate_zone, os_standards_baseline_hvac_building_type, os_standards_baseline_wwr_building_type,
      #                                               os_standards_baseline_shw_building_type, build_dir, unmet_load_hours_check=false, run_debug)
      
      std.model_create_prm_any_baseline_building(model, 
                                                 os_standards_baseline_building_type,
                                                 climate_zone, 
                                                 os_standards_baseline_hvac_building_type,
                                                 os_standards_baseline_wwr_building_type,
                                                 os_standards_baseline_shw_building_type,
                                                 model_deep_copy,
                                                 custom,
                                                 build_dir,
                                                 run_all_orients,
                                                 unmet_load_hours_check,
                                                 run_debug)
 

    elsif (os_standards_baseline_template == "90.1-2013") || (os_standards_baseline_template == "90.1-2010") || (os_standards_baseline_template == "90.1-2007") || (os_standards_baseline_template == "90.1-2004")

      # Method used for 90.1-2013 and before
      std.model_create_prm_baseline_building(model, os_standards_baseline_building_type, climate_zone, custom, build_dir, run_debug)

    else
      runner.registerError("'#{os_standards_baseline_template}' is not a supported value for an OS Standards Baseline 'Template' enumeration.")
    end
    
    # Call log_messages method
    log_msgs(run_debug)
    
  end # end run method

  # Get all the log messages and put into output
  # for users to see.
  def log_msgs(debug)
    # Log the messages to file for easier review
    log_name = 'create_baseline.log'
    log_file_path = "#{Dir.pwd}/#{log_name}"
    messages = log_messages_to_file(log_file_path, debug)
    @runner.registerFinalCondition("Messages below saved to <a href='file:///#{log_file_path}'>#{log_name}</a>.")
    @msg_log.logMessages.each do |msg|
      # DLM: you can filter on log channel here for now
      if /openstudio.*/.match?(msg.logChannel) # /openstudio\.model\..*/
        # Skip certain messages that are irrelevant/misleading
        next if msg.logMessage.include?('Skipping layer') || # Annoying/bogus "Skipping layer" warnings
                msg.logChannel.include?('runmanager') || # RunManager messages
                msg.logChannel.include?('setFileExtension') || # .ddy extension unexpected
                msg.logChannel.include?('Translator') || # Forward translator and geometry translator
                msg.logMessage.include?('UseWeatherFile') || # 'UseWeatherFile' is not yet a supported option for YearDescription
                msg.logMessage.include?('has multiple parents') # Object of type 'OS:Curve:Cubic' and named 'VSD-TWR-FAN-FPLR' has multiple parents. Returning the first.

        # Report the message in the correct way
        if msg.logLevel == OpenStudio::Info
          @runner.registerInfo(msg.logMessage)
        elsif msg.logLevel == OpenStudio::Warn
          @runner.registerWarning(msg.logMessage.to_s)
        elsif msg.logLevel == OpenStudio::Error
          @runner.registerError(msg.logMessage.to_s)
        elsif msg.logLevel == OpenStudio::Debug && debug
          @runner.registerInfo("DEBUG - #{msg.logMessage}")
        end
      end
    end
    @runner.registerInfo("Total Time = #{(Time.new - @start_time).round}sec.")
  end # end log_msg method
end # end class

# this allows the measure to be use by the application
RevitCreateBaselineBuilding.new.registerWithApplication