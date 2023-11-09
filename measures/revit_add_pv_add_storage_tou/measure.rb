# insert your copyright here

# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

# load OpenStudio measure libraries
require 'csv'

# start the measure
class RevitAddPVAddStorageTOU < OpenStudio::Measure::ModelMeasure
  # human readable name
  def name
    return "Revit_Add_PV_Add_Storage_TOU"
  end
  # human readable description
  def description
    return "lorum"
  end
  # human readable description of modeling approach
  def modeler_description
    return "ipsum"
  end
  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Measure::OSArgumentVector.new

    # # max_power_output
    # max_power_output = OpenStudio::Measure::OSArgument.makeDoubleArgument('max_power_output', true)
    # max_power_output.setDisplayName('Peak Size of PV System')
    # max_power_output.setUnits('kW')
    # max_power_output.setDefaultValue(30.0)
    # args << max_power_output

    # # make a choice argument for array type
    # array_type_choices = OpenStudio::StringVector.new
    # array_type_choices << "FixedRoofMounted"
    # array_type_choices << "FixedOpenRack"
	  # array_type_choices << "OneAxis"
	  # array_type_choices << "OneAxisBacktracking"
    # array_type_choices << "TwoAxis"

    # # make a choice argument for array type
    # array_type = OpenStudio::Measure::OSArgument::makeChoiceArgument("array_type", array_type_choices, true)
    # array_type.setDisplayName("Array Type")
    # array_type.setDefaultValue("FixedRoofMounted")
    # args << array_type
    
    # # make a choice argument for module type
    # module_type_choices = OpenStudio::StringVector.new
    # module_type_choices << "Standard"
    # module_type_choices << "Premium"
	  # module_type_choices << "ThinFilm"

    # # make a choice argument for module type
    # module_type = OpenStudio::Measure::OSArgument::makeChoiceArgument("module_type", module_type_choices, true)
    # module_type.setDisplayName("Module Type")
    # module_type.setDefaultValue("Premium")
    # args << module_type

    # # set system losses fraction
    # system_losses_fraction = OpenStudio::Measure::OSArgument.makeDoubleArgument('system_losses_fraction', true)
    # system_losses_fraction.setDisplayName('System Losses Fraction')
    # system_losses_fraction.setUnits('%')
    # system_losses_fraction.setDefaultValue(0.14)
    # args << system_losses_fraction

	  # # set array tilt
    # array_tilt = OpenStudio::Measure::OSArgument.makeDoubleArgument('array_tilt', true)
    # array_tilt.setDisplayName('Array Tilt')
    # array_tilt.setUnits('Degrees')
    # array_tilt.setDefaultValue(20)
    # args << array_tilt

    # # set array azimuth
    # array_azimuth = OpenStudio::Measure::OSArgument.makeDoubleArgument('array_azimuth', true)
    # array_azimuth.setDisplayName('Array Azimuth')
    # array_azimuth.setUnits('Degrees')
    # array_azimuth.setDefaultValue(180)
    # args << array_azimuth

    # # set ground_coverage_ratio
    # ground_coverage_ratio = OpenStudio::Measure::OSArgument.makeDoubleArgument('ground_coverage_ratio', true)
    # ground_coverage_ratio.setDisplayName('Ground Coverage Ratio')
    # ground_coverage_ratio.setUnits('%')
    # ground_coverage_ratio.setDefaultValue(0.30)
    # args << ground_coverage_ratio
	
	  # # set inverter_efficiency
    # inverter_efficiency = OpenStudio::Measure::OSArgument.makeDoubleArgument('inverter_efficiency', true)
    # inverter_efficiency.setDisplayName('Inverter Efficiency')
    # inverter_efficiency.setUnits('fraction')
    # inverter_efficiency.setDefaultValue(0.96)
    # args << inverter_efficiency
	
    # # inverter set dc_to_ac_size_ratio
	  # dc_to_ac_size_ratio = OpenStudio::Measure::OSArgument.makeDoubleArgument('dc_to_ac_size_ratio', true)
    # dc_to_ac_size_ratio.setDisplayName('DC to AC Size Ratio')
    # dc_to_ac_size_ratio.setUnits('Ratio')
    # dc_to_ac_size_ratio.setDefaultValue(1.10)
    # args << dc_to_ac_size_ratio

    # # make a choice argument for generator_operation_scheme_type
    # # Baseload is the most appropriate for PV: always use if available
    # generator_operation_scheme_type_choices = OpenStudio::StringVector.new
    # generator_operation_scheme_type_choices << "Baseload"
    # generator_operation_scheme_type_choices << "DemandLimit"
    # generator_operation_scheme_type_choices << "TrackElectrical"
    # generator_operation_scheme_type_choices << "TrackSchedule"
    # generator_operation_scheme_type_choices << "TrackMeter"
    # generator_operation_scheme_type_choices << "FollowThermal"
    # generator_operation_scheme_type_choices << "FollowThermalLimitElectrical"

    # make a choice argument for generator_operation_scheme_type
    # generator_operation_scheme_type = OpenStudio::Measure::OSArgument::makeChoiceArgument("generator_operation_scheme_type", generator_operation_scheme_type_choices, true)
    # generator_operation_scheme_type.setDisplayName("Generator Operation Scheme Type")
    # generator_operation_scheme_type.setDefaultValue("Baseload")
    # args << generator_operation_scheme_type

    # # Converter Simple Fixed Efficiency
    # converter_simple_fixed_efficiency = OpenStudio::Measure::OSArgument.makeDoubleArgument('converter_simple_fixed_efficiency', true)
    # converter_simple_fixed_efficiency.setDisplayName('The simple fixed efficiency of the AC to DC converter.')
    # converter_simple_fixed_efficiency.setUnits('Fraction')
    # converter_simple_fixed_efficiency.setDefaultValue(0.94)
    # args << converter_simple_fixed_efficiency

    # # Converter Ancillary Power Consumed in Standby
    # converter_ancillary_power_consumed_in_standby = OpenStudio::Measure::OSArgument.makeDoubleArgument('converter_ancillary_power_consumed_in_standby', true)
    # converter_ancillary_power_consumed_in_standby.setDisplayName('The simple fixed efficiency of the AC to DC converter.')
    # converter_ancillary_power_consumed_in_standby.setUnits('Watts')
    # converter_ancillary_power_consumed_in_standby.setDefaultValue(100)
    # args << converter_ancillary_power_consumed_in_standby

    # # Converter Radiative Fraction
    # converter_radiative_fraction = OpenStudio::Measure::OSArgument.makeDoubleArgument('converter_radiative_fraction', true)
    # converter_radiative_fraction.setDisplayName('The simple fixed efficiency of the AC to DC converter.')
    # converter_radiative_fraction.setUnits('Fraction')
    # converter_radiative_fraction.setDefaultValue(0.25)
    # args << converter_radiative_fraction
    
    # # battery_make_model
    # battery_make_model = OpenStudio::Measure::OSArgument.makeStringArgument('battery_make_model', true)
    # battery_make_model.setDisplayName('Describe the make and model of the battery bank that this measure represents')
    # battery_make_model.setUnits('kW')
    # battery_make_model.setDefaultValue('Qty 1 2022 Tesla Megapack - 4 Hour Duration')
    # args << battery_make_model

    # # Design Storage Control Charge Power
    # design_storage_control_charge_power = OpenStudio::Measure::OSArgument.makeDoubleArgument('design_storage_control_charge_power', true)
    # design_storage_control_charge_power.setDisplayName('The maximum rate that electric power can be charged into storage')
    # design_storage_control_charge_power.setUnits('kW')
    # design_storage_control_charge_power.setDefaultValue(1927)
    # args << design_storage_control_charge_power

    # # Design Storage Control Discharge Power
    # design_storage_control_discharge_power = OpenStudio::Measure::OSArgument.makeDoubleArgument('design_storage_control_discharge_power', true)
    # design_storage_control_discharge_power.setDisplayName('The maximum rate that electric power can be discharged from storage')
    # design_storage_control_discharge_power.setUnits('kW')
    # design_storage_control_discharge_power.setDefaultValue(1927)
    # args << design_storage_control_discharge_power
    
    # # Minimum Storage State Of Charge Fracrion
    # minimum_storage_state_of_charge_fraction = OpenStudio::Measure::OSArgument.makeDoubleArgument('minimum_storage_state_of_charge_fraction', true)
    # minimum_storage_state_of_charge_fraction.setDisplayName('Minimum Storage State of Charge Fraction')
    # minimum_storage_state_of_charge_fraction.setUnits('Fraction')
    # minimum_storage_state_of_charge_fraction.setDefaultValue(0.05)
    # args << minimum_storage_state_of_charge_fraction

    # # Maximum Storage State Of Charge Fracrion
    # maximum_storage_state_of_charge_fraction = OpenStudio::Measure::OSArgument.makeDoubleArgument('maximum_storage_state_of_charge_fraction', true)
    # maximum_storage_state_of_charge_fraction.setDisplayName('Maximum Storage State of Charge Fraction')
    # maximum_storage_state_of_charge_fraction.setUnits('Fraction')
    # maximum_storage_state_of_charge_fraction.setDefaultValue(0.95)
    # args << maximum_storage_state_of_charge_fraction

    # # make a choice argument for electrical_buss_type AlternatingCurrent
    # electrical_buss_type_chs = OpenStudio::StringVector.new
    # electrical_buss_type_chs << "AlternatingCurrent"
    # electrical_buss_type_chs << "AlternatingCurrentWithStorage"
    # electrical_buss_type_chs << "DirectCurrentWithInverter"
    # electrical_buss_type_chs << "DirectCurrentWithInverterDCStorage"
    # electrical_buss_type_chs << "DirectCurrentWithInverterACStorage"
    # make a choice argument for electrical_buss_type
    # electrical_buss_type = OpenStudio::Measure::OSArgument::makeChoiceArgument("electrical_buss_type", electrical_buss_type_chs, true)
    # electrical_buss_type.setDisplayName("Electrical Buss Type")
    # electrical_buss_type.setDefaultValue("DirectCurrentWithInverterACStorage")
    # args << electrical_buss_type

    # # make a choice argument for storage_operation_scheme_type
    # storage_operation_scheme_type_choices = OpenStudio::StringVector.new
    # storage_operation_scheme_type_choices << "TrackFacilityElectricDemandStoreExcessOnSite"
    # storage_operation_scheme_type_choices << "TrackMeterDemandStoreExcessOnSite"
    # storage_operation_scheme_type_choices << "TrackChargeDischargeSchedules"
    # storage_operation_scheme_type_choices << "FacilityDemandLeveling"
    # make a choice argument for storage_operation_scheme_type
    # storage_operation_scheme_type = OpenStudio::Measure::OSArgument::makeChoiceArgument("storage_operation_scheme_type", storage_operation_scheme_type_choices, true)
    # storage_operation_scheme_type.setDisplayName("Storage Operation Scheme Type")
    # storage_operation_scheme_type.setDefaultValue("FacilityDemandLeveling")
    # args << storage_operation_scheme_type

    # # make an argument for percentage of maximum charge power to use for charging
    # percentage_of_maximum_charge_power_to_use_for_charging = OpenStudio::Measure::OSArgument.makeDouble('percentage_of_maximum_charge_power_to_use_for_charging', true)
    # percentage_of_maximum_charge_power_to_use_for_charging.setDisplayName('% of maximum charge power to use for charging')
    # percentage_of_maximum_charge_power_to_use_for_charging.setDefaultValue(10)
    # args << percentage_of_maximum_charge_power_to_use_for_charging

    # # make an argument for percentage of maximum charge power to use for discharging
    # percentage_of_maximum_charge_power_to_use_for_discharging = OpenStudio::Measure::OSArgument.makeDouble('percentage_of_maximum_charge_power_to_use_for_discharging', true)
    # percentage_of_maximum_charge_power_to_use_for_discharging.setDisplayName('% of maximum charge power to use for discharging')
    # percentage_of_maximum_charge_power_to_use_for_discharging.setDefaultValue(10)
    # args << percentage_of_maximum_charge_power_to_use_for_discharging
    
    # # make an argument for winter month to begin storage season
    # winter_month_to_begin_storage_season = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_month_to_begin_storage_season', true)
    # winter_month_to_begin_storage_season.setDisplayName('Winter Month To Begin Storage Season (10 = October)')
    # winter_month_to_begin_storage_season.setDefaultValue(10)
    # args << winter_month_to_begin_storage_season

    # # make an argument for winter day to begin storage season
    # winter_day_to_begin_storage_season = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_day_to_begin_storage_season', true)
    # winter_day_to_begin_storage_season.setDisplayName('Winter Day To Begin Storage Season (10 = 10th day of month)')
    # winter_day_to_begin_storage_season.setDefaultValue(10)
    # args << winter_day_to_begin_storage_season

    # # make an argument for winter month to end storage season
    # winter_month_to_end_storage_season = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_month_to_end_storage_season', true)
    # winter_month_to_end_storage_season.setDisplayName('Winter Month To End Storage Season (2 = February)')
    # winter_month_to_end_storage_season.setDefaultValue(10)
    # args << winter_month_to_end_storage_season

    # # make an argument for winter day to end storage season
    # winter_day_to_end_storage_season = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_day_to_end_storage_season', true)
    # winter_day_to_end_storage_season.setDisplayName('Winter Day To Begin Storage Season (10 = 10th day of month)')
    # winter_day_to_end_storage_season.setDefaultValue(10)
    # args << winter_day_to_end_storage_season

    # # make an argument for winter weekday hour to begin storage discharge
    # winter_weekday_hour_to_begin_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_weekday_hour_to_begin_storage_discharge', true)
    # winter_weekday_hour_to_begin_storage_discharge.setDisplayName('Winter Weekday Hour to Begin Storage Discharge (9 = 9:00 AM)')
    # winter_weekday_hour_to_begin_storage_discharge.setDefaultValue(9)
    # args << winter_weekday_hour_to_begin_storage_discharge

    # # make an argument for winter weekday hour to end storage discharge
    # winter_weekday_hour_to_end_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_weekday_hour_to_end_storage_discharge', true)
    # winter_weekday_hour_to_end_storage_discharge.setDisplayName('Winter Weekday Hour to End Storage Discharge (22 = 10:00 PM)')
    # winter_weekday_hour_to_end_storage_discharge.setDefaultValue(22)
    # args << winter_weekday_hour_to_end_storage_discharge

    # # make an argument for winter weekend hour to begin storage discharge
    # winter_weekend_hour_to_begin_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_weekend_hour_to_begin_storage_discharge', true)
    # winter_weekend_hour_to_begin_storage_discharge.setDisplayName('Winter Weekend Hour to Begin Storage Discharge (9 = 9:00 AM)')
    # winter_weekend_hour_to_begin_storage_discharge.setDefaultValue(9)
    # args << winter_weekend_hour_to_begin_storage_discharge

    # # make an argument for winter weekend hour to end storage discharge
    # winter_weekend_hour_to_end_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('winter_weekend_hour_to_end_storage_discharge', true)
    # winter_weekend_hour_to_end_storage_discharge.setDisplayName('Winter Weekend Hour to End Storage Discharge (22 = 10:00 PM)')
    # winter_weekend_hour_to_end_storage_discharge.setDefaultValue(22)
    # args << winter_weekend_hour_to_end_storage_discharge

    # # make an argument for summer weekday hour to begin storage discharge
    # summer_weekday_hour_to_begin_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_weekday_hour_to_begin_storage_discharge', true)
    # summer_weekday_hour_to_begin_storage_discharge.setDisplayName('Summer Weekday Hour to Begin Storage Discharge (9 = 9:00 AM)')
    # summer_weekday_hour_to_begin_storage_discharge.setDefaultValue(9)
    # args << summer_weekday_hour_to_begin_storage_discharge

    # # make an argument for winter weekday hour to end storage discharge
    # summer_weekday_hour_to_end_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_weekday_hour_to_end_storage_discharge', true)
    # summer_weekday_hour_to_end_storage_discharge.setDisplayName('Summer Weekday Hour to End Storage Discharge (22 = 10:00 PM)')
    # summer_weekday_hour_to_end_storage_discharge.setDefaultValue(22)
    # args << summer_weekday_hour_to_end_storage_discharge

    # # make an argument for winter weekend hour to begin storage discharge
    # summer_weekend_hour_to_begin_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_weekend_hour_to_begin_storage_discharge', true)
    # summer_weekend_hour_to_begin_storage_discharge.setDisplayName('Summer Weekend Hour to Begin Storage Discharge (9 = 9:00 AM)')
    # summer_weekend_hour_to_begin_storage_discharge.setDefaultValue(9)
    # args << summer_weekend_hour_to_begin_storage_discharge

    # # make an argument for winter weekend hour to end storage discharge
    # summer_weekend_hour_to_end_storage_discharge = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_weekend_hour_to_end_storage_discharge', true)
    # summer_weekend_hour_to_end_storage_discharge.setDisplayName('Summer Weekend Hour to End Storage Discharge (22 = 10:00 PM)')
    # summer_weekend_hour_to_end_storage_discharge.setDefaultValue(22)
    # args << summer_weekend_hour_to_end_storage_discharge
    
    # # Number of batteries in paralell
    # number_of_batteries_in_parallel = OpenStudio::Measure::OSArgument.makeIntegerArgument('number_of_batteries_in_parallel', true)
    # number_of_batteries_in_parallel.setDisplayName('Number of Batteries in Paralell')
    # number_of_batteries_in_parallel.setUnits('Integer')
    # number_of_batteries_in_parallel.setDefaultValue(1)
    # args << number_of_batteries_in_parallel
 
    # # find available spaces for battery storage location
    # zone_names = []
    # unless model.getThermalZones.empty?
    # zones = model.getThermalZones
    #   zones.each do |zn|
    #     zone_names << zn.name.to_s
    #   end
    # zone_names.sort!
    # end
    # zone_names << 'Error: No Thermal Zones Found' if zone_names.empty?

    # # create argument for thermal zone (location of battery)
    # battery_storage_zone = OpenStudio::Measure::OSArgument.makeChoiceArgument('battery_storage_zone', zone_names, true)
    # battery_storage_zone.setDisplayName('Select thermal zone')
    # battery_storage_zone.setDescription('This is where the battery will be placed')
    # battery_storage_zone.setDefaultValue(zone_names[0]) # if left blank battery thermal heat gains will be to ambient and NOT handled by cooling equipment 
    # args << battery_storage_zone

    # # Number of cells in series
    # number_of_cells_in_series = OpenStudio::Measure::OSArgument.makeIntegerArgument('number_of_cells_in_series', true)
    # number_of_cells_in_series.setDisplayName('Number of Cells in Series')
    # number_of_cells_in_series.setUnits('Integer')
    # number_of_cells_in_series.setDefaultValue(136)
    # args << number_of_cells_in_series

    # # Number of cells in parallel
    # number_of_cells_in_parallel = OpenStudio::Measure::OSArgument.makeIntegerArgument('number_of_cells_in_parallel', true)
    # number_of_cells_in_parallel.setDisplayName('Number of Cells in Parallel')
    # number_of_cells_in_parallel.setUnits('Integer')
    # number_of_cells_in_parallel.setDefaultValue(136)
    # args << number_of_cells_in_parallel

    # # Battery Mass
    # battery_mass = OpenStudio::Measure::OSArgument.makeDoubleArgument('battery_mass', true)
    # battery_mass.setDisplayName('Battery Mass')
    # battery_mass.setUnits('Kilograms')
    # battery_mass.setDefaultValue(136)
    # args << battery_mass

    # # Battery Surface Area
    # battery_surface_area = OpenStudio::Measure::OSArgument.makeDoubleArgument('battery_surface_area', true)
    # battery_surface_area.setDisplayName('Battery Surface Area')
    # battery_surface_area.setUnits('Square Meters')
    # battery_surface_area.setDefaultValue(86.835)
    # args << battery_surface_area
    
    # # set radiative_fraction_for_zone_heat_gains
    # radiative_fraction_for_zone_heat_gains = OpenStudio::Measure::OSArgument.makeDoubleArgument('radiative_fraction_for_zone_heat_gains', true)
    # radiative_fraction_for_zone_heat_gains.setDisplayName('Battery Radiative Fraction Zone Heat Gains')
    # radiative_fraction_for_zone_heat_gains.setUnits('fraction')
    # radiative_fraction_for_zone_heat_gains.setDefaultValue(0.1)
    # args << radiative_fraction_for_zone_heat_gains

    # # make a choice argument for lifetime model
    # lifetime_model_chs = OpenStudio::StringVector.new
    # lifetime_model_chs << "KandlerSmith"
    # lifetime_model_chs << "None"
    # make a choice argument for lifetime_model
    # lifetime_model = OpenStudio::Measure::OSArgument::makeChoiceArgument("lifetime_model", lifetime_model_chs, true)
    # lifetime_model.setDisplayName("Battery Lifetime Model")
    # lifetime_model.setDefaultValue("KandlerSmith")
    # args << lifetime_model

    # # initial state of charge
    # initial_state_of_charge = OpenStudio::Measure::OSArgument.makeDoubleArgument('initial_state_of_charge', true)
    # initial_state_of_charge.setDisplayName('Initial Battery State of Charge')
    # initial_state_of_charge.setUnits('Decimal')
    # initial_state_of_charge.setDefaultValue(0.95)
    # args << initial_state_of_charge

    # # dc to dc charging efficiency
    # dc_to_dc_charging_efficiency = OpenStudio::Measure::OSArgument.makeDoubleArgument('dc_to_dc_charging_efficiency', true)
    # dc_to_dc_charging_efficiency.setDisplayName('DC to DC charging Efficiency')
    # dc_to_dc_charging_efficiency.setUnits('Decimal')
    # dc_to_dc_charging_efficiency.setDefaultValue(0.969)
    # args << dc_to_dc_charging_efficiency
    
    # # battery specific heat capacity
    # battery_specific_heat_capacity = OpenStudio::Measure::OSArgument.makeDoubleArgument('battery_specific_heat_capacity', true)
    # battery_specific_heat_capacity.setDisplayName('Battery Specific heat Capacity')
    # battery_specific_heat_capacity.setUnits('J/kg-K')
    # battery_specific_heat_capacity.setDefaultValue(1500)
    # args << battery_specific_heat_capacity

    # # heat_transfer_coefficienct_between_battery_and_ambient
    # heat_transfer_coefficienct_between_battery_and_ambient = OpenStudio::Measure::OSArgument.makeDoubleArgument('heat_transfer_coefficienct_between_battery_and_ambient', true)
    # heat_transfer_coefficienct_between_battery_and_ambient.setDisplayName('Heat Transfer Coefficient Between Battery and Ambient')
    # heat_transfer_coefficienct_between_battery_and_ambient.setUnits('W/m2-K')
    # heat_transfer_coefficienct_between_battery_and_ambient.setDefaultValue(100)
    # args << heat_transfer_coefficienct_between_battery_and_ambient

    # # fully charged cell voltage
    # fully_charged_cell_voltage = OpenStudio::Measure::OSArgument.makeDoubleArgument('fully_charged_cell_voltage', true)
    # fully_charged_cell_voltage.setDisplayName('Fully Charged Cell Voltage')
    # fully_charged_cell_voltage.setUnits('Volts')
    # fully_charged_cell_voltage.setDefaultValue(4.2)
    # args << fully_charged_cell_voltage

    # # cell voltage at end of exponential zone
    # cell_voltage_at_end_of_exponential_zone = OpenStudio::Measure::OSArgument.makeDoubleArgument('cell_voltage_at_end_of_exponential_zone', true)
    # cell_voltage_at_end_of_exponential_zone.setDisplayName('Cell Voltage At End of Exponential Zone')
    # cell_voltage_at_end_of_exponential_zone.setUnits('Volts')
    # cell_voltage_at_end_of_exponential_zone.setDefaultValue(3.53)
    # args << cell_voltage_at_end_of_exponential_zone

    # # cell voltage at end of nominal zone
    # cell_voltage_at_end_of_nominal_zone = OpenStudio::Measure::OSArgument.makeDoubleArgument('cell_voltage_at_end_of_nominal_zone', true)
    # cell_voltage_at_end_of_nominal_zone.setDisplayName('Cell Voltage At End of Nominal')
    # cell_voltage_at_end_of_nominal_zone.setUnits('Volts')
    # cell_voltage_at_end_of_nominal_zone.setDefaultValue(3.342)
    # args << cell_voltage_at_end_of_nominal_zone
    
    # # default nominal cell voltage
    # default_nominal_cell_voltage = OpenStudio::Measure::OSArgument.makeDoubleArgument('default_nominal_cell_voltage', true)
    # default_nominal_cell_voltage.setDisplayName('Default Nominal Cell Voltage')
    # default_nominal_cell_voltage.setUnits('Volts')
    # default_nominal_cell_voltage.setDefaultValue(3.7)
    # args << default_nominal_cell_voltage
    
    # # fully charged cell capacity
    # fully_charged_cell_capacity = OpenStudio::Measure::OSArgument.makeDoubleArgument('fully_charged_cell_capacity', true)
    # fully_charged_cell_capacity.setDisplayName('Fully Charged Cell Capacity')
    # fully_charged_cell_capacity.setUnits('Amp-Hr')
    # fully_charged_cell_capacity.setDefaultValue(26.136)
    # args << fully_charged_cell_capacity

    # # fraction of cell capacity removed at end of exponential zone
    # fraction_of_cell_capacity_removed_at_end_of_exponential_zone = OpenStudio::Measure::OSArgument.makeDoubleArgument('fraction_of_cell_capacity_removed_at_end_of_exponential_zone', true)
    # fraction_of_cell_capacity_removed_at_end_of_exponential_zone.setDisplayName('Fraction of Cell Capacity removed At End Of Exponential Zone')
    # fraction_of_cell_capacity_removed_at_end_of_exponential_zone.setUnits('Decimal')
    # fraction_of_cell_capacity_removed_at_end_of_exponential_zone.setDefaultValue(0.8075)
    # args << fraction_of_cell_capacity_removed_at_end_of_exponential_zone
    
    # # fraction of cell capacity removed at end of nominal zone
    # fraction_of_cell_capacity_removed_at_end_of_nominal_zone = OpenStudio::Measure::OSArgument.makeDoubleArgument('fraction_of_cell_capacity_removed_at_end_of_nominal_zone', true)
    # fraction_of_cell_capacity_removed_at_end_of_nominal_zone.setDisplayName('Fraction of Cell Capacity removed At End Of Nominal Zone')
    # fraction_of_cell_capacity_removed_at_end_of_nominal_zone.setUnits('Decimal')
    # fraction_of_cell_capacity_removed_at_end_of_nominal_zone.setDefaultValue(0.976875)
    # args << fraction_of_cell_capacity_removed_at_end_of_nominal_zone

    # # charge rate at which voltage vs capacity curve was generated 
    # charge_rate_at_which_voltage_vs_capacity_curve_was_generated = OpenStudio::Measure::OSArgument.makeDoubleArgument('charge_rate_at_which_voltage_vs_capacity_curve_was_generated', true)
    # charge_rate_at_which_voltage_vs_capacity_curve_was_generated.setDisplayName('Charge Rate at Which Voltage vs Capacity Curve was generated')
    # charge_rate_at_which_voltage_vs_capacity_curve_was_generated.setUnits('Decimal')
    # charge_rate_at_which_voltage_vs_capacity_curve_was_generated.setDefaultValue(1.0)
    # args << charge_rate_at_which_voltage_vs_capacity_curve_was_generated

    # # battery cel internal electrical resistance 
    # battery_cell_internal_electrical_resistance = OpenStudio::Measure::OSArgument.makeDoubleArgument('battery_cell_internal_electrical_resistance', true)
    # battery_cell_internal_electrical_resistance.setDisplayName('Battery Cell Internal Electrical Resistance')
    # battery_cell_internal_electrical_resistance.setUnits('Ohms')
    # battery_cell_internal_electrical_resistance.setDefaultValue(0.001155)
    # args << battery_cell_internal_electrical_resistance

    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)

    # use the built-in error checking to check argument type
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end

	  # declare variables for proper scope
    max_power_output = nil
    array_type = nil
	  module_type = nil
    system_losses_fraction = nil
    array_tilt = nil
    array_azimuth = nil
    ground_coverage_ratio = nil
    inverter_efficiency = nil
    dc_to_ac_size_ratio = nil
    converter_simple_fixed_efficiency = nil
    converter_ancillary_power_consumed_in_standby = nil
    converter_radiative_fraction = nil
    battery_make_model = nil
    min_state_of_charge_fraction = nil
    max_state_of_charge_fraction = nil
    nominal_capacity = nil
    usable_capacity = nil
    rated_power_output = nil
    nominal_voltage = nil
    round_trip_efficiency = nil
    lifetime_model = nil
    initial_state_of_charge = nil
    percentage_of_maximum_charge_power_to_use_for_charging = nil
    percentage_of_maximum_discharge_power_to_use_for_discharging = nil
    summer_month_to_begin_storage_season = nil
    summer_day_to_begin_storage_season = nil
    summer_month_to_end_storage_season = nil
    summer_day_to_end_storage_season = nil
    summer_weekday_hour_to_begin_storage_discharge = nil
    summer_weekday_hour_to_end_storage_discharge = nil
    summer_weekend_hour_to_begin_storage_discharge = nil
    summer_weekend_hour_to_end_storage_discharge = nil
    winter_weekday_hour_to_begin_storage_discharge = nil
    winter_weekday_hour_to_end_storage_discharge = nil
    winter_weekend_hour_to_begin_storage_discharge = nil
    winter_weekend_hour_to_end_storage_discharge = nil

	  # Open the CSV file containing the measure arguments
	  # The order of the arguments in the file does not matter
	  # Note: It is possible for the 'wrong' type of argument (integer vs string, etc.) to be provided in the csv file. 
	  # Variable type checking should be performed at the interface layer that creates the csv file
	  # See commented data in arguments method above for variable types and allowable string enumerations, for the arguments
	  data = CSV.read(File.expand_path(File.join(File.dirname(__FILE__), "resources", "PV_Battery_Inputs.csv")))
	  data.each do |row|
	    arg_name = row[0] # Access the argument name from first column of the csv file

	    max_power_output = row[2].to_f if (arg_name == "Max Power Output")
	    array_type = row[2].to_s if (arg_name == "Array Type")
      module_type = row[2].to_s if (arg_name == "Module Type")
      system_losses_fraction = row[2].to_f if (arg_name == "System Losses Fraction")
      array_tilt = row[2].to_f if (arg_name == "Array Tilt")
      array_azimuth = row[2].to_f if (arg_name == "Array Azimuth")
      ground_coverage_ratio = row[2].to_f if (arg_name == "Ground Coverage Ratio")
      inverter_efficiency = row[2].to_f if (arg_name == "Inverter Efficiency")
      dc_to_ac_size_ratio = row[2].to_f if (arg_name == "DC to AC Size Ratio")
      converter_simple_fixed_efficiency = row[2].to_f if (arg_name == "Converter Simple Fixed Efficiency")
      converter_ancillary_power_consumed_in_standby = row[2].to_f if (arg_name == "Converter Ancillary Power Consumed In Standby")
      converter_radiative_fraction = row[2].to_f if (arg_name == "Converter Radiative Fraction")
      battery_make_model = row[2].to_s if (arg_name == "Battery Make Model")
      nominal_capacity = row[2].to_f if (arg_name == "Nominal Capacity")
      usable_capacity = row[2].to_f if (arg_name == "Usable Capacity")
      rated_power_output = row[2].to_f if (arg_name == "Rated Power Output")
      nominal_voltage = row[2].to_f if (arg_name == "Nominal Voltage")
      round_trip_efficiency = row[2].to_f if (arg_name == "Round Trip Efficiency")
      min_state_of_charge_fraction = row[2].to_f if (arg_name == "Minimum State Of Charge Fraction")
      max_state_of_charge_fraction = row[2].to_f if (arg_name == "Maximum State Of Charge Fraction")
      lifetime_model = row[2].to_s if (arg_name == "Lifetime Model")
      initial_state_of_charge = row[2].to_f if (arg_name == "Initial Fraction State of Charge")
      percentage_of_maximum_charge_power_to_use_for_charging = row[2].to_f if (arg_name == "Percentage of Maximum Charge Power to use for Charging")
      percentage_of_maximum_discharge_power_to_use_for_discharging = row[2].to_f if (arg_name == "Percentage of Maximum Discharge Power to use for Discharging")
      summer_month_to_begin_storage_season = row[2].to_i if (arg_name == "Summer Month to Begin Storage Season")
      summer_day_to_begin_storage_season = row[2].to_i if (arg_name == "Summer Day to Begin Storage Season")
      summer_month_to_end_storage_season = row[2].to_i if (arg_name == "Summer Month to End Storage Season")
      summer_day_to_end_storage_season = row[2].to_i if (arg_name == "Summer Day to End Storage Season")
      summer_weekday_hour_to_begin_storage_discharge = row[2].to_i if (arg_name == "Summer Weekday Hour To Begin Storage Discharge")
      summer_weekday_hour_to_end_storage_discharge = row[2].to_i if (arg_name == "Summer Weekday Hour To End Storage Discharge")
      summer_weekend_hour_to_begin_storage_discharge = row[2].to_i if (arg_name == "Summer Weekend Hour To Begin Storage Discharge")
      summer_weekend_hour_to_end_storage_discharge = row[2].to_i if (arg_name == "Summer Weekend Hour To End Storage Discharge")
      winter_weekday_hour_to_begin_storage_discharge = row[2].to_i if (arg_name == "Winter Weekday Hour To Begin Storage Discharge")
      winter_weekday_hour_to_end_storage_discharge = row[2].to_i if (arg_name == "Winter Weekday Hour To End Storage Discharge")
      winter_weekend_hour_to_begin_storage_discharge = row[2].to_i if (arg_name == "Winter Weekend Hour To Begin Storage Discharge")
      winter_weekend_hour_to_end_storage_discharge = row[2].to_i if (arg_name == "Winter Weekend Hour To End Storage Discharge")

	  end

    # configure output variable requests
    # set as needed to debug the measure. Note that these output variables can create large eplusout.sql files
    add_generator_output_variables = true
    add_inverter_output_variables = false
    add_converter_output_variables = false
    add_storage_output_variables = true
    add_elcd_output_variables = true
    output_variable_reporting_frequency = "Hourly"

    # report initial condition of model
    pv_watts_systems = model.getGeneratorPVWattss.size
	  photovoltaic_performance_simple_systems = model.getPhotovoltaicPerformanceSimples.size
	  photovoltaic_performance_sandia_systems = model.getPhotovoltaicPerformanceSandias.size
    inverter_systems = model.getElectricLoadCenterInverterPVWattss.size
	  converter_systems = model.getElectricLoadCenterStorageConverters.size
	  li_battery_storage_systems = model.getElectricLoadCenterStorageLiIonNMCBatterys.size
	  battery_mgmt_systems = model.getElectricLoadCenterDistributions.size
    runner.registerInitialCondition("The building started with #{pv_watts_systems} PV Watts PV systems, #{photovoltaic_performance_simple_systems} PV Simple PV systems, and #{photovoltaic_performance_sandia_systems} PV Sandia PV systems, #{inverter_systems} DC to AC Inverter systems, #{converter_systems} AC to DC Converter systems, #{li_battery_storage_systems} Lithium Ion Battery Storage Systems, #{battery_mgmt_systems} PV and Lithium Ion Battery Management Systems.")
    
	  # create a new OS Generator PV Watts Object
	  generator = OpenStudio::Model::GeneratorPVWatts.new(model, max_power_output * 1000)
    generator.setName("#{max_power_output} kW generator")
    generator.setModuleType(module_type)
    generator.setSystemLosses(system_losses_fraction / 100)
    generator.setTiltAngle(array_tilt)
    generator.setAzimuthAngle(array_azimuth)
    generator.setArrayType(array_type)
	  generator.setGroundCoverageRatio(ground_coverage_ratio / 100)
    runner.registerInfo("Created #{max_power_output} kW #{array_type} PV Watts system named '#{generator.name}' with #{module_type} PV modules having system losses equal to #{(system_losses_fraction)}% , a tilt angle of #{array_tilt} degrees, facing #{array_azimuth} degrees from North.")
    
	  # List names of possible PV Watts output variables - #comment# out those not desired  
    generator_ovar_names = ['Site Horizontal Infrared Radiation Rate per Area',
                            # 'Site Diffuse Solar Radiation Rate per Area',
                            # 'Site Direct Solar Radiation Rate per Area',
                            # 'Site Exterior Horizontal Sky Illuminance',
                            # 'Site Exterior Horizontal Beam Illuminance',
                            # 'Site Exterior Beam Normal Illuminance',
                            # 'Site Sky Diffuse Solar Radiation Luminous Efficacy',
                            # 'Site Beam Solar Radiation Luminous Efficacy',
                            # 'Site Daylighting Model Sky Clearness',
                            # 'Site Daylighting Model Sky Brightness',
                            # 'Site Rain Status',
                            # 'Site Snow on Ground Status',
                            # 'Generator Produced DC Electricity Energy', 
                            # 'Plane of Array Irradiance',
                            # 'Generator PV Cell Temperature',
                            # 'Shaded Percent',
                            # 'Inverter DC to AC Efficiency',
                            # 'Inverter DC Input Electricity Energy',
                            # 'Inverter AC Output Electricity Energy',
                            # 'Inverter Conversion Loss Power',
                            # 'Inverter Conversion Loss Energy', 
                            # 'Inverter Conversion Loss Decrement Energy',
                            # 'Inverter Thermal Loss Energy',
                            # 'Inverter Ancillary AC Electricity Energy',
                            # 'Facility Total Purchased Electricity Energy',
                            # 'Facility Total Surplus Electricity Energy',
                            # 'Facility Net Purchased Electricity Energy',
                            'Facility Total Building Electricity Demand Rate',
                            'Facility Total HVAC Electricity Demand Rate',
                            'Facility Total Electricity Demand Rate',
                            'Facility Total Produced Electricity Rate',
                            'Facility Total Produced Electricity Energy']

	  # create a new OS ElectricLoadCenterInverterPVWatts Object for converting the DC generated solar into AC
	  inverter = OpenStudio::Model::ElectricLoadCenterInverterPVWatts.new(model)
    inverter.setName("#{(max_power_output * dc_to_ac_size_ratio).round(1)} kW inverter")
    inverter.setInverterEfficiency(inverter_efficiency)
	  inverter.setDCToACSizeRatio(dc_to_ac_size_ratio)
    runner.registerInfo("Created a PV Watts Inverter with efficiency of #{inverter_efficiency} and DC to AC_size ratio of #{dc_to_ac_size_ratio}.")

    # List names of possible Inverter PV Watts output variables - #comment# out those not desired  
    inverter_ovar_names = ['Inverter DC to AC Efficiency',
                           'Inverter DC Input Electricity Energy',
                           'Inverter AC Output Electricity Energy',
                           # 'Inverter Conversion Loss Power',
                           # 'Inverter Conversion Loss Energy',
                           # 'Inverter Conversion Loss Decrement Energy',
                           # 'Inverter Thermal Loss Energy',
                           'Inverter Ancillary AC Electricity Energy']

	  # create a new OS ElectricLoadCenterStorageConverter Object for converting the AC into DC for charging the battery
    converter = OpenStudio::Model::ElectricLoadCenterStorageConverter.new(model)
    converter.setName("#{max_power_output} kW Electric Load Storage Converter")
	  converter.setAvailabilitySchedule(model.alwaysOnDiscreteSchedule)
	  converter.setSimpleFixedEfficiency(converter_simple_fixed_efficiency)
	  converter.setAncillaryPowerConsumedInStandby(converter_ancillary_power_consumed_in_standby)
	  converter.setRadiativeFraction(converter_radiative_fraction)
	  # converter.setThermalZone(zone) # For now, we leave converter heat gains to space outside of energy calculations. 
	  # We used "setSimpleFixedEfficiency', so neither of these fields are used:
	  # converter.setDesignMaximumContinuousInputPower
	  # converter.setEfficiencyFunctionofPowerCurve
    runner.registerInfo("Created #{max_power_output} kW Electric Load Storage Converter named '#{converter.name}'.")

    # List names of possible Converter output variables - #comment# out those not desired  
    converter_ovar_names = ['Converter AC to DC Efficiency',
                            'Converter AC Input Electricity Energy',
                            'Converter DC Output Electricity Energy',
                            # 'Converter Electric Loss Power',
                            # 'Converter Electric Loss Energy',
                            # 'Converter Electric Loss Decrement Energy',
                            # 'Converter Thermal Loss Energy',
                            'Converter Ancillary AC Electricity Energy']

    # create a new OS ElectricLoadCenterStorageLiIonNMCBattery Object representing a 'bank' of Lithium Ion Batteries
    usable_fraction = usable_capacity / nominal_capacity

    default_nominal_cell_voltage = 3.342 # V, EnergyPlus default
    default_cell_voltage_at_end_of_nominal_zone = 3.342 # V, EnergyPlus default
    default_cell_voltage_at_end_of_exponential_zone = 3.342 # V, EnergyPlus default
    default_fully_charged_cell_voltage = 4.2 # V, EnergyPlus default
    default_cell_capacity = 3.2 # Ah, EnergyPlus default
    default_fraction_of_cell_capacity_removed_at_the_end_of_nominal_zone = 0.976875 # EnergyPlus default
    default_charge_rate_at_which_voltage_vs_capacity_curve_was_generated =  1.0 # EnergyPlus default
    
    battery_cell_internal_electrical_resistance = 0.002 # mOhm/cell, based on OCHRE defaults (which are based on fitting to lab results)
    frac_sens = 0.0 # Assume Battery is outside
    number_of_cells_in_series = Integer((nominal_voltage / default_nominal_cell_voltage).round)
    number_of_strings_in_parallel = Integer(((nominal_capacity * 1000.0) / ((default_nominal_cell_voltage * number_of_cells_in_series) * default_cell_capacity)).round)
    battery_mass = (nominal_capacity / 10.0) * 99.0 # kg
    battery_surface_area = 0.306 * (nominal_capacity**(2.0 / 3.0)) # m^2

    voltage_dependence = false
    if lifetime_model == "KandlerSmith"
      voltage_dependence = true
    end

    storage = OpenStudio::Model::ElectricLoadCenterStorageLiIonNMCBattery.new(model, number_of_cells_in_series, number_of_strings_in_parallel, battery_mass, battery_surface_area)
    storage.setName("Lithium Ion Battery")
    storage.setRadiativeFraction(0.9 * frac_sens)
    storage.setLifetimeModel("None")
    storage.setNumberofCellsinSeries(number_of_cells_in_series)
    storage.setNumberofStringsinParallel(number_of_strings_in_parallel)
    storage.setInitialFractionalStateofCharge(initial_state_of_charge)
    storage.setBatteryMass(battery_mass)
    storage.setBatterySurfaceArea(battery_surface_area)
    storage.setDefaultNominalCellVoltage(default_nominal_cell_voltage)
    storage.setFullyChargedCellCapacity(default_cell_capacity)
    storage.setCellVoltageatEndofNominalZone(default_cell_voltage_at_end_of_nominal_zone)
    if not voltage_dependence
      storage.setBatteryCellInternalElectricalResistance(0.002) # 2 mOhm/cell, based on OCHRE defaults (which are based on fitting to lab results)
      # FIXME: if the voltage reported during charge/discharge is different, energy may not balance
      # storage.setFullyChargedCellVoltage(default_nominal_cell_voltage)
      # storage.setCellVoltageatEndofExponentialZone(default_nominal_cell_voltage)
    end
    storage.setFullyChargedCellVoltage(default_fully_charged_cell_voltage)
    storage.setCellVoltageatEndofExponentialZone(default_cell_voltage_at_end_of_exponential_zone)
    storage.setFractionofCellCapacityRemovedattheEndofNominalZone(default_fraction_of_cell_capacity_removed_at_the_end_of_nominal_zone)
    storage.setChargeRateatWhichVoltagevsCapacityCurveWasGenerated(default_charge_rate_at_which_voltage_vs_capacity_curve_was_generated)
    storage.setBatteryCellInternalElectricalResistance(battery_cell_internal_electrical_resistance)
    runner.registerInfo("Created a Li-Ion Battery Storage System named '#{storage.name}'.")

    # List names of possible Li-Ion Batery Storage output variables - #comment# out those not desired  
    storage_ovar_names = ['Electric Storage Operating Mode Index',
                          'Electric Storage Charge State', 
                          'Electric Storage Charge Fraction',
                          'Electric Storage Charge Power',
                          'Electric Storage Charge Energy',
                          'Electric Storage Discharge Power',
                          'Electric Storage Discharge Energy',
                          'Electric Storage Total Current',
                          'Electric Storage Total Voltage',
                          'Electric Storage Thermal Loss Rate',
                          'Electric Storage Degradation Fraction',
                          'Electric Storage Production Decrement Energy',
                          'Electric Storage Thermal Loss Energy',
                          'Electric Storage Battery Temperature']

    # Set Design days to NOT charge or discharge storage 
    summer_design_day = OpenStudio::Model::ScheduleDay.new(model)
    summer_design_day.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0.0)

    winter_design_day = OpenStudio::Model::ScheduleDay.new(model)
    winter_design_day.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0.0)

    # Create charge schedule
    charge_schedule_ruleset = OpenStudio::Model::ScheduleRuleset.new(model)
    charge_schedule_ruleset.setName('Battery Charge Schedule')
    charge_schedule_ruleset.setSummerDesignDaySchedule(summer_design_day)
    charge_schedule_ruleset.setWinterDesignDaySchedule(winter_design_day)

    # Create discharge schedule
    discharge_schedule_ruleset = OpenStudio::Model::ScheduleRuleset.new(model)
    discharge_schedule_ruleset.setName('Battery Discharge Schedule')
    discharge_schedule_ruleset.setSummerDesignDaySchedule(summer_design_day)
    discharge_schedule_ruleset.setWinterDesignDaySchedule(winter_design_day)

    # Winter Period 1 Weekdays Charge Schedule Rule
    winter1_weekdayRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    winter1_weekdayRule.setName("Weekday Winter Period 1 Battery Bank Charge Schedule")
    winter1_weekdayRule.setApplySunday(false)
    winter1_weekdayRule.setApplyMonday(true)
    winter1_weekdayRule.setApplyTuesday(true)
    winter1_weekdayRule.setApplyWednesday(true)
    winter1_weekdayRule.setApplyThursday(true)
    winter1_weekdayRule.setApplyFriday(true)
    winter1_weekdayRule.setApplySaturday(false)
    winter1_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(1), 1))
    winter1_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_end_storage_discharge, 0, 0), 0)
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Winter Period 1 Weekends Charge Schedule Rule
    winter1_weekendRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    winter1_weekendRule.setName("Weekend Winter Period 1 Battery Bank Charge Schedule")
    winter1_weekendRule.setApplySunday(true)
    winter1_weekendRule.setApplyMonday(false)
    winter1_weekendRule.setApplyTuesday(false)
    winter1_weekendRule.setApplyWednesday(false)
    winter1_weekendRule.setApplyThursday(false)
    winter1_weekendRule.setApplyFriday(false)
    winter1_weekendRule.setApplySaturday(true)
    winter1_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(1), 1))
    winter1_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_end_storage_discharge, 0, 0), 0)
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Summer Period Weekdays Charge Schedule Rule
    summer_weekdayRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    summer_weekdayRule.setName("Weekday Summer Battery Bank Charge Schedule")
    summer_weekdayRule.setApplySunday(false)
    summer_weekdayRule.setApplyMonday(true)
    summer_weekdayRule.setApplyTuesday(true)
    summer_weekdayRule.setApplyWednesday(true)
    summer_weekdayRule.setApplyThursday(true)
    summer_weekdayRule.setApplyFriday(true)
    summer_weekdayRule.setApplySaturday(false)
    summer_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    summer_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekday_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekday_hour_to_end_storage_discharge, 0, 0), 0)
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Summer Period Weekends Charge Schedule Rule
    summer_weekendRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    summer_weekendRule.setName("Weekend Summer Battery Bank Charge Schedule")
    summer_weekendRule.setApplySunday(true)
    summer_weekendRule.setApplyMonday(false)
    summer_weekendRule.setApplyTuesday(false)
    summer_weekendRule.setApplyWednesday(false)
    summer_weekendRule.setApplyThursday(false)
    summer_weekendRule.setApplyFriday(false)
    summer_weekendRule.setApplySaturday(true)
    summer_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    summer_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekend_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekend_hour_to_end_storage_discharge, 0, 0), 0)
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Winter Period #2 Weekdays Charge Schedule Rule
    winter2_weekdayRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    winter2_weekdayRule.setName("Weekday Winter Period 2 Battery Bank Charge Schedule")
    winter2_weekdayRule.setApplySunday(false)
    winter2_weekdayRule.setApplyMonday(true)
    winter2_weekdayRule.setApplyTuesday(true)
    winter2_weekdayRule.setApplyWednesday(true)
    winter2_weekdayRule.setApplyThursday(true)
    winter2_weekdayRule.setApplyFriday(true)
    winter2_weekdayRule.setApplySaturday(false)
    winter2_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    winter2_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(12), 31))
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_end_storage_discharge, 0, 0), 0)
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Winter Period #2 Weekends Charge Schedule Rule
    winter2_weekendRule = OpenStudio::Model::ScheduleRule.new(charge_schedule_ruleset)
    winter2_weekendRule.setName("Weekend Winter Period 2 Battery Bank Charge Schedule")
    winter2_weekendRule.setApplySunday(true)
    winter2_weekendRule.setApplyMonday(false)
    winter2_weekendRule.setApplyTuesday(false)
    winter2_weekendRule.setApplyWednesday(false)
    winter2_weekendRule.setApplyThursday(false)
    winter2_weekendRule.setApplyFriday(false)
    winter2_weekendRule.setApplySaturday(true)
    winter2_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    winter2_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(12), 31))
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_begin_storage_discharge, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_end_storage_discharge, 0, 0), 0)
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), percentage_of_maximum_charge_power_to_use_for_charging)

    # Winter Period 1 Weekdays Discharge Schedule Rule
    winter1_weekdayRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    winter1_weekdayRule.setName("Weekday Winter Period 1 Battery Bank Discharge Schedule")
    winter1_weekdayRule.setApplySunday(false)
    winter1_weekdayRule.setApplyMonday(true)
    winter1_weekdayRule.setApplyTuesday(true)
    winter1_weekdayRule.setApplyWednesday(true)
    winter1_weekdayRule.setApplyThursday(true)
    winter1_weekdayRule.setApplyFriday(true)
    winter1_weekdayRule.setApplySaturday(false)
    winter1_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(1), 1))
    winter1_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_begin_storage_discharge, 0, 0), 0)
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    winter1_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # Winter Period 1 Weekends Discharge Schedule Rule
    winter1_weekendRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    winter1_weekendRule.setName("Weekend Winter Period 1 Battery Bank Discharge Schedule")
    winter1_weekendRule.setApplySunday(true)
    winter1_weekendRule.setApplyMonday(false)
    winter1_weekendRule.setApplyTuesday(false)
    winter1_weekendRule.setApplyWednesday(false)
    winter1_weekendRule.setApplyThursday(false)
    winter1_weekendRule.setApplyFriday(false)
    winter1_weekendRule.setApplySaturday(true)
    winter1_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(1), 1))
    winter1_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_begin_storage_discharge, 0, 0), 0)
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    winter1_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # Summer Period Weekdays DisCharge Schedule Rule
    summer_weekdayRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    summer_weekdayRule.setName("Weekday Summer Battery Bank Discharge Schedule")
    summer_weekdayRule.setApplySunday(false)
    summer_weekdayRule.setApplyMonday(true)
    summer_weekdayRule.setApplyTuesday(true)
    summer_weekdayRule.setApplyWednesday(true)
    summer_weekdayRule.setApplyThursday(true)
    summer_weekdayRule.setApplyFriday(true)
    summer_weekdayRule.setApplySaturday(false)
    summer_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    summer_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekday_hour_to_begin_storage_discharge, 0, 0), 0)
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekday_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    summer_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # Summer Period Weekends Discharge Schedule Rule
    summer_weekendRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    summer_weekendRule.setName("Weekend Summer Battery Bank Discharge Schedule")
    summer_weekendRule.setApplySunday(true)
    summer_weekendRule.setApplyMonday(false)
    summer_weekendRule.setApplyTuesday(false)
    summer_weekendRule.setApplyWednesday(false)
    summer_weekendRule.setApplyThursday(false)
    summer_weekendRule.setApplyFriday(false)
    summer_weekendRule.setApplySaturday(true)
    summer_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_begin_storage_season), summer_day_to_begin_storage_season))
    summer_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekend_hour_to_begin_storage_discharge, 0, 0), 0)
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, summer_weekend_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    summer_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # Winter Period #2 Weekdays Discharge Schedule Rule
    winter2_weekdayRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    winter2_weekdayRule.setName("Weekday Winter Period 2 Battery Bank Discharge Schedule")
    winter2_weekdayRule.setApplySunday(false)
    winter2_weekdayRule.setApplyMonday(true)
    winter2_weekdayRule.setApplyTuesday(true)
    winter2_weekdayRule.setApplyWednesday(true)
    winter2_weekdayRule.setApplyThursday(true)
    winter2_weekdayRule.setApplyFriday(true)
    winter2_weekdayRule.setApplySaturday(false)
    winter2_weekdayRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    winter2_weekdayRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(12), 31))
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_begin_storage_discharge, 0, 0), 0)
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekday_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    winter2_weekdayRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # Winter Period #2 Weekends Discharge Schedule Rule
    winter2_weekendRule = OpenStudio::Model::ScheduleRule.new(discharge_schedule_ruleset)
    winter2_weekendRule.setName("Weekend Winter Period 2 Battery Bank Discharge Schedule")
    winter2_weekendRule.setApplySunday(true)
    winter2_weekendRule.setApplyMonday(false)
    winter2_weekendRule.setApplyTuesday(false)
    winter2_weekendRule.setApplyWednesday(false)
    winter2_weekendRule.setApplyThursday(false)
    winter2_weekendRule.setApplyFriday(false)
    winter2_weekendRule.setApplySaturday(true)
    winter2_weekendRule.setStartDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(summer_month_to_end_storage_season), summer_day_to_end_storage_season))
    winter2_weekendRule.setEndDate(OpenStudio::Date.new(OpenStudio::MonthOfYear.new(12), 31))
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_begin_storage_discharge, 0, 0), 0)
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, winter_weekend_hour_to_end_storage_discharge, 0, 0), percentage_of_maximum_discharge_power_to_use_for_discharging)
    winter2_weekendRule.daySchedule.addValue(OpenStudio::Time.new(0, 24, 0, 0), 0)

    # create a new OS ElectricLoadCenterDistribution Object for managaing the battery charge and discharge (to meet the facility Demand leveling goals)
    electric_load_center_dist = OpenStudio::Model::ElectricLoadCenterDistribution.new(model)
	  electric_load_center_dist.setName("Time of Use Tariff following Elec Load Control Center")
    electric_load_center_dist.addGenerator(generator)
	  electric_load_center_dist.setInverter(inverter)
    electric_load_center_dist.setElectricalStorage(storage)    
    electric_load_center_dist.setStorageConverter(converter)    
    electric_load_center_dist.setGeneratorOperationSchemeType("Baseload")
    electric_load_center_dist.setElectricalBussType("DirectCurrentWithInverterACStorage")
    electric_load_center_dist.setStorageOperationScheme("TrackChargeDischargeSchedules")
    electric_load_center_dist.setDesignStorageControlChargePower(rated_power_output * 1000) # convert from kW
    electric_load_center_dist.setDesignStorageControlDischargePower(rated_power_output * 1000) # convert from kW
    electric_load_center_dist.setMinimumStorageStateofChargeFraction(min_state_of_charge_fraction)
    electric_load_center_dist.setMaximumStorageStateofChargeFraction(max_state_of_charge_fraction)
    electric_load_center_dist.setStorageChargePowerFractionSchedule(charge_schedule_ruleset)
    electric_load_center_dist.setStorageDischargePowerFractionSchedule(discharge_schedule_ruleset)
    runner.registerInfo("Created a Electric Load Center Distribution Object named '#{electric_load_center_dist.name}'.")
    
    # List names of possible Electric Load Distribution Center output variables - #comment# out those not desired  
    elcd_ovar_names = ['Facility Total Purchased Electricity Rate',
                       'Facility Total Purchased Electricity Energy',
                       #'Facility Total Surplus Electricity Rate',
                       'Facility Total Surplus Electricity Energy',
                       #'Facility Net Purchased Electricity Rate',
                       #'Facility Net Purchased Electricity Energy',
                       'Facility Total Building Electricity Demand Rate',
                       #'Facility Total HVAC Electricity Demand Rate',
                       'Facility Total Electricity Demand Rate',
                       #'Facility Total Produced Electricity Rate',
                       'Facility Total Produced Electricity Energy']
  
    ovars = []
    if (add_generator_output_variables == true)
      generator_ovar_names.each do |output_variable_name|
        ovars << OpenStudio::Model::OutputVariable.new(output_variable_name, model)
      end
      runner.registerInfo("#{generator_ovar_names.size} Generator output variables were added to the model.")
    end
    if (add_inverter_output_variables == true)
      inverter_ovar_names.each do |output_variable_name|
        ovars << OpenStudio::Model::OutputVariable.new(output_variable_name, model)
      end
      runner.registerInfo("#{inverter_ovar_names.size} Inverter output variables were added to the model.")
	  end
    if (add_converter_output_variables	== true)
	    converter_ovar_names.each do |output_variable_name|
        ovars << OpenStudio::Model::OutputVariable.new(output_variable_name, model)
      end
      runner.registerInfo("#{converter_ovar_names.size} Converter output variables were added to the model.")
	  end
    if (add_storage_output_variables == true)
	    storage_ovar_names.each do |output_variable_name|
        ovars << OpenStudio::Model::OutputVariable.new(output_variable_name, model)
      end
      runner.registerInfo("#{storage_ovar_names.size} Lithium Ion Battery Storage output variables were added to the model.")
	  end
    if (add_elcd_output_variables == true)
      elcd_ovar_names.each do |output_variable_name|
        ovars << OpenStudio::Model::OutputVariable.new(output_variable_name, model)
      end
      runner.registerInfo("#{elcd_ovar_names.size} Electric Load Distribution Center output variables were added to the model.")
	  end

    # set output variable reporting frequency
    ovars.each do |var|
      var.setReportingFrequency(output_variable_reporting_frequency)
    end

    # report final condition of model
    pv_watts_systems = model.getGeneratorPVWattss.size
	  photovoltaic_performance_simple_systems = model.getPhotovoltaicPerformanceSimples.size
	  photovoltaic_performance_sandia_systems = model.getPhotovoltaicPerformanceSandias.size
    inverter_systems = model.getElectricLoadCenterInverterPVWattss.size
	  converter_systems = model.getElectricLoadCenterStorageConverters.size
	  li_battery_storage_systems = model.getElectricLoadCenterStorageLiIonNMCBatterys.size
	  battery_mgmt_systems = model.getElectricLoadCenterDistributions.size
	  
    runner.registerFinalCondition("The building finished with #{pv_watts_systems} PV Watts PV systems, #{photovoltaic_performance_simple_systems} PV Simple PV systems, and #{photovoltaic_performance_sandia_systems} PV Sandia PV systems, #{inverter_systems} DC to AC Inverter systems, #{converter_systems} AC to DC Converter systems, #{li_battery_storage_systems} Lithium Ion Battery Storage Systems, #{battery_mgmt_systems} PV and Lithium Ion Battery Management Systems.")
    return true

  end # end run method
end # end class

# register the measure to be used by the application
RevitAddPVAddStorageTOU.new.registerWithApplication

