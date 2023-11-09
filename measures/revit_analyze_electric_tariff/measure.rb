# insert your copyright here

# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

# start the measure
class RevitAnalyzeElectricTariff < OpenStudio::Measure::EnergyPlusMeasure
  
  # human readable name
  def name
    return 'revit_analyze_electric_tariff'
  end

  # human readable description
  def description
    return 'This measure can be used to sets rates for electricity. Seasonal and off peak rates can be defined for seperate supplier and transmission/distribution tariffs. It exposes inputs for the time of day and day of year where peak rates should be applied, as well as a block structure for up to (3) different cumulative kWh amounts.'
  end

  # human readable description of modeling approach
  def modeler_description
    return 'Will add the necessary UtilityCost objects and associated schedule into the model.'
  end

  # define the arguments that the user will input
  def arguments(workspace)
    args = OpenStudio::Measure::OSArgumentVector.new

    # # adding argument for Tariff Name
    # tariff_name = OpenStudio::Measure::OSArgument.makeStringArgument('tariff_name', true)
    # tariff_name.setDisplayName('NAme of Electricity Tariff')
    # tariff_name.setDescription("The name of the tariff (defined in the 'Electric_Utility__Tariff_Arguments.csv' file).")
    # args << tariff_name

    # # make choice argument for facade
    # choices = OpenStudio::StringVector.new
    # choices << 'QuarterHour'
    # choices << 'HalfHour'
    # choices << 'FullHour'
    # # don't want to offer Day or Week even though valid E+ options
    # # choices << "Day"
    # # choices << "Week"
    # demand_window_length = OpenStudio::Measure::OSArgument.makeChoiceArgument('demand_window_length', choices, true)
    # demand_window_length.setDisplayName('Demand Window Length.')
    # demand_window_length.setDefaultValue('QuarterHour')
    # args << demand_window_length

    # # adding argument for t_and_d_summer_start_month
    # t_and_d_summer_start_month = OpenStudio::Measure::OSArgument.makeIntegerArgument('t_and_d_summer_start_month', true)
    # t_and_d_summer_start_month.setDisplayName('Month Summer Begins')
    # t_and_d_summer_start_month.setDescription('1-12')
    # t_and_d_summer_start_month.setDefaultValue(5)
    # args << t_and_d_summer_start_month

    # # adding argument for summer_start_day
    # summer_start_day = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_start_day', true)
    # summer_start_day.setDisplayName('Day Summer Begins')
    # summer_start_day.setDescription('1-31')
    # summer_start_day.setDefaultValue(1)
    # args << summer_start_day

    # # adding argument for summer_end_month
    # summer_end_month = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_end_month', true)
    # summer_end_month.setDisplayName('Month Summer Ends')
    # summer_end_month.setDescription('1-12')
    # summer_end_month.setDefaultValue(9)
    # args << summer_end_month

    # # adding argument for summer_end_day
    # summer_end_day = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_end_day', true)
    # summer_end_day.setDisplayName('Day Summer Ends')
    # summer_end_day.setDescription('1-31')
    # summer_end_day.setDefaultValue(1)
    # args << summer_end_day

    # # adding argument for peak_start_hour
    # peak_start_hour = OpenStudio::Measure::OSArgument.makeDoubleArgument('peak_start_hour', true)
    # peak_start_hour.setDisplayName('Hour Peak Begins')
    # peak_start_hour.setDescription('1-24')
    # peak_start_hour.setDefaultValue(12)
    # args << peak_start_hour

    # # adding argument for peak_end_hour
    # peak_end_hour = OpenStudio::Measure::OSArgument.makeDoubleArgument('peak_end_hour', true)
    # peak_end_hour.setDisplayName('Hour Peak Ends')
    # peak_end_hour.setDescription('1-24')
    # peak_end_hour.setDefaultValue(18)
    # args << peak_end_hour

    # # adding argument for elec_rate_sum_peak
    # elec_rate_sum_peak = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_rate_sum_peak', true)
    # elec_rate_sum_peak.setDisplayName('Electric Rate Summer On-Peak')
    # elec_rate_sum_peak.setUnits('$/kWh')
    # elec_rate_sum_peak.setDefaultValue(0.06)
    # args << elec_rate_sum_peak

    # # adding argument for elec_rate_sum_nonpeak
    # elec_rate_sum_nonpeak = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_rate_sum_nonpeak', true)
    # elec_rate_sum_nonpeak.setDisplayName('Electric Rate Summer Off-Peak')
    # elec_rate_sum_nonpeak.setUnits('$/kWh')
    # elec_rate_sum_nonpeak.setDefaultValue(0.04)
    # args << elec_rate_sum_nonpeak

    # # adding argument for elec_rate_nonsum_peak
    # elec_rate_nonsum_peak = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_rate_nonsum_peak', true)
    # elec_rate_nonsum_peak.setDisplayName('Electric Rate Not Summer On-Peak')
    # elec_rate_nonsum_peak.setUnits('$/kWh')
    # elec_rate_nonsum_peak.setDefaultValue(0.05)
    # args << elec_rate_nonsum_peak

    # # adding argument for elec_rate_nonsum_nonpeak
    # elec_rate_nonsum_nonpeak = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_rate_nonsum_nonpeak', true)
    # elec_rate_nonsum_nonpeak.setDisplayName('Electric Rate Not Summer Off-Peak')
    # elec_rate_nonsum_nonpeak.setUnits('$/kWh')
    # elec_rate_nonsum_nonpeak.setDefaultValue(0.03)
    # args << elec_rate_nonsum_nonpeak

    # # adding argument for elec_demand_sum
    # elec_demand_sum = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_demand_sum', true)
    # elec_demand_sum.setDisplayName('Electric Peak Demand Charge Summer')
    # elec_demand_sum.setUnits('$/kW')
    # elec_demand_sum.setDefaultValue(15.0)
    # args << elec_demand_sum

    # # adding argument for elec_demand_nonsum
    # elec_demand_nonsum = OpenStudio::Measure::OSArgument.makeDoubleArgument('elec_demand_nonsum', true)
    # elec_demand_nonsum.setDisplayName('Electric Peak Demand Charge Not Summer')
    # elec_demand_nonsum.setUnits('$/kW')
    # elec_demand_nonsum.setDefaultValue(10.0)
    # args << elec_demand_nonsum

    # # adding argument for monthly_charge
    # monthly_charge = OpenStudio::Measure::OSArgument.makeDoubleArgument('monthly_charge', true)
    # monthly_charge.setDisplayName('Monthly Charge')
    # monthly_charge.setUnits('$')
    # monthly_charge.setDefaultValue(30.0)
    # args << monthly_charge

    # # adding argument for t_and_d_qualifying_min_monthly_demand
    # t_and_d_qualifying_min_monthly_demand = OpenStudio::Measure::OSArgument.makeDoubleArgument('t_and_d_qualifying_min_monthly_demand', true)
    # t_and_d_qualifying_min_monthly_demand.setDisplayName('Minimum Monthly Charge')
    # t_and_d_qualifying_min_monthly_demand.setUnits('$')
    # t_and_d_qualifying_min_monthly_demand.setDefaultValue(100.0)
    # args << t_and_d_qualifying_min_monthly_demand
    
    # # adding argument for summer_start_month
    # summer_start_month = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_start_month', true)
    # summer_start_month.setDisplayName('Month Summer Begins')
    # summer_start_month.setDescription('1-12')
    # summer_start_month.setDefaultValue(5)
    # args << summer_start_month

     # # adding argument for summer_start_day
    # summer_start_day = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_start_day', true)
    # summer_start_day.setDisplayName('Day Summer Begins')
    # summer_start_day.setDescription('1-31')
    # summer_start_day.setDefaultValue(1)
    # args << summer_start_day

    # # adding argument for summer_end_month
    # summer_end_month = OpenStudio::Measure::OSArgument.makeIntegerArgument('summer_end_month', true)
    # summer_end_month.setDisplayName('Month Summer Ends')
    # summer_end_month.setDescription('1-12')
    # summer_end_month.setDefaultValue(9)
    # args << summer_end_month

    # # adding argument for supply_summer_end_day
    # supply_summer_end_day = OpenStudio::Measure::OSArgument.makeIntegerArgument('supply_summer_end_day', true)
    # supply_summer_end_day.setDisplayName('Day Summer Ends')
    # supply_summer_end_day.setDescription('1-31')
    # supply_summer_end_day.setDefaultValue(1)
    # args << supply_summer_end_day

    # # adding argument for peak_start_hour
    # peak_start_hour = OpenStudio::Measure::OSArgument.makeDoubleArgument('peak_start_hour', true)
    # peak_start_hour.setDisplayName('Hour Peak Begins')
    # peak_start_hour.setDescription('1-24')
    # peak_start_hour.setDefaultValue(12)
    # args << peak_start_hour

    # # adding argument for peak_end_hour
    # peak_end_hour = OpenStudio::Measure::OSArgument.makeDoubleArgument('peak_end_hour', true)
    # peak_end_hour.setDisplayName('Hour Peak Ends')
    # peak_end_hour.setDescription('1-24')
    # peak_end_hour.setDefaultValue(18)
    # args << peak_end_hour

    # # adding argument for supply_elec_rate_sum_peak
    # supply_elec_rate_sum_peak = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_rate_sum_peak', true)
    # supply_elec_rate_sum_peak.setDisplayName('Electric Rate Summer On-Peak')
    # supply_elec_rate_sum_peak.setUnits('$/kWh')
    # supply_elec_rate_sum_peak.setDefaultValue(0.06)
    # args << supply_elec_rate_sum_peak

    # # adding argument for supply_elec_rate_sum_nonpeak
    # supply_elec_rate_sum_nonpeak = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_rate_sum_nonpeak', true)
    # supply_elec_rate_sum_nonpeak.setDisplayName('Electric Rate Summer Off-Peak')
    # supply_elec_rate_sum_nonpeak.setUnits('$/kWh')
    # supply_elec_rate_sum_nonpeak.setDefaultValue(0.04)
    # args << supply_elec_rate_sum_nonpeak

    # # adding argument for supply_elec_rate_nonsum_peak
    # supply_elec_rate_nonsum_peak = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_rate_nonsum_peak', true)
    # supply_elec_rate_nonsum_peak.setDisplayName('Electric Rate Not Summer On-Peak')
    # supply_elec_rate_nonsum_peak.setUnits('$/kWh')
    # supply_elec_rate_nonsum_peak.setDefaultValue(0.05)
    # args << supply_elec_rate_nonsum_peak

    # # adding argument for supply_elec_rate_nonsum_nonpeak
    # supply_elec_rate_nonsum_nonpeak = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_rate_nonsum_nonpeak', true)
    # supply_elec_rate_nonsum_nonpeak.setDisplayName('Electric Rate Not Summer Off-Peak')
    # supply_elec_rate_nonsum_nonpeak.setUnits('$/kWh')
    # supply_elec_rate_nonsum_nonpeak.setDefaultValue(0.03)
    # args << supply_elec_rate_nonsum_nonpeak

    # # adding argument for supply_elec_demand_sum
    # supply_elec_demand_sum = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_demand_sum', true)
    # supply_elec_demand_sum.setDisplayName('Electric Peak Demand Charge Summer')
    # supply_elec_demand_sum.setUnits('$/kW')
    # supply_elec_demand_sum.setDefaultValue(15.0)
    # args << supply_elec_demand_sum

    # # adding argument for supply_elec_demand_nonsum
    # supply_elec_demand_nonsum = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_elec_demand_nonsum', true)
    # supply_elec_demand_nonsum.setDisplayName('Electric Peak Demand Charge Not Summer')
    # supply_elec_demand_nonsum.setUnits('$/kW')
    # supply_elec_demand_nonsum.setDefaultValue(10.0)
    # args << supply_elec_demand_nonsum

    # # adding argument for supply_monthly_charge
    # supply_monthly_charge = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_monthly_charge', true)
    # supply_monthly_charge.setDisplayName('Monthly Charge')
    # supply_monthly_charge.setUnits('$')
    # supply_monthly_charge.setDefaultValue(30.0)
    # args << supply_monthly_charge

    # # adding argument for supply_min_monthly_charge
    # supply_min_monthly_charge = OpenStudio::Measure::OSArgument.makeDoubleArgument('supply_min_monthly_charge', true)
    # supply_min_monthly_charge.setDisplayName('Minimum Monthly Charge')
    # supply_min_monthly_charge.setUnits('$')
    # supply_min_monthly_charge.setDefaultValue(100.0)
    # args << supply_min_monthly_charge
    
    return args
  end

  # define what happens when the measure is run
  def run(workspace, runner, user_arguments)
    super(workspace, runner, user_arguments)

    # assign the user inputs to variables
    args = OsLib_HelperMethods.createRunVariables(runner, workspace, user_arguments, arguments(workspace))
    if !args then return false end

    def add_demand_window_and_timetep(workspace, runner, demand_window_length)
      
      # map demand window length to integer
      demand_window_per_hour = nil
      if demand_window_length == 'QuarterHour'
        demand_window_per_hour = 4
      elsif demand_window_length == 'HalfHour'
        demand_window_per_hour = 2
      elsif demand_window_length == 'FullHour'
        demand_window_per_hour = 1
      end

      # make sure demand window length is is divisible by timestep
      if !workspace.getObjectsByType('Timestep'.to_IddObjectType).empty?
        initial_timestep = workspace.getObjectsByType('Timestep'.to_IddObjectType)[0].getString(0).get

        if initial_timestep.to_f / demand_window_per_hour.to_f == (initial_timestep.to_f / demand_window_per_hour.to_f).truncate # checks if remainder of divided numbers is > 0
          runner.registerInfo("The demand window length of a #{demand_window_length} is compatible with the current setting of #{initial_timestep} timesteps per hour.")
        else
          workspace.getObjectsByType('Timestep'.to_IddObjectType)[0].setString(0, demand_window_per_hour.to_s)
          runner.registerInfo("Updating the timesteps per hour in the model from #{initial_timestep} to #{demand_window_per_hour} to be compatible with the demand window length of a #{demand_window_length}")
        end
      else

        # add a timestep object to the workspace
        new_object_string = "
        Timestep,
          #{demand_window_per_hour};                                   - Number of Timesteps per Hour
          "
        idfObject = OpenStudio::IdfObject.load(new_object_string)
        object = idfObject.get
        wsObject = workspace.addObject(object)
        new_object = wsObject.get
        runner.registerInfo('No timestep object found. Added a new timestep object set to 4 timesteps per hour')
      end
      
    end

    def add_tariff_object_and_schedules(workspace, runner, tariff_name, demand_window_length, summer_start_month, summer_start_day,
                                        summer_end_month, summer_end_day, peak_start_hour, peak_end_hour, supply_monthly_charge, t_and_d_monthly_charge) 
        
      # get variables for time of day and year
      ms = summer_start_month
      ds = summer_start_day
      mf = summer_end_month
      df = summer_end_day
      ps = peak_start_hour
      pf = peak_end_hour
      psh = ps.truncate
      pfh = pf.truncate
      psm = ((ps - ps.truncate) * 60).truncate
      pfm = ((pf - pf.truncate) * 60).truncate

      # make type limits object
      new_object_string = "
      ScheduleTypeLimits,
        number, !- Name
        0,                                      !- Lower Limit Value {BasedOnField A3}
        4,                                      !- Upper Limit Value {BasedOnField A3}
        DISCRETE;                               !- Numeric Type
        "
      type_limits = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get

      # make two season schedule
      if (ms + ds / 100.0 < mf + ds / 100.0)
        new_object_string = "
      Schedule:Compact,
        TwoSeasonSchedule,                      !- Name
        number,                                 !- Schedule Type Limits Name
        Through: #{ms}/#{ds},                   !- Field 1
        For: AllDays,                           !- Field 2
        Until: 24:00,                           !- Field 3
        1,                                      !- Field 4
        Through: #{mf}/#{df},                   !- Field 5
        For: AllDays,                           !- Field 6
        Until: 24:00,                           !- Field 7
        3,                                      !- Field 8
        Through: 12/31,                         !- Field 9
        For: AllDays,                           !- Field 10
        Until: 24:00,                           !- Field 11
        1;
        "
      else
        new_object_string = "
      Schedule:Compact,
        TwoSeasonSchedule,                      !- Name
        number,                                 !- Schedule Type Limits Name
        Through: #{mf}/#{df},                   !- Field 1
        For: AllDays,                           !- Field 2
        Until: 24:00,                           !- Field 3
        3,                                      !- Field 4
        Through: #{ms}/#{ds},                   !- Field 5
        For: AllDays,                           !- Field 6
        Until: 24:00,                           !- Field 7
        1,                                      !- Field 8
        Through: 12/31,                         !- Field 9
        For: AllDays,                           !- Field 10
        Until: 24:00,                           !- Field 11
        3;
        "
      end
      two_season_schedule = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get

      # make time of day schedule
      if psh + psm / 100.0 < pfh + pfm / 100.0
        new_object_string = "
        Schedule:Compact,
          TimeOfDaySchedule,                      !- Name
          number,                                 !- Schedule Type Limits Name
          Through: 12/31,                         !- Field 1
          For: AllDays,                           !- Field 2
          Until: #{psh}:#{psm},                   !- Field 3
          3,                                      !- Field 4
          Until: #{pfh}:#{pfm},                   !- Field 5
          1,                                      !- Field 6
          Until: 24:00,                           !- Field 7
          3;                                      !- Field 8
        "
      else
        new_object_string = "
        Schedule:Compact,
          TimeOfDaySchedule,                      !- Name
          number,                                 !- Schedule Type Limits Name
          Through: 12/31,                         !- Field 1
          For: AllDays,                           !- Field 2
          Until: #{pfh}:#{pfm},                   !- Field 3
          1,                                      !- Field 4
          Until: #{psh}:#{psm},                   !- Field 5
          3,                                      !- Field 6
          Until: 24:00,                           !- Field 7
          1;                                      !- Field 8
        "
      end
      time_of_day_schedule = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get

      # electric tariff object
      new_object_string = "
      UtilityCost:Tariff,
        #{tariff_name},                                                  !- Name
        ElectricityPurchased:Facility,                                   !- Output Meter Name
        kWh,                                                             !- Conversion Factor Choice
        ,                                                                !- Energy Conversion Factor
        ,                                                                !- Demand Conversion Factor
        #{time_of_day_schedule.getString(0)},                            !- Time of Use Period Schedule Name
        #{two_season_schedule.getString(0)},                             !- Season Schedule Name
        ,                                                                !- Month Schedule Name
        #{demand_window_length},                                         !- Demand Window Length
        #{supply_monthly_charge + t_and_d_monthly_charge};               !- Monthly Charge or Variable Name
        "
      electric_tariff = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      
    end    

    def add_supply_tariff_objects(workspace, runner, tariff_name, supply_elec_rate_sum_peak, supply_elec_rate_sum_nonpeak, supply_elec_rate_nonsum_peak, 
                              supply_elec_rate_nonsum_nonpeak, supply_elec_demand_sum, supply_elec_demand_nonsum, supply_qualifying_min_monthly_demand,
                              supply_summer_elec_block_1_size, supply_summer_elec_block_1_cost_per_kwh, supply_summer_elec_block_2_size, 
                              supply_summer_elec_block_2_cost_per_kwh, supply_summer_elec_remaining_cost_per_kwh, supply_winter_elec_block_1_size,
                              supply_winter_elec_block_1_cost_per_kwh, supply_winter_elec_block_2_size, supply_winter_elec_block_2_cost_per_kwh,
                              supply_winter_elec_remaining_cost_per_kwh, supply_summer_elec_demand_block_1_size, supply_summer_elec_demand_block_1_cost_per_kw,
                              supply_summer_elec_demand_block_2_size, supply_summer_elec_demand_block_2_cost_per_kw, supply_summer_elec_remaining_cost_per_kw, 
                              supply_winter_elec_demand_block_1_size, supply_winter_elec_demand_block_1_cost_per_kw, supply_winter_elec_demand_block_2_size, 
                              supply_winter_elec_demand_block_2_cost_per_kw, supply_winter_elec_remaining_cost_per_kw)
          

      # make UtilityCost:Charge:Simple objects for Supply Electricity Summer OnPeak Energy Charges
      if (supply_elec_rate_sum_peak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          SupplyElectricityTariffSummerOnPeakEnergyCharge,        !- Name
          #{tariff_name},                                   !- Tariff Name
          peakEnergy,                                       !- Source Variable
          summer,                                           !- Season
          EnergyCharges,                                    !- Category Variable Name
          #{supply_elec_rate_sum_peak};                     !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_sum_peak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple objects for Supply Electricity Summer OffPeak Energy Charges
      if (supply_elec_rate_sum_nonpeak > 0)
      new_object_string = "
      UtilityCost:Charge:Simple,
        SupplyElectricityTariffSummerOffPeakEnergyCharge,          !- Name
        #{tariff_name},                                      !- Tariff Name
        offPeakEnergy,                                       !- Source Variable
        summer,                                              !- Season
        EnergyCharges,                                       !- Category Variable Name
        #{supply_elec_rate_sum_nonpeak};                     !- Cost per Unit Value or Variable Name
        "
      elec_utility_cost_sum_nonpeak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple objects for Supply Electricity Winter OnPeak Energy Charges
      if (supply_elec_rate_nonsum_peak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          SupplyElectricityTariffWinterOnPeakEnergyCharge,           !- Name
          #{tariff_name},                                      !- Tariff Name
          peakEnergy,                                          !- Source Variable
          winter,                                              !- Season
          EnergyCharges,                                       !- Category Variable Name
          #{supply_elec_rate_nonsum_peak};                     !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_peak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple objects for Supply Electricity Winter OffPeak Energy Charges
      if (supply_elec_rate_nonsum_nonpeak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
        SupplyElectricityTariffWinterOffPeakEnergyCharge,            !- Name
          #{tariff_name},                                        !- Tariff Name
          offPeakEnergy,                                         !- Source Variable
          winter,                                                !- Season
          EnergyCharges,                                         !- Category Variable Name
          #{supply_elec_rate_nonsum_nonpeak};                    !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_nonpeak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple objects for Supply Electricity Summer Demand Charges
      if (supply_elec_demand_sum > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
        SupplyElectricityTariffSummerDemandCharge,    !- Name
          #{tariff_name},                         !- Tariff Name
          totalDemand,                            !- Source Variable
          summer,                                 !- Season
          DemandCharges,                          !- Category Variable Name
          #{supply_elec_demand_sum};              !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_sum_demand = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple objects for Supply Electricity Winter Demand Charges
      if (supply_elec_demand_nonsum > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          SupplyElectricityTariffWinterDemandCharge,           !- Name
          #{tariff_name},                                !- Tariff Name
          totalDemand,                                   !- Source Variable
          winter,                                        !- Season
          DemandCharges,                                 !- Category Variable Name
          #{supply_elec_demand_nonsum};                  !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_demand = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Qualify objects for Supply Electricity Demand Charges
      if (supply_qualifying_min_monthly_demand > 0)
        new_object_string = "
        UtilityCost:Qualify,
            SupplyMinDemand,                                    ! Name
            #{tariff_name},                               ! Tariff Name
            TotalDemand,                                  ! Variable Name
            Minimum,                                      ! Qualify Type
            #{supply_qualifying_min_monthly_demand},      ! Threshold Value or Variable Name
            Annual,                                       ! Season
            Count,                                        ! Threshold Test
            1;                                            ! Number of Months      
            "
          
        utilitycost_qualify = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block objects for Supply Summer Electricity Charges
      if (supply_summer_elec_block_1_cost_per_kwh > 0) || (supply_summer_elec_block_2_cost_per_kwh > 0) || (supply_summer_elec_remaining_cost_per_kwh > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          SupplySummerBlockEnergyCharge,                        ! Charge Variable Name
           #{tariff_name},                                ! Tariff Name
          totalEnergy,                                    ! Source Variable
          Summer,                                         ! Season
          EnergyCharges,                                  ! Category Variable Name
          ,                                               ! Remaining Into Variable
          ,                                               ! Block Size Multiplier Value or Variable Name
          #{supply_summer_elec_block_1_size},             ! Block Size 1 Value or Variable Name
          #{supply_summer_elec_block_1_cost_per_kwh},     ! Block 1 Cost per Unit Value or Variable Name
          #{supply_summer_elec_block_2_size},             ! Block Size 2 Value or Variable Name
          #{supply_summer_elec_block_2_cost_per_kwh},     ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                      ! Block Size 3 Value or Variable Name
          #{supply_summer_elec_remaining_cost_per_kwh};   ! Block 3 Cost per Unit Value or Variable Name
          "
          
          supply_summer_elec_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block objects for Supply Winter Electricity Charges
      if (supply_winter_elec_block_1_cost_per_kwh > 0) || (supply_winter_elec_block_2_cost_per_kwh > 0) || (supply_winter_elec_remaining_cost_per_kwh > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          SupplyWinterBlockEnergyCharge,                        ! Charge Variable Name
           #{tariff_name},                                ! Tariff Name
          totalEnergy,                                    ! Source Variable
          Winter,                                         ! Season
          EnergyCharges,                                  ! Category Variable Name
          ,                                               ! Remaining Into Variable
          ,                                               ! Block Size Multiplier Value or Variable Name
          #{supply_winter_elec_block_1_size},             ! Block Size 1 Value or Variable Name
          #{supply_winter_elec_block_1_cost_per_kwh},     ! Block 1 Cost per Unit Value or Variable Name
          #{supply_winter_elec_block_2_size},             ! Block Size 2 Value or Variable Name
          #{supply_winter_elec_block_2_cost_per_kwh},     ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                      ! Block Size 3 Value or Variable Name
          #{supply_winter_elec_remaining_cost_per_kwh};   ! Block 3 Cost per Unit Value or Variable Name
          "
          
          supply_winter_elec_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block objects for Supply Summer Electricity Demand Charges
      if (supply_summer_elec_demand_block_1_cost_per_kw > 0) || (supply_summer_elec_demand_block_2_cost_per_kw > 0) || (supply_summer_elec_remaining_cost_per_kw > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          SupplySummerBlockDemandEnergyCharge,                      ! Charge Variable Name
           #{tariff_name},                                    ! Tariff Name
          totalDemand,                                        ! Source Variable
          Summer,                                             ! Season
          DemandCharges,                                      ! Category Variable Name
          ,                                                   ! Remaining Into Variable
          ,                                                   ! Block Size Multiplier Value or Variable Name
          #{supply_summer_elec_demand_block_1_size},          ! Block Size 1 Value or Variable Name
          #{supply_summer_elec_demand_block_1_cost_per_kw},   ! Block 1 Cost per Unit Value or Variable Name
          #{supply_summer_elec_demand_block_2_size},          ! Block Size 2 Value or Variable Name
          #{supply_summer_elec_demand_block_2_cost_per_kw},   ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                          ! Block Size 3 Value or Variable Name
          #{supply_summer_elec_remaining_cost_per_kw};        ! Block 3 Cost per Unit Value or Variable Name
          "
          
          supply_summer_elec_demand_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block objects for Supply Winter Electricity Demand Charges
      if (supply_winter_elec_demand_block_1_cost_per_kw > 0) || (supply_winter_elec_demand_block_2_cost_per_kw > 0) || (supply_winter_elec_remaining_cost_per_kw > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          SupplyWinterBlockDemandEnergyCharge,                      ! Charge Variable Name
           #{tariff_name},                                    ! Tariff Name
          totalDemand,                                        ! Source Variable
          Winter,                                             ! Season
          DemandCharges,                                      ! Category Variable Name
          ,                                                   ! Remaining Into Variable
          ,                                                   ! Block Size Multiplier Value or Variable Name
          #{supply_winter_elec_demand_block_1_size},          ! Block Size 1 Value or Variable Name
          #{supply_winter_elec_demand_block_1_cost_per_kw},   ! Block 1 Cost per Unit Value or Variable Name
          #{supply_winter_elec_demand_block_2_size},          ! Block Size 2 Value or Variable Name
          #{supply_winter_elec_demand_block_2_cost_per_kw},   ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                          ! Block Size 3 Value or Variable Name
          #{supply_winter_elec_remaining_cost_per_kw};        ! Block 3 Cost per Unit Value or Variable Name
          "
          
          supply_summer_elec_demand_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end 
    end # add_supply_tariff_objects method

    def add_t_and_d_tariff_objects(workspace, runner, tariff_name, t_and_d_elec_rate_sum_peak, t_and_d_elec_rate_sum_nonpeak, t_and_d_elec_rate_nonsum_peak, 
                                  t_and_d_elec_rate_nonsum_nonpeak, t_and_d_elec_demand_sum, t_and_d_elec_demand_nonsum, t_and_d_qualifying_min_monthly_demand,
                                  t_and_d_summer_elec_block_1_size, t_and_d_summer_elec_block_1_cost_per_kwh, t_and_d_summer_elec_block_2_size, 
                                  t_and_d_summer_elec_block_2_cost_per_kwh, t_and_d_summer_elec_remaining_cost_per_kwh, t_and_d_winter_elec_block_1_size,
                                  t_and_d_winter_elec_block_1_cost_per_kwh, t_and_d_winter_elec_block_2_size, t_and_d_winter_elec_block_2_cost_per_kwh,
                                  t_and_d_winter_elec_remaining_cost_per_kwh, t_and_d_summer_elec_demand_block_1_size, t_and_d_summer_elec_demand_block_1_cost_per_kw,
                                  t_and_d_summer_elec_demand_block_2_size, t_and_d_summer_elec_demand_block_2_cost_per_kw, t_and_d_summer_elec_remaining_cost_per_kw, 
                                  t_and_d_winter_elec_demand_block_1_size, t_and_d_winter_elec_demand_block_1_cost_per_kw, t_and_d_winter_elec_demand_block_2_size, 
                                  t_and_d_winter_elec_demand_block_2_cost_per_kw, t_and_d_winter_elec_remaining_cost_per_kw)
     

      # make UtilityCost:Charge:Simple object for T and D Summer Peak Energy Charges
      if (t_and_d_elec_rate_sum_peak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffSummerOnPeakEnergyCharge, !- Name
          #{tariff_name},                         !- Tariff Name
          peakEnergy,                             !- Source Variable
          summer,                                 !- Season
          EnergyCharges,                          !- Category Variable Name
          #{t_and_d_elec_rate_sum_peak};                  !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_sum_peak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple object for T and D Summer OffPeak Energy Charges
      if (t_and_d_elec_rate_sum_nonpeak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffSummerOffPeakEnergyCharge, !- Name
          #{tariff_name},                          !- Tariff Name
          offPeakEnergy,                          !- Source Variable
          summer,                                 !- Season
          EnergyCharges,                          !- Category Variable Name
          #{t_and_d_elec_rate_sum_nonpeak};               !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_sum_nonpeak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple object for T and D Winter Peak Energy Charges
      if (t_and_d_elec_rate_nonsum_peak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffWinterOnPeakEnergyCharge, !- Name
          #{tariff_name},                            !- Tariff Name
          peakEnergy,                                !- Source Variable
          winter,                                    !- Season
          EnergyCharges,                             !- Category Variable Name
          #{t_and_d_elec_rate_nonsum_peak};                  !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_peak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple object for T and D Winter OffPeak Energy Charges
      if (t_and_d_elec_rate_nonsum_nonpeak > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffWinterOffPeakEnergyCharge, !- Name
          #{tariff_name},                             !- Tariff Name
          offPeakEnergy,                              !- Source Variable
          winter,                                     !- Season
          EnergyCharges,                              !- Category Variable Name
          #{t_and_d_elec_rate_nonsum_nonpeak};                !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_nonpeak = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple object for T and D Summer Demand Charges
      if (t_and_d_elec_demand_sum > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffSummerDemandCharge,    !- Name
          #{tariff_name},                         !- Tariff Name
          totalDemand,                            !- Source Variable
          summer,                                 !- Season
          DemandCharges,                          !- Category Variable Name
          #{t_and_d_elec_demand_sum};          !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_sum_demand = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Simple object for T and D Winter Demand Charges
      if (t_and_d_elec_demand_nonsum > 0)
        new_object_string = "
        UtilityCost:Charge:Simple,
          T_and_D_ElectricityTariffWinterDemandCharge,    !- Name
          #{tariff_name},                         !- Tariff Name
          totalDemand,                            !- Source Variable
          winter,                                 !- Season
          DemandCharges,                          !- Category Variable Name
          #{t_and_d_elec_demand_nonsum};                  !- Cost per Unit Value or Variable Name
          "
        elec_utility_cost_nonsum_demand = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Qualifying object for T and D Qualifying Demand Charges
      if (t_and_d_qualifying_min_monthly_demand > 0)
        new_object_string = "
        UtilityCost:Qualify,
            T_and_D_MinDemand,                        ! Name
            #{tariff_name},                   ! Tariff Name
            TotalDemand,                      ! Variable Name
            Minimum,                          ! Qualify Type
            #{t_and_d_qualifying_min_monthly_demand}, ! Threshold Value or Variable Name
            Annual,                           ! Season
            Count,                            ! Threshold Test
            1;                                ! Number of Months      
            "
          
          utilitycost_qualify = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block object for T and D Summer Electricity Charges
      if (t_and_d_summer_elec_block_1_cost_per_kwh > 0) || (t_and_d_summer_elec_block_2_cost_per_kwh > 0) || (t_and_d_summer_elec_remaining_cost_per_kwh > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          T_and_D_SummerBlockEnergyCharge,                        ! Charge Variable Name
           #{tariff_name},                                ! Tariff Name
          totalEnergy,                                    ! Source Variable
          Summer,                                         ! Season
          EnergyCharges,                                  ! Category Variable Name
          ,                                               ! Remaining Into Variable
          ,                                               ! Block Size Multiplier Value or Variable Name
          #{t_and_d_summer_elec_block_1_size},             ! Block Size 1 Value or Variable Name
          #{t_and_d_summer_elec_block_1_cost_per_kwh},     ! Block 1 Cost per Unit Value or Variable Name
          #{t_and_d_summer_elec_block_2_size},             ! Block Size 2 Value or Variable Name
          #{t_and_d_summer_elec_block_2_cost_per_kwh},     ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                      ! Block Size 3 Value or Variable Name
          #{t_and_d_summer_elec_remaining_cost_per_kwh};   ! Block 3 Cost per Unit Value or Variable Name
          "
          
          t_and_d_summer_elec_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block object for T and D Winter Electricity Charges
      if (t_and_d_summer_elec_demand_block_1_cost_per_kw > 0) || (t_and_d_summer_elec_demand_block_2_cost_per_kw > 0) || (t_and_d_summer_elec_remaining_cost_per_kw > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          T_and_D_WinterBlockEnergyCharge,                        ! Charge Variable Name
           #{tariff_name},                                ! Tariff Name
          totalEnergy,                                    ! Source Variable
          Winter,                                         ! Season
          EnergyCharges,                                  ! Category Variable Name
          ,                                               ! Remaining Into Variable
          ,                                               ! Block Size Multiplier Value or Variable Name
          #{t_and_d_winter_elec_block_1_size},             ! Block Size 1 Value or Variable Name
          #{t_and_d_winter_elec_block_1_cost_per_kwh},     ! Block 1 Cost per Unit Value or Variable Name
          #{t_and_d_winter_elec_block_2_size},             ! Block Size 2 Value or Variable Name
          #{t_and_d_winter_elec_block_2_cost_per_kwh},     ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                      ! Block Size 3 Value or Variable Name
          #{t_and_d_winter_elec_remaining_cost_per_kwh};   ! Block 3 Cost per Unit Value or Variable Name
          "
          
          t_and_d_winter_elec_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block object for T and D Summer Demand Charges
      if (t_and_d_summer_elec_demand_block_1_cost_per_kw > 0) || (t_and_d_summer_elec_demand_block_2_cost_per_kw > 0) || (t_and_d_summer_elec_remaining_cost_per_kw > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          T_and_D_SummerBlockDemandEnergyCharge,                      ! Charge Variable Name
           #{tariff_name},                                    ! Tariff Name
          totalDemand,                                        ! Source Variable
          Summer,                                             ! Season
          DemandCharges,                                      ! Category Variable Name
          ,                                                   ! Remaining Into Variable
          ,                                                   ! Block Size Multiplier Value or Variable Name
          #{t_and_d_summer_elec_demand_block_1_size},          ! Block Size 1 Value or Variable Name
          #{t_and_d_summer_elec_demand_block_1_cost_per_kw},   ! Block 1 Cost per Unit Value or Variable Name
          #{t_and_d_summer_elec_demand_block_2_size},          ! Block Size 2 Value or Variable Name
          #{t_and_d_summer_elec_demand_block_2_cost_per_kw},   ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                          ! Block Size 3 Value or Variable Name
          #{t_and_d_summer_elec_remaining_cost_per_kw};        ! Block 3 Cost per Unit Value or Variable Name
          "
          
          t_and_d_summer_elec_demand_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end
      
      # make UtilityCost:Charge:Block object for T and D Winter Electricity Demand Charges
      if (t_and_d_winter_elec_demand_block_1_cost_per_kw > 0) || (t_and_d_winter_elec_demand_block_2_cost_per_kw > 0) || (t_and_d_winter_elec_remaining_cost_per_kw > 0) 
        new_object_string = "
        UtilityCost:Charge:Block,
          T_and_D_WinterBlockDemandEnergyCharge,                      ! Charge Variable Name
           #{tariff_name},                                    ! Tariff Name
          totalDemand,                                        ! Source Variable
          Winter,                                             ! Season
          DemandCharges,                                      ! Category Variable Name
          ,                                                   ! Remaining Into Variable
          ,                                                   ! Block Size Multiplier Value or Variable Name
          #{t_and_d_winter_elec_demand_block_1_size},          ! Block Size 1 Value or Variable Name
          #{t_and_d_winter_elec_demand_block_1_cost_per_kw},   ! Block 1 Cost per Unit Value or Variable Name
          #{t_and_d_winter_elec_demand_block_2_size},          ! Block Size 2 Value or Variable Name
          #{t_and_d_winter_elec_demand_block_2_cost_per_kw},   ! Block 2 Cost per Unit Value or Variable Name
          remaining,                                          ! Block Size 3 Value or Variable Name
          #{t_and_d_winter_elec_remaining_cost_per_kw};        ! Block 3 Cost per Unit Value or Variable Name
          "
          
          t_and_d_summer_elec_demand_utilitycost_charge_block = workspace.addObject(OpenStudio::IdfObject.load(new_object_string).get).get
      end  
    end # add_supply_tariff_objects method
    
    # reporting initial condition of model
    starting_tariffs = workspace.getObjectsByType('UtilityCost:Tariff'.to_IddObjectType)
    runner.registerInitialCondition("The model started with #{starting_tariffs.size} tariff objects.")

    # declare variables for proper scope
    tariff_name = nil
    demand_window_length = nil
    summer_start_month = nil
    summer_start_day = nil
    summer_end_month = nil
    summer_end_day = nil
    peak_start_hour = nil
    peak_end_hour = nil
    
    supply_elec_rate_sum_peak = nil
    supply_elec_rate_sum_nonpeak = nil
    supply_elec_rate_nonsum_peak = nil
    supply_elec_rate_nonsum_nonpeak = nil
    supply_elec_demand_sum = nil
    supply_elec_demand_nonsum = nil
    supply_monthly_charge = nil
    supply_qualifying_min_monthly_demand = nil
    supply_summer_elec_block_1_size = nil
    supply_summer_elec_block_1_cost_per_kwh = nil
    supply_summer_elec_block_2_size = nil
    supply_summer_elec_block_2_cost_per_kwh = nil
    supply_summer_elec_remaining_cost_per_kwh = nil
    supply_winter_elec_block_1_size = nil
    supply_winter_elec_block_1_cost_per_kwh = nil
    supply_winter_elec_block_2_size = nil
    supply_winter_elec_block_2_cost_per_kwh = nil
    supply_winter_elec_remaining_cost_per_kwh = nil
    supply_summer_elec_demand_block_1_size = nil
    supply_summer_elec_demand_block_1_cost_per_kw = nil
    supply_summer_elec_demand_block_2_size = nil
    supply_summer_elec_demand_block_2_cost_per_kw = nil
    supply_summer_elec_remaining_cost_per_kw = nil
    supply_winter_elec_demand_block_1_size = nil
    supply_winter_elec_demand_block_1_cost_per_kw = nil
    supply_winter_elec_demand_block_2_size = nil
    supply_winter_elec_demand_block_2_cost_per_kw = nil
    supply_winter_elec_remaining_cost_per_kw = nil

    t_and_d_elec_rate_sum_peak = nil
    t_and_d_elec_rate_sum_nonpeak = nil
    t_and_d_elec_rate_nonsum_peak = nil
    t_and_d_elec_rate_nonsum_nonpeak = nil
    t_and_d_elec_demand_sum = nil
    t_and_d_elec_demand_nonsum = nil
    t_and_d_monthly_charge = nil
    t_and_d_qualifying_min_monthly_demand = nil
    t_and_d_summer_elec_block_1_size = nil
    t_and_d_summer_elec_block_1_cost_per_kwh = nil
    t_and_d_summer_elec_block_2_size = nil
    t_and_d_summer_elec_block_2_cost_per_kwh = nil
    t_and_d_summer_elec_remaining_cost_per_kwh = nil
    t_and_d_winter_elec_block_1_size = nil
    t_and_d_winter_elec_block_1_cost_per_kwh = nil
    t_and_d_winter_elec_block_2_size = nil
    t_and_d_winter_elec_block_2_cost_per_kwh = nil
    t_and_d_winter_elec_remaining_cost_per_kwh = nil
    t_and_d_summer_elec_demand_block_1_size = nil
    t_and_d_summer_elec_demand_block_1_cost_per_kw = nil
    t_and_d_summer_elec_demand_block_2_size = nil
    t_and_d_summer_elec_demand_block_2_cost_per_kw = nil
    t_and_d_summer_elec_remaining_cost_per_kw = nil
    t_and_d_winter_elec_demand_block_1_size = nil
    t_and_d_winter_elec_demand_block_1_cost_per_kw = nil
    t_and_d_winter_elec_demand_block_2_size = nil
    t_and_d_winter_elec_demand_block_2_cost_per_kw = nil
    t_and_d_winter_elec_remaining_cost_per_kw = nil
    
    # note -hard code the column number to read the values in the csv file from 
    column = 1
    
    # Load parameters needed to create electric utility tariff
    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "Electric_Utility_Tariff_Arguments.csv"))), headers: true) do |row|
      
      tariff_name = row[column].to_s if (row[0] == "tariff_name")
      demand_window_length = row[column].to_s if (row[0] == "demand_window_length")
      summer_start_month = row[column].to_i if (row[0] == "summer_start_month")
      summer_start_day = row[column].to_i if (row[0] == "summer_start_day")
      summer_end_month = row[column].to_i if (row[0] == "summer_end_month")
      summer_end_day = row[column].to_i if (row[0] == "summer_end_day")
      peak_start_hour = row[column].to_i if (row[0] == "peak_start_hour")
      peak_end_hour = row[column].to_i if (row[0] == "peak_end_hour")
      supply_elec_rate_sum_peak = row[column].to_f if (row[0] == "supply_elec_rate_sum_peak")
      supply_elec_rate_sum_nonpeak = row[column].to_f if (row[0] == "supply_elec_rate_sum_nonpeak")
      supply_elec_rate_nonsum_peak = row[column].to_f if (row[0] == "supply_elec_rate_nonsum_peak")
      supply_elec_rate_nonsum_nonpeak = row[column].to_f if (row[0] == "supply_elec_rate_nonsum_nonpeak")
      supply_elec_demand_sum = row[column].to_f if (row[0] == "supply_elec_demand_sum")
      supply_elec_demand_nonsum = row[column].to_f if (row[0] == "supply_elec_demand_nonsum")
      supply_monthly_charge = row[column].to_f if (row[0] == "supply_monthly_charge")
      supply_qualifying_min_monthly_demand = row[column].to_f if (row[0] == "supply_qualifying_min_monthly_demand")
      supply_summer_elec_block_1_size = row[column].to_f if (row[0] == "supply_summer_elec_block_1_size")
      supply_summer_elec_block_1_cost_per_kwh = row[column].to_f if (row[0] == "supply_summer_elec_block_1_cost_per_kwh")
      supply_summer_elec_block_2_size = row[column].to_f if (row[0] == "supply_summer_elec_block_2_size")
      supply_summer_elec_block_2_cost_per_kwh = row[column].to_f if (row[0] == "supply_summer_elec_block_2_cost_per_kwh")
      supply_summer_elec_remaining_cost_per_kwh = row[column].to_f if (row[0] == "supply_summer_elec_remaining_cost_per_kwh")
      supply_winter_elec_block_1_size = row[column].to_f if (row[0] == "supply_winter_elec_block_1_size")
      supply_winter_elec_block_1_cost_per_kwh = row[column].to_f if (row[0] == "supply_winter_elec_block_1_cost_per_kwh")
      supply_winter_elec_block_2_size = row[column].to_f if (row[0] == "supply_winter_elec_block_2_size")
      supply_winter_elec_block_2_cost_per_kwh = row[column].to_f if (row[0] == "supply_winter_elec_block_2_cost_per_kwh")
      supply_winter_elec_remaining_cost_per_kwh = row[column].to_f if (row[0] == "supply_winter_elec_remaining_cost_per_kwh")
      supply_summer_elec_demand_block_1_size = row[column].to_f if (row[0] == "supply_summer_elec_demand_block_1_size")
      supply_summer_elec_demand_block_1_cost_per_kw = row[column].to_f if (row[0] == "supply_summer_elec_demand_block_1_cost_per_kw")
      supply_summer_elec_demand_block_2_size = row[column].to_f if (row[0] == "supply_summer_elec_demand_block_2_size")
      supply_summer_elec_remaining_cost_per_kw = row[column].to_f if (row[0] == "supply_summer_elec_remaining_cost_per_kw")
      supply_winter_elec_demand_block_1_size = row[column].to_f if (row[0] == "supply_winter_elec_demand_block_1_size")
      supply_winter_elec_demand_block_1_cost_per_kw = row[column].to_f if (row[0] == "supply_winter_elec_demand_block_1_cost_per_kw")
      supply_winter_elec_demand_block_2_size = row[column].to_f if (row[0] == "supply_winter_elec_demand_block_2_size")
      supply_winter_elec_demand_block_2_cost_per_kw = row[column].to_f if (row[0] == "supply_winter_elec_demand_block_2_cost_per_kw")
      supply_winter_elec_remaining_cost_per_kw = row[column].to_f if (row[0] == "supply_winter_elec_remaining_cost_per_kw")

      t_and_d_elec_rate_sum_peak = row[column].to_f if (row[0] == "t_and_d_elec_rate_sum_peak")
      t_and_d_elec_rate_sum_nonpeak = row[column].to_f if (row[0] == "t_and_d_elec_rate_sum_nonpeak")
      t_and_d_elec_rate_nonsum_peak = row[column].to_f if (row[0] == "t_and_d_elec_rate_nonsum_peak")
      t_and_d_elec_rate_nonsum_nonpeak = row[column].to_f if (row[0] == "t_and_d_elec_rate_nonsum_nonpeak")
      t_and_d_elec_demand_sum = row[column].to_f if (row[0] == "t_and_d_elec_demand_sum")
      t_and_d_elec_demand_nonsum = row[column].to_f if (row[0] == "t_and_d_elec_demand_nonsum")
      t_and_d_monthly_charge = row[column].to_f if (row[0] == "t_and_d_monthly_charge")
      t_and_d_qualifying_min_monthly_demand = row[column].to_f if (row[0] == "t_and_d_qualifying_min_monthly_demand")
      t_and_d_summer_elec_block_1_size = row[column].to_f if (row[0] == "t_and_d_summer_elec_block_1_size")
      t_and_d_summer_elec_block_1_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_summer_elec_block_1_cost_per_kwh")
      t_and_d_summer_elec_block_2_size = row[column].to_f if (row[0] == "t_and_d_summer_elec_block_2_size")
      t_and_d_summer_elec_block_2_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_summer_elec_block_2_cost_per_kwh")
      t_and_d_summer_elec_remaining_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_summer_elec_remaining_cost_per_kwh")
      t_and_d_winter_elec_block_1_size = row[column].to_f if (row[0] == "t_and_d_winter_elec_block_1_size")
      t_and_d_winter_elec_block_1_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_winter_elec_block_1_cost_per_kwh")
      t_and_d_winter_elec_block_2_size = row[column].to_f if (row[0] == "t_and_d_winter_elec_block_2_size")
      t_and_d_winter_elec_block_2_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_winter_elec_block_2_cost_per_kwh")
      t_and_d_winter_elec_remaining_cost_per_kwh = row[column].to_f if (row[0] == "t_and_d_winter_elec_remaining_cost_per_kwh")
      t_and_d_summer_elec_demand_block_1_size = row[column].to_f if (row[0] == "t_and_d_summer_elec_demand_block_1_size")
      t_and_d_summer_elec_demand_block_1_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_summer_elec_demand_block_1_cost_per_kw")
      t_and_d_summer_elec_demand_block_2_size = row[column].to_f if (row[0] == "t_and_d_summer_elec_demand_block_2_size")
      t_and_d_summer_elec_demand_block_2_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_summer_elec_demand_block_2_cost_per_kw")
      t_and_d_summer_elec_remaining_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_summer_elec_remaining_cost_per_kw")
      t_and_d_winter_elec_demand_block_1_size = row[column].to_f if (row[0] == "t_and_d_winter_elec_demand_block_1_size")
      t_and_d_winter_elec_demand_block_1_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_winter_elec_demand_block_1_cost_per_kw")
      t_and_d_winter_elec_demand_block_2_size = row[column].to_f if (row[0] == "t_and_d_winter_elec_demand_block_2_size")
      t_and_d_winter_elec_demand_block_2_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_winter_elec_demand_block_2_cost_per_kw")
      t_and_d_winter_elec_remaining_cost_per_kw = row[column].to_f if (row[0] == "t_and_d_winter_elec_remaining_cost_per_kw")

    end

    # add demand window and timestep object 
    add_demand_window_and_timetep(workspace, runner, demand_window_length)

    # add tariff object and add schedules for time of use and peak/off peak season seasons
    add_tariff_object_and_schedules(workspace, runner, tariff_name, demand_window_length, summer_start_month, summer_start_day, summer_end_month, 
                                    summer_end_day, peak_start_hour, peak_end_hour, supply_monthly_charge, t_and_d_monthly_charge)

    if (supply_elec_rate_sum_peak.abs + supply_elec_rate_sum_nonpeak.abs + supply_elec_rate_nonsum_peak + supply_elec_rate_nonsum_nonpeak.abs + supply_elec_demand_sum.abs + supply_elec_demand_nonsum.abs > 0)

      # add electric tariff for electricity supply 
      add_supply_tariff_objects(workspace, runner, tariff_name, supply_elec_rate_sum_peak, supply_elec_rate_sum_nonpeak, supply_elec_rate_nonsum_peak, 
                                supply_elec_rate_nonsum_nonpeak, supply_elec_demand_sum, supply_elec_demand_nonsum, supply_qualifying_min_monthly_demand,
                                supply_summer_elec_block_1_size, supply_summer_elec_block_1_cost_per_kwh, supply_summer_elec_block_2_size, 
                                supply_summer_elec_block_2_cost_per_kwh, supply_summer_elec_remaining_cost_per_kwh, supply_winter_elec_block_1_size,
                                supply_winter_elec_block_1_cost_per_kwh, supply_winter_elec_block_2_size, supply_winter_elec_block_2_cost_per_kwh,
                                supply_winter_elec_remaining_cost_per_kwh, supply_summer_elec_demand_block_1_size, supply_summer_elec_demand_block_1_cost_per_kw,
                                supply_summer_elec_demand_block_2_size, supply_summer_elec_demand_block_2_cost_per_kw, supply_summer_elec_remaining_cost_per_kw, 
                                supply_winter_elec_demand_block_1_size, supply_winter_elec_demand_block_1_cost_per_kw, supply_winter_elec_demand_block_2_size, 
                                supply_winter_elec_demand_block_2_cost_per_kw, supply_winter_elec_remaining_cost_per_kw)

      runner.registerInfo("Added a Electric Tariff Object named #{tariff_name}")    
    
    end      
      
    if (t_and_d_elec_rate_sum_peak.abs + t_and_d_elec_rate_sum_nonpeak.abs + t_and_d_elec_rate_nonsum_peak + t_and_d_elec_rate_nonsum_nonpeak.abs + t_and_d_elec_demand_sum.abs + t_and_d_elec_demand_nonsum.abs > 0)
         
      add_t_and_d_tariff_objects(workspace, runner, tariff_name, t_and_d_elec_rate_sum_peak, t_and_d_elec_rate_sum_nonpeak, t_and_d_elec_rate_nonsum_peak,
                                  t_and_d_elec_rate_nonsum_nonpeak, t_and_d_elec_demand_sum, t_and_d_elec_demand_nonsum, t_and_d_qualifying_min_monthly_demand,
                                  t_and_d_summer_elec_block_1_size, t_and_d_summer_elec_block_1_cost_per_kwh, t_and_d_summer_elec_block_2_size, 
                                  t_and_d_summer_elec_block_2_cost_per_kwh, t_and_d_summer_elec_remaining_cost_per_kwh, t_and_d_winter_elec_block_1_size,
                                  t_and_d_winter_elec_block_1_cost_per_kwh, t_and_d_winter_elec_block_2_size, t_and_d_winter_elec_block_2_cost_per_kwh,
                                  t_and_d_winter_elec_remaining_cost_per_kwh, t_and_d_summer_elec_demand_block_1_size, t_and_d_summer_elec_demand_block_1_cost_per_kw,
                                  t_and_d_summer_elec_demand_block_2_size, t_and_d_summer_elec_demand_block_2_cost_per_kw, t_and_d_summer_elec_remaining_cost_per_kw, 
                                  t_and_d_winter_elec_demand_block_1_size, t_and_d_winter_elec_demand_block_1_cost_per_kw, t_and_d_winter_elec_demand_block_2_size, 
                                  t_and_d_winter_elec_demand_block_2_cost_per_kw, t_and_d_winter_elec_remaining_cost_per_kw)
    
    end
    # report final condition of model
    finishing_tariffs = workspace.getObjectsByType('UtilityCost:Tariff'.to_IddObjectType)
    runner.registerFinalCondition("The model finished with #{finishing_tariffs.size} tariff objects.")

    return true
  end # end run method 
end

# register the measure to be used by the application
RevitAnalyzeElectricTariff.new.registerWithApplication
