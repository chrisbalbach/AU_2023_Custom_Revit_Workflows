# insert your copyright here

# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/reference/measure_writing_guide/

require 'openstudio-standards'
# require 'rexml/document'
# require 'rexml/xpath'

# start the measure
class RevitAnalyzeAllElectricHVACSystems < OpenStudio::Measure::ModelMeasure
  # human readable name
  def name
    return "revit_analyze_all_electric_hvac_systems"
  end

  # human readable description
  def description
    return "lorum"
  end

  # human readable description of modeling approach
  def modeler_description
    return "ipsum"
  end

  def override_airloop_hvac_equipment_properties(model, runner, hvac_system_type, custom_properties, std)
    
    def change_electric_boiler_efficiency(model, runner)
      
      electric_boiler_efficiency = 1.0
      
      # change electric boiler efficiencies to 100%
      model.getBoilerHotWaters.each do |boilerHotWater| 
        if (boilerHotWater.fuelType == "Electricity")
          old_boiler_efficiency = boilerHotWater.nominalThermalEfficiency
          boilerHotWater.setNominalThermalEfficiency(electric_boiler_efficiency)
          runner.registerInfo("Changed Nominal Thermal Efficiency of Electric Hot Water Boiler named #{boilerHotWater.name} from #{old_boiler_efficiency.round(2)} to #{electric_boiler_efficiency.round(2)}.") 
        end
      end  
      model.getBoilerSteams.each do |boilerSteam| 
        if (boilerSteam.fuelType == "Electricity")
          old_boiler_efficiency = boilerSteam.theoreticalEfficiency
          boilerHotWater.setTheoreticalEfficiency(1.0)
          runner.registerInfo("Changed Theoretical Efficiency of Electric Steam Boiler named #{boilerSteam.name} from #{old_boiler_efficiency.round(2)} to #{electric_boiler_efficiency.round(2)}.") 
        end
      end  
    end
    
    # changes pump rated heat to a user specified override value
    def change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, rated_pump_head)
      
      pump = nil
      # ac_chiller_primary_loop_pump_rated_pump_head
      # change electric boiler efficiencies to 100%
      model.getChillerElectricEIRs.each do |chillerElectricEIR| 
        if (chillerElectricEIR.condenserType == "AirCooled") && (chillerElectricEIR.chilledWaterLoop.is_initialized)
          plantLoop = chillerElectricEIR.chilledWaterLoop.get
          plantLoop.demandComponents.each do |dc|
            if (dc.to_PumpConstantSpeed.is_initialized)
              pump = dc.to_PumpConstantSpeed.get
              pump.setRatedPumpHead(OpenStudio.convert(rated_pump_head,"ftH_{2}O","Pa"))  
              runner.registerInfo("For the Primary Chilled Water PlantLoop named #{plantLoop.name}, set the 'Rated Pump Head' of the Variable Speed Pump named #{pump.name} serving Air-Cooled Chiller named #{chillerElectricEIR.name} from #{OpenStudio.convert(old_pump_head,"Pa","ftH_{2}O").round(2)} ft of H2O to #{rated_pump_head.round(2)} ft of H2O.")
            elsif (dc.to_PumpVariableSpeed.is_initialized)
            	pump = dc.to_PumpConstantSpeed.get
              pump.setRatedPumpHead(OpenStudio.convert(rated_pump_head,"ftH_{2}O","Pa"))  
              runner.registerInfo("For the Primary Chilled Water PlantLoop named #{plantLoop.name}, set the 'Rated Pump Head' of the Constant Speed Pump named #{pump.name} serving Air-Cooled Chiller named #{chillerElectricEIR.name} from #{OpenStudio.convert(old_pump_head,"Pa","ftH_{2}O").round(2)} ft of H2O to #{rated_pump_head.round(2)} ft of H2O.")
            else
              # do nothing  
            end
          end
        end
      end  
    end
    
    def change_ac_chiller_reference_cop(model, runner, reference_cop)
      
      pump = nil
      # ac_chiller_primary_loop_pump_rated_pump_head
      # change electric boiler efficiencies to 100%
      model.getChillerElectricEIRs.each do |chillerElectricEIR| 
        if (chillerElectricEIR.condenserType == "AirCooled") && (chillerElectricEIR.chilledWaterLoop.is_initialized)
          old_chiller_cop = chillerElectricEIR.referenceCOP
          chiller.setReferenceCOP (rated_cop)
          runner.registerInfo("Based on user override values, for the Air Cooled Chiller named #{chillerElectricEIR.name}, set the 'Reference COP' from #{old_chiller_cop} to #{rated_cop}.")
        end
      end  
    end
    
     # changes vrf outdoor units rated htg cop at 47F to user specified override value
    def change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, rated_heating_cop)
      
      model.getAirConditionerVariableRefrigerantFlows.each do |airConditionerVariableRefrigerantFlow| 
        old_rated_htg_cop = airConditionerVariableRefrigerantFlow.ratedHeatingCOP
        runner.registerInfo("For the Outdoor VRF Unit named #{airConditionerVariableRefrigerantFlow.name}, set the 'Rated Htg COP at 47F' from #{old_rated_htg_cop.round(2)} to #{rated_heating_cop.round(2)}.")
        airConditionerVariableRefrigerantFlow.setRatedHeatingCOP(rated_heating_cop)
      end  
    end
    
     # changes vrf outdoor units rated clg EER to user specified override value
    def change_vrf_outdoor_unit_clg_eer(model, runner, rated_cooling_eer)
      
      model.getAirConditionerVariableRefrigerantFlows.each do |airConditionerVariableRefrigerantFlow| 
        old_rated_clg_cop = airConditionerVariableRefrigerantFlow.ratedCoolingCOP
        runner.registerInfo("For the Outdoor VRF Unit named #{airConditionerVariableRefrigerantFlow.name}, set the 'Rated Clg EER' from #{(old_rated_clg_cop * 3.412).round(2)} to #{(rated_cooling_eer/3.412).round(2)}.")
        airConditionerVariableRefrigerantFlow.setRatedCoolingCOP(rated_cooling_eer / 3.412)
      end  
    end
    
    
    # create HVAC system using methods in openstudio-standards
    # Standard.model_add_hvac_system(model, system_type, main_heat_fuel, zone_heat_fuel, cool_fuel, zones)
    # can be combination systems or individual objects - depends on the type of system
    # todo - reenable fan_coil_capacity_control_method when major installer released with udpated standards gem from what shipped with 2.9.0
    case hvac_system_type.to_s

    when 'VAV water-cooled chiller with electric boiler reheat'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS with DCV'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS with ERV'

      change_electric_boiler_efficiency(model, runner)                                        
    
    when 'VAV with air-cooled chiller with electric boiler reheat'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS with DCV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS with ERV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
    
    # PVAV systems by default use a DX coil for cooling
    when 'PVAV with electric boiler reheat'

      change_electric_boiler_efficiency(model, runner)                                        
    
    when 'PVAV with electric boiler reheat with DOAS'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'PVAV with electric boiler reheat with DOAS with DCV'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'PVAV with electric boiler reheat with DOAS with ERV'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'Heat Recovery VRF'

      if not (custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f == 0)
        change_vrf_outdoor_unit_clg_eer(model, runner, custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f)
      end

    when 'Heat Recovery VRF with ERV'

      if not (custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f == 0)
        change_vrf_outdoor_unit_clg_eer(model, runner, custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f)
      end

    when 'Heat Recovery VRF with DOAS'

      if not (custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f == 0)
        change_vrf_outdoor_unit_clg_eer(model, runner, custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f)
      end

    when 'Heat Recovery VRF with DOAS with DCV'

      if not (custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f == 0)
        change_vrf_outdoor_unit_clg_eer(model, runner, custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f)
      end

    when 'Heat Recovery VRF with DOAS with ERV'

      if not (custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f == 0)
        change_vrf_outdoor_unit_clg_eer(model, runner, custom_properties[:vrf_outdoor_unit_rated_clg_eer].to_f)
      end

    else
      runner.registerError("HVAC System #{hvac_system_type} not recognized")
      return false
    end # end case statement
    runner.registerInfo("Added HVAC System type #{hvac_system_type} to the model.")
   
  end # end method

  def override_zone_equipment_hvac_equipment_properties(model, runner, hvac_system_type, custom_properties, std)
    
    def change_electric_boiler_efficiency(model, runner)
      
      electric_boiler_efficiency = 1.0
      
      # change electric boiler efficiencies to 100%
      model.getBoilerHotWaters.each do |boilerHotWater| 
        if (boilerHotWater.fuelType == "Electricity")
          old_boiler_efficiency = boilerHotWater.nominalThermalEfficiency
          boilerHotWater.setNominalThermalEfficiency(electric_boiler_efficiency)
          runner.registerInfo("Changed Nominal Thermal Efficiency of Electric Hot Water Boiler named #{boilerHotWater.name} from #{old_boiler_efficiency.round(2)} to #{electric_boiler_efficiency.round(2)}.") 
        end
      end  
      model.getBoilerSteams.each do |boilerSteam| 
        if (boilerSteam.fuelType == "Electricity")
          old_boiler_efficiency = boilerSteam.theoreticalEfficiency
          boilerHotWater.setTheoreticalEfficiency(1.0)
          runner.registerInfo("Changed Theoretical Efficiency of Electric Steam Boiler named #{boilerSteam.name} from #{old_boiler_efficiency.round(2)} to #{electric_boiler_efficiency.round(2)}.") 
        end
      end  
    end
    
    # changes pump rated heat to a user specified override value
    def change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, rated_pump_head)
      
      pump = nil
      # ac_chiller_primary_loop_pump_rated_pump_head
      # change electric boiler efficiencies to 100%
      model.getChillerElectricEIRs.each do |chillerElectricEIR| 
        if (chillerElectricEIR.condenserType == "AirCooled") && (chillerElectricEIR.chilledWaterLoop.is_initialized)
          plantLoop = chillerElectricEIR.chilledWaterLoop.get
          plantLoop.demandComponents.each do |dc|
            if (dc.to_PumpConstantSpeed.is_initialized)
              pump = dc.to_PumpConstantSpeed.get
              pump.setRatedPumpHead(OpenStudio.convert(rated_pump_head,"ftH_{2}O","Pa"))  
              runner.registerInfo("For the Primary Chilled Water PlantLoop named #{plantLoop.name}, set the 'Rated Pump Head' of the Variable Speed Pump named #{pump.name} serving Air-Cooled Chiller named #{chillerElectricEIR.name} from #{OpenStudio.convert(old_pump_head,"Pa","ftH_{2}O").round(2)} ft of H2O to #{rated_pump_head.round(2)} ft of H2O.")
            elsif (dc.to_PumpVariableSpeed.is_initialized)
            	pump = dc.to_PumpConstantSpeed.get
              pump.setRatedPumpHead(OpenStudio.convert(rated_pump_head,"ftH_{2}O","Pa"))  
              runner.registerInfo("For the Primary Chilled Water PlantLoop named #{plantLoop.name}, set the 'Rated Pump Head' of the Constant Speed Pump named #{pump.name} serving Air-Cooled Chiller named #{chillerElectricEIR.name} from #{OpenStudio.convert(old_pump_head,"Pa","ftH_{2}O").round(2)} ft of H2O to #{rated_pump_head.round(2)} ft of H2O.")
            else
              # do nothing  
            end
          end
        end
      end  
    end
    
    # changes vrf indoor units pressure rise to user specified override value
    def change_vrf_indoor_unit_fan_pressure_rise(model, runner, fan_pressure_rise)
      
      model.getZoneHVACTerminalUnitVariableRefrigerantFlows.each do |zoneHVACTerminalUnitVariableRefrigerantFlow| 
        vrf_fan = zoneHVACTerminalUnitVariableRefrigerantFlow.supplyAirFan.to_FanOnOff.get
        old_fan_pressure = vrf_fan.pressureRise
        runner.registerInfo("For the Indoor VRF Unit named #{zoneHVACTerminalUnitVariableRefrigerantFlow.name}, set the 'Fan Pressure RiseRated Pump Head' from #{OpenStudio.convert(old_fan_pressure,"Pa","inH_{2}O").round(2)} in of H2O to #{fan_pressure_rise.round(2)} in of H2O.")
        vrf_fan.setPressureRise(OpenStudio.convert(fan_pressure_rise,"inH_{2}O","Pa"))
      end  
    end
   
    def change_ac_chiller_reference_cop(model, runner, reference_cop)
      
      pump = nil
      model.getChillerElectricEIRs.each do |chillerElectricEIR| 
        if (chillerElectricEIR.condenserType == "AirCooled") && (chillerElectricEIR.chilledWaterLoop.is_initialized)
          old_chiller_cop = chillerElectricEIR.referenceCOP
          chiller.setReferenceCOP(reference_cop)
          runner.registerInfo("Based on user override values, for the Air Cooled Chiller named #{chillerElectricEIR.name}, set the 'Reference COP' from #{old_chiller_cop} to #{rated_cop}.")
        end
      end  
    end
    
    # create HVAC system using methods in openstudio-standards
    # Standard.model_add_hvac_system(model, system_type, main_heat_fuel, zone_heat_fuel, cool_fuel, zones)
    # can be combination systems or individual objects - depends on the type of system
    # todo - reenable fan_coil_capacity_control_method when major installer released with udpated standards gem from what shipped with 2.9.0
    case hvac_system_type.to_s

    when 'Fan coils with water-cooled chiller with electric boiler' # 1 tested

      change_electric_boiler_efficiency(model)                                     

    when 'Fan coils with ERV with water-cooled chiller with electric boiler' # 2 tested

      change_electric_boiler_efficiency(model)                                     

    when 'Fan coils with water-cooled chiller with electric boiler with DOAS' # 3 tested

      change_electric_boiler_efficiency(model)                                     

    when 'Fan coils with water-cooled chiller with electric boiler with DOAS with DCV' # 4 tested

      change_electric_boiler_efficiency(model)                                        
    
    when 'Fan coils with water-cooled chiller with electric boiler with DOAS with ERV' # 5 tested

      change_electric_boiler_efficiency(model)                                        

 
    when 'Fan coils with water-cooled chiller with central air source heat pump' # 6 tested 
                                              
    when 'Fan coils with ERV with water-cooled chiller with central air source heat pump' # 7 tested
                                                                                      
    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS'

    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with DCV'
    
    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with ERV'

    when 'Fan coils with air-cooled chiller with electric boiler'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
      change_electric_boiler_efficiency(model, runner)                                        

    when 'Fan coils with ERV with air-cooled chiller with electric boiler'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
    
    when 'Fan coils with air-cooled chiller with electric boiler with DOAS'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Fan coils with air-cooled chiller with electric boiler with DOAS with DCV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
        
    when 'Fan coils with air-cooled chiller with electric boiler with DOAS with ERV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'Fan coils with air-cooled chiller with central air source heat pump'

    when 'Fan coils with ERV with air-cooled chiller with central air source heat pump'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with DCV'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with ERV'
      
      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS with DCV'

      change_electric_boiler_efficiency(model, runner)                                        
                                            
    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS with ERV'

      change_electric_boiler_efficiency(model, runner)                                        
                                            
    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS'

    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with DCV'

    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with ERV'

    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS with DCV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
                                              
    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS with ERV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
      
    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      
    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with DCV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
       change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        

    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with ERV'

      if not (custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f == 0)
        change_ac_chiller_primary_loop_pump_rated_pump_head(model, runner, custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head].to_f)
      end
      if not (custom_properties[:ac_chiller_reference_cop].to_f == 0)
        change_ac_chiller_reference_cop(model, runner, custom_properties[:ac_chiller_reference_cop].to_f)
      end
      change_electric_boiler_efficiency(model, runner)                                        
  
    when 'Heat Recovery VRF'

      if not (custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f == 0)
        change_vrf_indoor_unit_fan_pressure_rise(model, runner, custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f)     
      end

      if not (custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f == 0)
        change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f)
      end

    when 'Heat Recovery VRF with ERV'

      if not (custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f == 0)
        change_vrf_indoor_unit_fan_pressure_rise(model, runner, custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f)     
      end

      if not (custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f == 0)
        change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f)
      end

    when 'Heat Recovery VRF with DOAS'

      if not (custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f == 0)
        change_vrf_indoor_unit_fan_pressure_rise(model, runner, custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f)     
      end

      if not (custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f == 0)
        change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f)
      end

    when 'Heat Recovery VRF with DOAS with DCV'

      if not (custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f == 0)
        change_vrf_indoor_unit_fan_pressure_rise(model, runner, custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f)     
      end

      if not (custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f == 0)
        change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f)
      end

    when 'Heat Recovery VRF with DOAS with ERV'

      if not (custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f == 0)
        change_vrf_indoor_unit_fan_pressure_rise(model, runner, custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise].to_f)     
      end

      if not (custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f == 0)
        change_vrf_outdoor_unit_htg_cop_at_47f(model, runner, custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f].to_f)
      end
    
    when 'Water source heat pumps with cooling tower with electric boiler'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'Water source heat pumps with ERV with cooling tower with electric boiler'

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS with DCV'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS with ERV'

    when 'Water source heat pumps with ground source heat pump'

    when 'Water source heat pumps with ERV with ground source heat pump'

    when 'Water source heat pumps with ground source heat pump with DOAS'

    when 'Water source heat pumps with ground source heat pump with DOAS with DCV'

    when 'Water source heat pumps with ground source heat pump with DOAS with ERV'

    when 'PTACs with electric baseboard heat'

    when 'PTACs with electric baseboard heat with ERV'

    when 'PTACs with electric baseboard heat with DOAS'

    when 'PTACs with electric baseboard heat with DOAS with DCV'
  
    when 'PTACs with electric baseboard heat with DOAS with ERV'

    when 'PTACs with electric boiler'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'PTACs with electric boiler with DOAS'

      change_electric_boiler_efficiency(model, runner)                                        

    when 'PTACs with electric boiler with DOAS with DCV'

      change_electric_boiler_efficiency(model, runner)                                        
      
    when 'PTACs with electric boiler with DOAS with ERV'
                                                                                                                                 
    when 'PSZ-HP'
    
    when 'PSZ-HP with DOAS'

    when 'PSZ-HP with DOAS with DCV'

    when 'PSZ-HP with DOAS with ERV'

    when 'PSZ-AC with electric heat'

    when 'PSZ-AC with electric heat with DOAS'
  
    when 'PSZ-AC with electric heat with DOAS with DCV'
  
    when 'PSZ-AC with electric heat with DOAS with ERV'

    when 'PTHP'

    when 'PTHP with ERV'

    when 'PTHP with DOAS'

    when 'PTHP with DOAS with DCV'

    when 'PTHP with DOAS with ERV'

    when 'Residential Minisplit Heat Pumps with ERV'

    when 'Residential Minisplit Heat Pumps with DOAS'

    when 'Residential Minisplit Heat Pumps with DOAS with DCV'

    when 'Residential Minisplit Heat Pumps with DOAS with ERV'

    else
      runner.registerError("Zonal HVAC System '#{hvac_system_type}' not recognized")
      return false
    end # end case statement
    runner.registerInfo("Added HVAC System type #{hvac_system_type} to the model.")
   
  end # end method

  def add_system_to_zones(model, runner, hvac_system_type, zones, standard)
    
    # create HVAC system using methods in openstudio-standards
    # Standard.model_add_hvac_system(model, system_type, main_heat_fuel, zone_heat_fuel, cool_fuel, zones)
    # can be combination systems or individual objects - depends on the type of system
    # todo - reenable fan_coil_capacity_control_method when major installer released with udpated standards gem from what shipped with 2.9.0
    case hvac_system_type.to_s

    when 'Fan coils with water-cooled chiller with electric boiler' # 1 tested
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     zone_equipment_ventilation: true,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Fan coils with ERV with water-cooled chiller with electric boiler' # 2 tested
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     zone_equipment_ventilation: true,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)
      
    when 'Fan coils with water-cooled chiller with electric boiler with DOAS' # 3 tested
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     zone_equipment_ventilation: false,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
      
    when 'Fan coils with water-cooled chiller with electric boiler with DOAS with DCV' # 4 tested
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Fan coils with water-cooled chiller with electric boiler with DOAS with ERV' # 5 tested
      standard.model_add_hvac_system(model, 'DOAS Cold Supply', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
 
    when 'Fan coils with water-cooled chiller with central air source heat pump' # 6 tested 
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     zone_equipment_ventilation: true,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')
  
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
    
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
    
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
                                              
    when 'Fan coils with ERV with water-cooled chiller with central air source heat pump' # 7 tested
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: true,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
  
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
    
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
    
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
   
      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)
                                                                                      
    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
    
    when 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Fan coils with air-cooled chiller with electric boiler'
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     zone_equipment_ventilation: true,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with ERV with air-cooled chiller with electric boiler'
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      zone_equipment_ventilation: true,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)
    
    when 'Fan coils with air-cooled chiller with electric boiler with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature',
                                    chilled_water_loop_cooling_type: 'AirCooled',
                                    zone_equipment_ventilation: false,
                                    fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with air-cooled chiller with electric boiler with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature',
                                    chilled_water_loop_cooling_type: 'AirCooled',
                                    zone_equipment_ventilation: false,
                                    fan_coil_capacity_control_method: 'VariableFanVariableFlow')

        
    when 'Fan coils with air-cooled chiller with electric boiler with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     zone_equipment_ventilation: false,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with air-cooled chiller with central air source heat pump'
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     zone_equipment_ventilation: true,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with ERV with air-cooled chiller with central air source heat pump'
      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      zone_equipment_ventilation: true,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     zone_equipment_ventilation: false,
                                     fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'Fan Coil', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      zone_equipment_ventilation: false,
                                      fan_coil_capacity_control_method: 'VariableFanVariableFlow')

    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
                                              
    when 'Radiant slab with water-cooled chiller with electric boiler with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
                                              
    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones)
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones)
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones)
      
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature',
                                    chilled_water_loop_cooling_type: 'AirCooled',
                                    air_loop_heating_type: 'Water',
                                    air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')

    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')
                                              
    when 'Radiant slab with air-cooled chiller with electric boiler with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
      
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')

    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                     chilled_water_loop_cooling_type: 'AirCooled',
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
    
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                    chilled_water_loop_cooling_type: 'AirCooled')

    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
    
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                    chilled_water_loop_cooling_type: 'AirCooled')
    when 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                      chilled_water_loop_cooling_type: 'AirCooled',
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')
    
      standard.model_add_hvac_system(model, 'Radiant Slab', ht = 'AirSourceHeatPump', znht = nil, cl = 'Electricity', zones,
                                    chilled_water_loop_cooling_type: 'AirCooled')

    when 'Heat Recovery VRF'
      standard.model_add_hvac_system(model, 'VRF', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    zone_equipment_ventilation: true)

    when 'Heat Recovery VRF with ERV'
      standard.model_add_hvac_system(model, 'VRF', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    zone_equipment_ventilation: false)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'Heat Recovery VRF with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
    
      standard.model_add_hvac_system(model, 'VRF', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     zone_equipment_ventilation: false)
      
    when 'Heat Recovery VRF with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')
    
      standard.model_add_hvac_system(model, 'VRF', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false)

    when 'Heat Recovery VRF with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')
    
      standard.model_add_hvac_system(model, 'VRF', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false)

    when 'Water source heat pumps with cooling tower with electric boiler'
      standard.model_add_hvac_system(model, 'Water Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature',
                                    heat_pump_loop_cooling_type: 'CoolingTower',
                                    zone_equipment_ventilation: true)

    when 'Water source heat pumps with ERV with cooling tower with electric boiler'
      standard.model_add_hvac_system(model, 'Water Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature',
                                    heat_pump_loop_cooling_type: 'CoolingTower',
                                    zone_equipment_ventilation: true)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature')
      
      standard.model_add_hvac_system(model, 'Water Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     heat_pump_loop_cooling_type: 'CoolingTower',
                                     zone_equipment_ventilation: false)

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')
      
      standard.model_add_hvac_system(model, 'Water Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      heat_pump_loop_cooling_type: 'CoolingTower',
                                      zone_equipment_ventilation: false)

    when 'Water source heat pumps with cooling tower with electric boiler with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature')
      
      standard.model_add_hvac_system(model, 'Water Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      hot_water_loop_type: 'LowTemperature',
                                      heat_pump_loop_cooling_type: 'CoolingTower',
                                      zone_equipment_ventilation: false)

    when 'Water source heat pumps with ground source heat pump'
      standard.model_add_hvac_system(model, 'Ground Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    zone_equipment_ventilation: true)

    when 'Water source heat pumps with ERV with ground source heat pump'
      standard.model_add_hvac_system(model, 'Ground Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    zone_equipment_ventilation: true)
                              
      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'Water source heat pumps with ground source heat pump with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'Ground Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     zone_equipment_ventilation: false)

    when 'Water source heat pumps with ground source heat pump with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'Ground Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false)

    when 'Water source heat pumps with ground source heat pump with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'Ground Source Heat Pumps', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      zone_equipment_ventilation: false)

    when 'VAV water-cooled chiller with electric boiler reheat'
      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    air_loop_heating_type: 'Water',
                                    air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)

    when 'VAV water-cooled chiller with electric boiler reheat with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')
    
      chilled_water_loop = model.getPlantLoopByName('Chilled Water Loop').get
      
      condenser_water_loop = model.getPlantLoopByName('Condenser Water Loop').get
      
      standard.model_add_waterside_economizer(model, chilled_water_loop, condenser_water_loop,
                                              integrated: true)
    
    when 'VAV with air-cooled chiller with electric boiler reheat'
      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled')

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')

      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled')

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
                                   
      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled')

    when 'VAV with air-cooled chiller with electric boiler reheat with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'Water')
                                  
      standard.model_add_hvac_system(model, 'VAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature',
                                     chilled_water_loop_cooling_type: 'AirCooled')
    
    # PVAV systems by default use a DX coil for cooling
    when 'PVAV with electric boiler reheat'
      standard.model_add_hvac_system(model, 'PVAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                     hot_water_loop_type: 'LowTemperature')
    
    when 'PVAV with electric boiler reheat with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'Water',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PVAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')

    when 'PVAV with electric boiler reheat with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PVAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')

    when 'PVAV with electric boiler reheat with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'Water',
                                      air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PVAV Reheat', ht = 'Electricity', znht = 'Electricity', cl = 'Electricity', zones,
                                    hot_water_loop_type: 'LowTemperature')

    when 'PTACs with electric baseboard heat'
      std.model_add_hvac_system(model, 'PTAC', 'Electricity', 'Electricity', 'Electricity', zones)

    when 'PTACs with electric baseboard heat with ERV'
      std.model_add_hvac_system(model, 'PTAC', 'Electricity', 'Electricity', 'Electricity', zones)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'PTACs with electric baseboard heat with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      std.model_add_hvac_system(model, 'PTAC', 'Electricity', 'Electricity', 'Electricity', zones)

    when 'PTACs with electric baseboard heat with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
                            
      std.model_add_hvac_system(model, 'PTAC', 'Electricity', 'Electricity', 'Electricity', zones)
  
    when 'PTACs with electric baseboard heat with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
                                
      standard.model_add_hvac_system(model, 'PTAC', 'Electricity', 'Electricity', 'Electricity', zones)

    when 'PTACs with electric boiler'
      standard.model_add_hvac_system(model, 'PTAC', 'Electricity', nil, 'Electricity', zones,
                                     hot_water_loop_type: "HighTemperature")

    when 'PTACs with electric boiler with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTAC', 'Electricity', nil, 'Electricity', zones,
                                     hot_water_loop_type: "HighTemperature")

    when 'PTACs with electric boiler with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTAC', 'Electricity', nil, 'Electricity', zones,
                                      hot_water_loop_type: "HighTemperature")

      
    when 'PTACs with electric boiler with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                      air_loop_heating_type: 'DX',
                                      air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTAC', 'Electricity', nil, 'Electricity', zones,
                                      hot_water_loop_type: "HighTemperature")
                                                                                                                                 
    when 'PSZ-HP'
      standard.model_add_hvac_system(model, 'PSZ-HP', ht = 'Electricity', znht = nil, cl = 'Electricity', zones)
    
    when 'PSZ-HP with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PSZ-HP', ht = 'Electricity', znht = nil, cl = 'Electricity', zones)

    when 'PSZ-HP with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PSZ-HP', ht = 'Electricity', znht = nil, cl = 'Electricity', zones)

    when 'PSZ-HP with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PSZ-HP', ht = 'Electricity', znht = nil, cl = 'Electricity', zones)

    when 'PSZ-AC with electric heat'
      standard.model_add_hvac_system(model, 'PSZ-AC', 'Electricity', 'Electricity', 'Electricity', zones)

    when 'PSZ-AC with electric heat with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'PSZ-AC', 'Electricity', 'Electricity', 'Electricity', zones)
  
    when 'PSZ-AC with electric heat with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'PSZ-AC', 'Electricity', 'Electricity', 'Electricity', zones)
  
    when 'PSZ-AC with electric heat with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')
      
      standard.model_add_hvac_system(model, 'PSZ-AC', 'Electricity', 'Electricity', 'Electricity', zones)
  
    when 'PTHP'
      standard.model_add_hvac_system(model, 'PTHP', nil, nil, nil, zones)

    when 'PTHP with ERV'
      standard.model_add_hvac_system(model, 'PTHP', nil, nil, nil, zones)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'PTHP with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTHP', nil, nil, nil, zones)

    when 'PTHP with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTHP', nil, nil, nil, zones)

    when 'PTHP with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                     air_loop_heating_type: 'DX',
                                     air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'PTHP', nil, nil, nil, zones)

    when 'Residential Minisplit Heat Pumps with ERV'
      standard.model_add_hvac_system(model, 'Residential Minisplit Heat Pumps', nil, nil, nil, zones)

      standard.model_add_hvac_system(model, 'ERVs', nil, nil, nil, zones)

    when 'Residential Minisplit Heat Pumps with DOAS'
      standard.model_add_hvac_system(model, 'DOAS', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    air_loop_heating_type: 'DX',
                                    air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'Residential Minisplit Heat Pumps', nil, nil, nil, zones)

    when 'Residential Minisplit Heat Pumps with DOAS with DCV'
      standard.model_add_hvac_system(model, 'DOAS with DCV', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    air_loop_heating_type: 'DX',
                                    air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'Residential Minisplit Heat Pumps', nil, nil, nil, zones)

    when 'Residential Minisplit Heat Pumps with DOAS with ERV'
      standard.model_add_hvac_system(model, 'DOAS with ERVs', ht = 'Electricity', znht = nil, cl = 'Electricity', zones,
                                    air_loop_heating_type: 'DX',
                                    air_loop_cooling_type: 'DX')

      standard.model_add_hvac_system(model, 'Residential Minisplit Heat Pumps', nil, nil, nil, zones)

    else
      runner.registerError("HVAC System '#{hvac_system_type}' not recognized")
      return false
    end # end case statement
    runner.registerInfo("Added HVAC System type #{hvac_system_type} to the model for #{zones.size} zones")
    
  end # end method

  # define the arguments that the user will input
  def arguments(model)
     args = OpenStudio::Measure::OSArgumentVector.new
     
    # # the name of the space to add to the model
    # gbxml_file_name = OpenStudio::Measure::OSArgument.makeStringArgument("gbxml_file_name", true)
    # gbxml_file_name.setDisplayName("gbXML filename")
    # gbxml_file_name.setDescription("Filename or full path to gbXML file.")
    # args << gbxml_file_name

    # # Make an argument for the hvac_template
    # hvac_template_chs = OpenStudio::StringVector.new
    # hvac_template_chs << '90.1-2004'
    # hvac_template_chs << '90.1-2007'
    # hvac_template_chs << '90.1-2010'
    # hvac_template_chs << '90.1-2013'
    # hvac_template_chs << '90.1-2016' # requires OS v3.6.0 or later 
    # hvac_template_chs << '90.1-2019' # requires OS v3.6.0 or later
    # hvac_template_chs << 'NREL ZNE Ready 2017'
    # hvac_template = OpenStudio::Measure::OSArgument.makeChoiceArgument('hvac_template', hvac_template_chs, true)
    # hvac_template.setDisplayName('ASHRAE Standard that HVAC Equipment Efficiencies should meet.')
    # hvac_template.setDefaultValue('90.1-2013')
    # args << hvac_template`

    # # Make argument for airloop_hvac_system_type
    # hvac_chs = OpenStudio::StringVector.new
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'PVAV with electric boiler reheat'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'PSZ-HP'
    # hvac_chs << 'PSZ-HP with DOAS'
    # hvac_chs << 'PSZ-HP with DOAS with DCV'
    # hvac_chs << 'PSZ-HP with DOAS with ERV'
    # hvac_chs << 'PSZ-AC with electric heat'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS with DCV'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS with ERV'
    # hvac_chs << 'Heat Recovery VRF with ERV'
    # hvac_chs << 'Heat Recovery VRF with DOAS'
    # hvac_chs << 'Heat Recovery VRF with DOAS with DCV'
    # hvac_chs << 'Heat Recovery VRF with DOAS with ERV'
    # airloop_hvac_system_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('airloop_hvac_system_type', hvac_chs, true)
    # airloop_hvac_system_type.setDisplayName('Airloop HVAC System Type')
    # airloop_hvac_system_type.setDefaultValue('VRF with DOAS')
    # args << airloop_hvac_system_type
    
    # # Make argument for zone_equipment_hvac_system_type
    # hvac_chs = OpenStudio::StringVector.new
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler' 
    # hvac_chs << 'Fan coils with ERV with water-cooled chiller with electric boiler' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS with DCV' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS with ERV' 
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump' 
    # hvac_chs << 'Fan coils with ERV with water-cooled chiller with central air source heat pump' 
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with DCV
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler'
    # hvac_chs << 'Fan coils with ERV with air-cooled chiller with electric boiler'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump'
    # hvac_chs << 'Fan coils with ERV with air-cooled chiller with central air source heat pump'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with DCV
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with DCV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with DCV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler
    # hvac_chs << 'Water source heat pumps with ERV with cooling tower with electric boiler
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS with DCV
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS with ERV
    # hvac_chs << 'Water source heat pumps with ground source heat pump'
    # hvac_chs << 'Water source heat pumps with ERV with ground source heat pump'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS with DCV'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS with ERV'
    # hvac_chs << 'PTACs with electric baseboard heat'
    # hvac_chs << 'PTACs with ERV with electric baseboard heat'
    # hvac_chs << 'PTACs with electric baseboard heat with DOAS'
    # hvac_chs << 'PTACs with electric baseboad heat with DOAS with DCV'
    # hvac_chs << 'PTACs with electric baseboard heat with DOAS with ERV'
    # hvac_chs << 'PTACs with electric boiler'
    # hvac_chs << 'PTACs with electric boiler with DOAS'
    # hvac_chs << 'PTACs with electric boiler with DOAS with DCV'
    # hvac_chs << 'PTACs with electric boiler with DOAS with ERV'
    # hvac_chs << 'PTHP'
    # hvac_chs << 'PTHP with ERV'
    # hvac_chs << 'PTHP with DOAS'
    # hvac_chs << 'PTHP with DOAS with DCV'
    # hvac_chs << 'PTHP with DOAS with ERV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with ERV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS with DCV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS with ERV'
    # zone_equipment_hvac_system_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('zone_equipment_hvac_system_type', hvac_chs, true)
    # zone_equipment_hvac_system_type.setDisplayName('Zone Equipment HVAC System Type')
    # zone_equipment_hvac_system_type.setDefaultValue('VRF with DOAS')
    # args << zone_equipment_hvac_system_type

    # # Make argument for primary HVAC system type
    # hvac_chs = OpenStudio::StringVector.new
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler' 
    # hvac_chs << 'Fan coils with ERV with water-cooled chiller with electric boiler' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS with DCV' 
    # hvac_chs << 'Fan coils with water-cooled chiller with electric boiler with DOAS with ERV' 
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump' 
    # hvac_chs << 'Fan coils with ERV with water-cooled chiller with central air source heat pump' 
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with DCV
    # hvac_chs << 'Fan coils with water-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler'
    # hvac_chs << 'Fan coils with ERV with air-cooled chiller with electric boiler'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Fan coils with air-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump'
    # hvac_chs << 'Fan coils with ERV with air-cooled chiller with central air source heat pump'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with DCV
    # hvac_chs << 'Fan coils with air-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with DCV'
    # hvac_chs << 'Radiant slab with water-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS with DCV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with electric boiler with DOAS with ERV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with DCV'
    # hvac_chs << 'Radiant slab with air-cooled chiller with central air source heat pump with DOAS with ERV'
    # hvac_chs << 'VRF with ERV'
    # hvac_chs << 'VRF with DOAS'
    # hvac_chs << 'VRF with DOAS with DCV'
    # hvac_chs << 'VRF with DOAS with ERV'
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler
    # hvac_chs << 'Water source heat pumps with ERV with cooling tower with electric boiler
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS with DCV
    # hvac_chs << 'Water source heat pumps with cooling tower with electric boiler with DOAS with ERV
    # hvac_chs << 'Water source heat pumps with ground source heat pump'
    # hvac_chs << 'Water source heat pumps with ERV with ground source heat pump'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS with DCV'
    # hvac_chs << 'Water source heat pumps with ground source heat pump with DOAS with ERV'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'VAV with water-cooled chiller with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'VAV with air-cooled chiller with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'PVAV with electric boiler reheat'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS with DCV'
    # hvac_chs << 'PVAV with electric boiler reheat with DOAS with ERV'
    # hvac_chs << 'PTACs with electric baseboard heat'
    # hvac_chs << 'PTACs with ERV with electric baseboard heat'
    # hvac_chs << 'PTACs with electric baseboard heat with DOAS'
    # hvac_chs << 'PTACs with electric baseboad heat with DOAS with DCV'
    # hvac_chs << 'PTACs with electric baseboard heat with DOAS with ERV'
    # hvac_chs << 'PTACs with electric boiler'
    # hvac_chs << 'PTACs with electric boiler with DOAS'
    # hvac_chs << 'PTACs with electric boiler with DOAS with DCV'
    # hvac_chs << 'PTACs with electric boiler with DOAS with ERV'
    # hvac_chs << 'PSZ-HP'
    # hvac_chs << 'PSZ-HP with DOAS'
    # hvac_chs << 'PSZ-HP with DOAS with DCV'
    # hvac_chs << 'PSZ-HP with DOAS with ERV'
    # hvac_chs << 'PSZ-AC with electric heat'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS with DCV'
    # hvac_chs << 'PSZ-AC with electric heat with DOAS with ERV'
    # hvac_chs << 'PTHP'
    # hvac_chs << 'PTHP with ERV'
    # hvac_chs << 'PTHP with DOAS'
    # hvac_chs << 'PTHP with DOAS with DCV'
    # hvac_chs << 'PTHP with DOAS with ERV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with ERV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS with DCV'
    # hvac_chs << 'Residential Minisplit Heat Pumps with DOAS with ERV'
    # hvac_system_type = OpenStudio::Measure::OSArgument.makeChoiceArgument('hvac_system_type', hvac_chs, true)
    # hvac_system_type.setDisplayName('Primary HVAC System Type')
    # hvac_system_type.setDefaultValue('VRF with DOAS')
    # args << hvac_system_type

    # # Argument for how to partition HVAC system
    # hvac_system_partition_choices = OpenStudio::StringVector.new
    # hvac_system_partition_choices << "Automatic Partition"
    # hvac_system_partition_choices << "Whole Building"
    # hvac_system_partition_choices << "One System Per Building Story"
    # hvac_system_partition_choices << "One System Per Building Type"
    # hvac_system_partition_choices << "Use Analytical Systems Topology" 
    
    # hvac_system_partition = OpenStudio::Measure::OSArgument.makeChoiceArgument('hvac_system_partition', hvac_system_partition_choices, true)
    # hvac_system_partition.setDisplayName('HVAC System Partition:')
    # hvac_system_partition.setDescription('Automatic Partition will separate the HVAC system by residential/non-residential and if loads and schedules are substantially different.')
    # hvac_system_partition.setDefaultValue('Automatic Partition')
    # args << hvac_system_partition

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
     
     return args
     
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    super(model, runner, user_arguments)  # Do **NOT** remove this line
 
    # declare variables for proper scope
    hvac_template = nil
    sec_sys_type = nil
    zone_equipment_hvac_system_type =  nil
    airloop_hvac_system_type = nil
    climate_zone = nil
    
    # override properties
    ac_chiller_primary_loop_pump_rated_pump_head = nil
    ac_chiller_rated_cop = nil
    vrf_outdoor_unit_rated_htg_cop_at_47f = nil
    vrf_outdoor_unit_rated_clg_eer = nil
    vrf_indoor_unit_supply_fan_pressure_rise =  nil
    
    custom_properties = {}
    
    airloop_hvac_zone_lists = []
    zone_equipment_hvac_zone_lists = []
 
    # Load 'building' level parameters needed to create HVAC systems
    CSV.foreach((File.expand_path(File.join(File.dirname(__FILE__), "resources", "Building_Level_Mappings.csv"))), headers: true) do |row|
      
      # read 'basic' properites from the csv file
      hvac_template = row[1].to_s if (row[0] == "HVAC Equipment Efficiency Standard")
      zone_equipment_hvac_system_type = row[1].to_s if (row[0] == "zone_equipment_hvac_system_type")
      airloop_hvac_system_type = row[1].to_s if (row[0] == "airloop_hvac_system_type")
      climate_zone = row[1].to_s if (row[0] == "climate_zone")
      
      # read hvac system 'override' properties from the csv file
      ac_chiller_primary_loop_pump_rated_pump_head = row[1].to_f if (row[0] == "Air Cooled Chiller Primary Loop Pump Rated Head")
       if not (ac_chiller_primary_loop_pump_rated_pump_head == 0)
         custom_properties[:ac_chiller_primary_loop_pump_rated_pump_head] = ac_chiller_primary_loop_pump_rated_pump_head.to_f
       end
       
       ac_chiller_reference_cop = row[1].to_f if (row[0] == "Air Cooled Chiller Rated COP")
       if not (ac_chiller_reference_cop == 0)
         custom_properties[:ac_chiller_reference_cop] = ac_chiller_reference_cop.to_f
       end
       
       vrf_outdoor_unit_rated_htg_cop_at_47f = row[1].to_f if (row[0] == "VRF Outdoor Unit Rated Htg COP at 47F")
       if not (vrf_outdoor_unit_rated_htg_cop_at_47f == 0)
         custom_properties[:vrf_outdoor_unit_rated_htg_cop_at_47f] = vrf_outdoor_unit_rated_htg_cop_at_47f.to_f
       end
       
       vrf_outdoor_unit_rated_clg_eer = row[1].to_f if (row[0] == "VRF Outdoor Unit Gross Rated Clg EER")
       if not (vrf_outdoor_unit_rated_clg_eer == 0)
         custom_properties[:vrf_outdoor_unit_rated_clg_eer] = vrf_outdoor_unit_rated_clg_eer.to_f
       end

       vrf_indoor_unit_supply_fan_pressure_rise = row[1].to_f if (row[0] == "VRF Indoor Unit Supply Fan Pressure Rise")
       if not (vrf_indoor_unit_supply_fan_pressure_rise == 0)
         custom_properties[:vrf_indoor_unit_supply_fan_pressure_rise] = vrf_indoor_unit_supply_fan_pressure_rise.to_f
       end
    end

    # get airloop_hvac_zone_lists and zone_equipment_hvac_zone_list, only needed  
    model.getAirLoopHVACs.each do |airLoopHVAC|
      airloop_hvac_zone_list = []
      airLoopHVAC.demandComponents.each do |demand_component|
        if (demand_component.to_ThermalZone.is_initialized)
          airloop_hvac_zone_list << demand_component.to_ThermalZone.get
        end
      end
      airloop_hvac_zone_lists << airloop_hvac_zone_list
    end
    
    # create array of conditioned thermal zones served bu zone equipment hvac systems.
    model.getThermalZones.each do |thermalZone|
      if (thermalZone.airLoopHVACTerminals.size == 0)
        if (thermalZone.thermostatSetpointDualSetpoint.is_initialized) || (thermalZone.thermostat.is_initialized)
          zone_equipment_hvac_zone_lists << thermalZone
        end
      end
    end
    
    #check to see if a thermal zone is listed in both zone lists. If so, the Revit user (using the Systems Analysys UI) 
    # created a DOAS + VRF system. If/when we catch this kind of system
    
    std = Standard.build(hvac_template)
    
    # ensure standards building type is set
    unless model.getBuilding.standardsBuildingType.is_initialized
      dominant_building_type = std.model_get_standards_building_type(model)
      if dominant_building_type.nil?
        # use office building type if none in model
        model.getBuilding.setStandardsBuildingType('Office')
      else
        model.getBuilding.setStandardsBuildingType(dominant_building_type)
      end
    end

    # remove existing hvac system from model
    runner.registerInfo('Removing all existing HVAC systems from the model')
    std.remove_hvac(model)
    
    # exclude plenum zones, zones without thermostats, and zones with no floor area
    conditioned_zones = []
    model.getThermalZones.each do |zone|
      next if std.thermal_zone_plenum?(zone)
      next if !std.thermal_zone_heated?(zone) && !std.thermal_zone_cooled?(zone)
      conditioned_zones << zone
    end
        
    # logic to partition thermal zones to be served by different HVAC systems, based on Revit 
    airloop_hvac_zone_lists.each do |zl|
      add_system_to_zones(model, runner, airloop_hvac_system_type, zl, std)
      runner.registerInfo("Created a new #{airloop_hvac_system_type} AirLoopHVAC HVAC system serving #{zl.size} Thermal Zones, as mapped using Revit Analytical Systems") 
    end     
    
    zone_equipment_hvac_zone_lists.each do |single_thermal_zone|
      single_thermal_zone_array = []
      single_thermal_zone_array << single_thermal_zone      
      add_system_to_zones(model, runner, zone_equipment_hvac_system_type, single_thermal_zone_array, std)
      runner.registerInfo("Created a new #{zone_equipment_hvac_system_type} Zone Equipment HVAC system serving a single thermal zone, as mapped using Revit Analytical Systems") 
    end      
    
    # TODO - collapse multiple chilled water loops into a single loop and size number of chillers per ASHRAE 90.1 Appendix G 
    # TODO - collapse multiple hot water loops into a single loop and size number of boilers per ASHRAE 90.1 Appendix G
    # TODO - collapse multiple condensor water loops into a single loop and size number of cooling towers per ASHRAE 90.1 Appendix G
 
    # check that weather file exists for a sizing run
    if !model.weatherFile.is_initialized
      runner.registerError('Weather file not set. Cannot perform sizing run.')
    end

    # ensure sizing OA method is aligned
    model.getControllerMechanicalVentilations.each do |controller|
      controller.setSystemOutdoorAirMethod('ZoneSum')
    end

    # logic to ensure variable, not cycling, pump operation for chillers
    model.getChillerElectricEIRs.each do |chillerElectricEIR|
      chillerElectricEIR.setChillerFlowMode('LeavingSetpointModulated')
    end

    # log the build messages and errors to a file before sizing run in case of failure
    log_messages_to_file("#{Dir.pwd}/openstudio-standards.log", debug = true)

    # perform a sizing run to get equipment sizes for efficiency standards
    if (std.model_run_sizing_run(model, "#{Dir.pwd}/SizingRun") == false)
      runner.registerError("Unable to perform sizing run for hvac systems of this model.  Check the openstudio-standards.log in this measure for more details.")
      log_messages_to_file("#{Dir.pwd}/openstudio-standards.log", debug = true)
      return false
    end

    # apply the HVAC efficiency standards
    std.model_apply_hvac_efficiency_standard(model, climate_zone)

    # log the build messages and errors to a file
    log_messages_to_file("#{Dir.pwd}/openstudio-standards.log", debug = true)
 
    # Apply HVAC equipment parameter overrides
    override_airloop_hvac_equipment_properties(model, runner, airloop_hvac_system_type, custom_properties, std)
    override_zone_equipment_hvac_equipment_properties(model, runner, zone_equipment_hvac_system_type, custom_properties, std)
  
    runner.registerFinalCondition("Final Condition -")

    return true
  end # end run method
  
end # end class

# register the measure to be used by the application
RevitAnalyzeAllElectricHVACSystems.new.registerWithApplication



