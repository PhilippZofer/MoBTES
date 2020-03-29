// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.Examples;
model BenchmarkModel "MoBTES model for comparison to 3D FEM models"
	extends Modelica.Icons.Example;
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient FLOW(
		medium=Storage.BHEmedium,
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={-10,75},
		extent={{10,-10},{-10,10}})));
	Modelica.Thermal.FluidHeatFlow.Sources.Ambient RETURN(
		medium=Storage.BHEmedium,
		constantAmbientPressure=10000,
		useTemperatureInput=true,
		constantAmbientTemperature=294.14999999999998) annotation(Placement(transformation(
		origin={45,75},
		extent={{-10,-10},{10,10}})));
	Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow volumeFlow1(
		medium=Storage.BHEmedium,
		m=0.1,
		T0=353.14999999999998,
		T0fixed=true,
		useVolumeFlowInput=true,
		constantVolumeFlow=2) annotation(Placement(transformation(
		origin={10,45},
		extent={{10,-10},{-10,10}},
		rotation=90)));
	Modelica.Blocks.Sources.Pulse Tin(
		amplitude(
			quantity="CelsiusTemperature",
			displayUnit="K")=60,
		period(displayUnit="a")=31536000,
		y(quantity="CelsiusTemperature"),
		offset(quantity="CelsiusTemperature")=293.14999999999998) annotation(Placement(transformation(extent={{-85,80},{-65,100}})));
	Modelica.Blocks.Sources.RealExpression realExpression1(y(
		quantity="VolumeFlowRate",
		displayUnit="l/s")=0.002 * Storage.nBHEs) annotation(Placement(transformation(extent={{-85,35},{-65,55}})));
	MoBTES.Components.SeasonalThermalStorages.BTES Storage annotation(Placement(transformation(
		origin={20,-16},
		extent={{-20,-20},{20,20}})));
	equation
		connect(FLOW.flowPort,volumeFlow1.flowPort_a) annotation(Line(
			points={{0,75},{5,75},{10,75},{10,60},{10,55}},
			color={255,0,0},
			thickness=0.0625));
		 
		connect(realExpression1.y,volumeFlow1.volumeFlow) annotation(Line(
			points={{-64,45},{-59,45},{-5,45},{0,45}},
			color={0,0,127},
			thickness=0.0625));
		 
		connect(Tin.y,RETURN.ambientTemperature) annotation(Line(
			points={{-64,90},{-59,90},{60,90},{60,69},{55,69}},
			color={0,0,127},
			thickness=0.0625));
		 
		connect(Tin.y,FLOW.ambientTemperature) annotation(Line(
			points={{-64,90},{-59,90},{-25,90},{-25,69},{-20,69}},
			color={0,0,127},
			thickness=0.0625));
		connect(Storage.BTESreturn,RETURN.flowPort) annotation(Line(
			points={{30,4},{30,9},{30,75},{35,75}},
			color={255,0,0}));
		connect(volumeFlow1.flowPort_b,Storage.BTESflow) annotation(Line(
			points={{10,35},{10,30},{10,9},{10,4}},
			color={255,0,0}));
	annotation(
		viewinfo[0](
			minOrder=0.5,
			maxOrder=12,
			mode=0,
			minStep=0.01,
			maxStep=0.10000000000000001,
			relTol=1.0000000000000001e-05,
			oversampling=4,
			anaAlgorithm=0,
			bPerMinStates=true,
			bPerScaleRows=true,
			typename="AnaStatInfo"),
		Documentation(info="<html>
<p>
Simple model for the comparison of the performance of different MoBTES models to 3D FEM models.
</p>
<ul>
<li>Simulation of 10 years</li>
<li>Constant charging for 6 months with 80 °C and 2 l/s per BHE</li>
<li>Constant discharging for 6 months with 20 °C and 2 l/s per BHE</li>
<li>Parallel connection of double-U BHEs</li>
<li>Constant thermal properties of the underground</li>
<li>Variation of the number, length, arrangement and radial distance of BHEs </li>
</ul>

</html>"),
		experiment(
			StopTime=315360000,
			StartTime=0,
			Interval=36000,
			Solver(
				bEffJac=false,
				bSparseMat=true,
				typename="CVODE"),
			SolverOptions(
				solver="CVODE",
				typename="ExternalCVODEOptionData")));
end BenchmarkModel;
