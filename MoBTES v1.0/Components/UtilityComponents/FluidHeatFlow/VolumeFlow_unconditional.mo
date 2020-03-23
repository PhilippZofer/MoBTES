within MoBTES.Components.UtilityComponents.FluidHeatFlow;
model VolumeFlow_unconditional "Enforces constant volume flow with unconditional volume flow input"
	extends Modelica.Thermal.FluidHeatFlow.Interfaces.Partials.TwoPort(final tapT=1);
	Modelica.Blocks.Interfaces.RealInput volumeFlow annotation(Placement(
		transformation(
			origin={0,100},
			extent={{-10,-10},{10,10}},
			rotation=270),
		iconTransformation(
			origin={0,100},
			extent={{-10,-10},{10,10}},
			rotation=270)));
	equation
		Q_flow = 0;
		V_flow = volumeFlow;
	annotation(
		Icon(graphics={
			Ellipse(
				lineColor={255,0,0},
				fillColor={255,255,255},
				fillPattern=FillPattern.Solid,
				extent={{-90,90},{90,-90}}),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-150,-90},{150,-150}}),
			Polygon(
				points={{-60,68},{90,10},{90,-10},{-60,-68},{-60,68}},
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid),
			Text(
				textString="V",
				extent={{-40,20},{0,-20}})}),
		Documentation(info="<html>
Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.
Coolant's temperature and enthalpy flow are not affected.<br>
Setting parameter m (mass of medium within fan/pump) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
Thermodynamic equations are defined by Partials.TwoPort.
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end VolumeFlow_unconditional;
