﻿within MoBTES.Components.BoreholeHeatExchangers;
model DoubleUsegment "Double-U borehole heat exchanger"
	extends MoBTES.Components.BoreholeHeatExchangers.BHEsegment_partial;
	Components.UtilityComponents.FluidHeatFlow.SimpleHeatedPipe returnPipe(
		medium=BHEmedium,
		m=((BHEdata.dPipe1/2-BHEdata.tPipe1)^2*Modelica.Constants.pi*segmentLength*BHEmedium.rho),
		T(
			start=Tinitial,
			fixed=true)) "annular gap of coaxial pipe" annotation(Placement(transformation(
		origin={90,55},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Components.UtilityComponents.FluidHeatFlow.SimpleHeatedPipe flowPipe(
		medium=BHEmedium,
		m=((BHEdata.dPipe1/2-BHEdata.tPipe1)^2*Modelica.Constants.pi*segmentLength*BHEmedium.rho),
		T(
			start=Tinitial,
			fixed=true)) "flow pipe of coaxial pipe" annotation(Placement(transformation(
		origin={-130,55},
		extent={{-10,-10},{10,10}},
		rotation=90)));
	Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_grout_flow(
		C=Modelica.Constants.pi*((BHEdata.dBorehole/2)^2-4*(BHEdata.dPipe1/2)^2)/4*groutData.cp*groutData.rho*segmentLength,
		T(
			start=Tinitial,
			fixed=true))if useTRCMmodel annotation(Placement(transformation(extent={{-60,70},{-40,90}})));
	Modelica.Thermal.HeatTransfer.Components.HeatCapacitor C_grout_return(
		C=Modelica.Constants.pi*((BHEdata.dBorehole/2)^2-4*(BHEdata.dPipe1/2)^2)/4*groutData.cp*groutData.rho*segmentLength,
		T(
			start=Tinitial,
			fixed=true))if useTRCMmodel annotation(Placement(transformation(extent={{-5,70},{15,90}})));
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistorFlow annotation(Placement(transformation(extent={{-90,45},{-110,65}})));
	Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor convectiveResistorReturn annotation(Placement(transformation(extent={{50,45},{70,65}})));
	Modelica.Thermal.HeatTransfer.Components.ThermalResistor R_groutToGrout(R=if useTRCMmodel then ((2*(1-x_grout_center)*R_grout_spec*(R_pipeToPipe_spec-2*x_grout_center*R_grout_spec))/(2*(1-x_grout_center)*R_grout_spec-R_pipeToPipe_spec+2*x_grout_center*R_grout_spec))/segmentLength else (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_pipeToPipe_spec)/segmentLength) annotation(Placement(transformation(extent={{-35,45},{-15,65}})));
	Components.UtilityComponents.ThermalResistances.ThermalResistor_amplified R_fluidToGrout_flow(
		R=if useTRCMmodel then (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+x_grout_center*R_grout_spec)/segmentLength else (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_grout_spec)/segmentLength,
		amplification_factor=if useTRCMmodel then 1 else 2) annotation(Placement(transformation(extent={{-80,45},{-60,65}})));
	Components.UtilityComponents.ThermalResistances.ThermalResistor_amplified R_fluidToGrout_return(
		R=if useTRCMmodel then (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+x_grout_center*R_grout_spec)/segmentLength else (log(BHEdata.dPipe1/(BHEdata.dPipe1-2*BHEdata.tPipe1))/(2*Modelica.Constants.pi*BHEdata.lamda1)+R_grout_spec)/segmentLength,
		amplification_factor=if useTRCMmodel then 1 else 2) annotation(Placement(transformation(extent={{20,45},{40,65}})));
	Components.UtilityComponents.ThermalResistances.ThermalResistor_amplified R_groutToWall_flow(
		R=(1-x_grout_center)*R_grout_spec/segmentLength,
		amplification_factor=2)if useTRCMmodel annotation(Placement(transformation(
		origin={-50,25},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	Components.UtilityComponents.ThermalResistances.ThermalResistor_amplified R_groutToWall_return(
		R=(1-x_grout_center)*R_grout_spec/segmentLength,
		amplification_factor=2)if useTRCMmodel annotation(Placement(transformation(
		origin={5,25},
		extent={{-10,-10},{10,10}},
		rotation=-90)));
	parameter Real x_grout_center(
		min=0,
		max=1)=MoBTES.Utilities.Functions.xGroutCenter_2U(BHEdata,groutData) "auxillary variable for grout centre of mass";
	parameter Real R_grout_spec=Modelica.Math.acosh((BHEdata.dBorehole^2+BHEdata.dPipe1^2-BHEdata.spacing^2)/(2*BHEdata.dBorehole*BHEdata.dPipe1))/(2*Modelica.Constants.pi*groutData.lamda)*(3.098-4.432*BHEdata.spacing/BHEdata.dBorehole+2.364*BHEdata.spacing^2/BHEdata.dBorehole^2);
	parameter Real R_pipeToPipe_spec=Modelica.Math.acosh((BHEdata.spacing^2-BHEdata.dPipe1^2)/(BHEdata.dPipe1^2))/(2*Modelica.Constants.pi*groutData.lamda);
	parameter Real segmentLength(
		quantity="Length",
		displayUnit="m") "length of pipe segment" annotation(Dialog(tab="BHE"));
	parameter Real Tinitial(quantity="CelsiusTemperature")=283.14999999999998 "initial BHE temperature" annotation(Dialog(tab="Ground"));
	initial algorithm
		assert(BHEdata.nShanks==2,"Incompatible BHE record. Number of shanks has to be 2 for double-U BHEs!",level=AssertionLevel.error);
	equation
		//convective resistances
		convectiveResistorFlow.Rc=Radvective[1]/segmentLength;
		convectiveResistorReturn.Rc=Radvective[1]/segmentLength;
		//fluid ports
		connect(bottomReturnPort,returnPipe.flowPort_b) annotation(Line(
			points={{85,5},{80,5},{80,40},{80,45}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(bottomFlowPort,flowPipe.flowPort_a) annotation(Line(
			points={{-125,5},{-120,5},{-120,40},{-120,45}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(topReturnPort,returnPipe.flowPort_a) annotation(Line(
			points={{85,95},{80,95},{80,70},{80,65}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		
		connect(topFlowPort,flowPipe.flowPort_b) annotation(Line(
			points={{-125,95},{-120,95},{-120,70},{-120,65}},
			color=DynamicSelect({255,0,0},if time>0.000000 then{255,0,0}else if time>0.000000 then{255,0,0}else{0,0,255}),
			thickness=0.0625));
		connect(convectiveResistorReturn.fluid,returnPipe.heatPort) annotation(Line(
			points={{65,55},{70,55},{65,55},{70,55}},
			color={191,0,0},
			thickness=0.0625));
		connect(convectiveResistorFlow.fluid,flowPipe.heatPort) annotation(Line(
			points={{-110,55},{-105,55},{-110,55},{-105,55}},
			color={191,0,0},
			thickness=0.0625));
		//TRCM
		connect(convectiveResistorReturn.solid,R_fluidToGrout_return.port_a) annotation(Line(
			points={{40,55},{45,55},{40,55},{45,55}},
			color={191,0,0},
			thickness=0.0625));
		connect(convectiveResistorFlow.solid,R_fluidToGrout_flow.port_a) annotation(Line(
			points={{-85,55},{-80,55},{-85,55},{-80,55}},
			color={191,0,0},
			thickness=0.0625));
		if useTRCMmodel then		
			//flow part
			connect(R_fluidToGrout_flow.port_b,C_grout_flow.port) annotation(Line(
			points={{-60,55},{-55,55},{-50,55},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_flow.port,R_groutToWall_flow.port_a) annotation(Line(
			points={{-50,35},{-50,40},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(R_groutToWall_flow.port_b,boreholeWallPort) annotation(Line(
			points={{-50,15},{-50,10},{-50,-25},{-25,-25},{-20,-25}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_flow.port,R_groutToGrout.port_b) annotation(Line(
			points={{-15,55},{-10,55},{5,55},{5,65},{5,70}},
			color={191,0,0},
			thickness=0.0625));
			//return part
			connect(R_fluidToGrout_return.port_b,C_grout_return.port) annotation(Line(
			points={{-60,55},{-55,55},{-50,55},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_return.port,R_groutToWall_return.port_a) annotation(Line(
			points={{-50,35},{-50,40},{-50,65},{-50,70}},
			color={191,0,0},
			thickness=0.0625));
			connect(R_groutToWall_return.port_b,boreholeWallPort) annotation(Line(
			points={{-50,15},{-50,10},{-50,-25},{-25,-25},{-20,-25}},
			color={191,0,0},
			thickness=0.0625));
			connect(C_grout_return.port,R_groutToGrout.port_a) annotation(Line(
			points={{-15,55},{-10,55},{5,55},{5,65},{5,70}},
			color={191,0,0},
			thickness=0.0625));
		else
			connect(R_fluidToGrout_flow.port_b,boreholeWallPort) annotation(Line(points=0));
			connect(R_fluidToGrout_return.port_b,boreholeWallPort) annotation(Line(points=0));
			connect(convectiveResistorFlow.solid,R_groutToGrout.port_a) annotation(Line(points=0));
			connect(convectiveResistorReturn.solid,R_groutToGrout.port_b) annotation(Line(points=0));
		end if;
	annotation(
		Icon(graphics={
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{38.5,99.8},{75.2,-100.2}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{45.4,-100.2},{68.7,99.8}}),
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{-46.7,99.8},{-10,-100.2}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-40,-100.2},{-16.7,99.8}}),
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{-72.7,100},{-36,-100}}),
			Rectangle(
				fillColor={224,0,0},
				fillPattern=FillPattern.Solid,
				extent={{-66,-100},{-42.7,100}}),
			Rectangle(
				fillColor={150,150,150},
				fillPattern=FillPattern.Solid,
				extent={{16.2,100.1},{52.9,-99.90000000000001}}),
			Rectangle(
				fillColor={87,128,255},
				fillPattern=FillPattern.Solid,
				extent={{23.1,-99.90000000000001},{46.4,100.1}})}),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end DoubleUsegment;
