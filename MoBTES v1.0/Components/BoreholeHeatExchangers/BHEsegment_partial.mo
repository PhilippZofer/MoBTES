﻿within MoBTES.Components.BoreholeHeatExchangers;
partial model BHEsegment_partial "common elements of BHE types"
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a topFlowPort(medium=BHEmedium) "BHE opening at top of section" annotation(Placement(
		transformation(
			origin={-125,95},
			extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{-60,90},{-40,110}})));
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b topReturnPort(medium=BHEmedium) "BHE opening at the bottom of section" annotation(Placement(
		transformation(
			origin={85,95},
			extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{40,90},{60,110}})));
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a boreholeWallPort "thermal coupling of local and global solution" annotation(Placement(
		transformation(
			origin={-20,-35},
			extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{86.7,-10},{106.7,10}})));
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a bottomReturnPort(medium=BHEmedium) "Filled flow port (used upstream)" annotation(Placement(
		transformation(
			origin={85,5},
			extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{40,-106.7},{60,-86.7}})));
	Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b bottomFlowPort(medium=BHEmedium) "Hollow flow port (used downstream)" annotation(Placement(
		transformation(
			origin={-125,5},
			extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{-60,-106.7},{-40,-86.7}})));
	Modelica.Blocks.Interfaces.RealInput Radvective[3] annotation(Placement(
		transformation(extent={{-105,0},{-85,20}}),
		iconTransformation(extent={{-110,-10},{-90,10}})));
	replaceable parameter MoBTES.Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters;
	replaceable parameter MoBTES.Parameters.Grouts.Grout15 groutData constrainedby MoBTES.Parameters.Grouts.GroutPartial;
	parameter Boolean useTRCMmodel;
	replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Water BHEmedium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium;
	annotation(Icon(graphics={
	Rectangle(
		lineColor={127,127,127},
		fillColor={192,192,192},
		fillPattern=FillPattern.Solid,
		extent={{-100,100},{100,-100}})}));
end BHEsegment_partial;
