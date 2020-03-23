within MoBTES.Components.UtilityComponents.FluidHeatFlow;
model Ambient_unconditional "Ambient with constant properties an unconditional temperature input"
	extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.SinglePortLeft(
		final T0=293,
		final Exchange=true);
	Modelica.Blocks.Interfaces.RealInput ambientTemperature annotation(Placement(
		transformation(extent={{110,-60},{90,-80}}),
		iconTransformation(extent={{110,-60},{90,-80}})));
	equation
		flowPort.p = 0;
		T = ambientTemperature;
	annotation(
		Icon(graphics={
			Ellipse(
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid,
				extent={{-90,90},{90,-90}}),
			Text(
				textString="p",
				extent={{20,80},{80,20}}),
			Text(
				textString="T",
				extent={{20,-20},{80,-80}})}),
		Documentation(info="<html>
(Infinite) ambient with constant pressure and temperature.<br>
Thermodynamic equations are defined by Partials.Ambient.
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end Ambient_unconditional;
