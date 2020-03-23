within MoBTES.Components.UtilityComponents.FluidHeatFlow;
model SimpleHeatedPipe "Pipe with heat exchange without pressure calculation"
	extends SimpleTwoPort;
	Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(Placement(
		transformation(extent={{-10,-110},{10,-90}}),
		iconTransformation(extent={{-10,-110},{10,-90}})));
	equation
		// energy exchange with medium
		Q_flow = heatPort.Q_flow;
		// defines heatPort's temperature
		heatPort.T = T_q;
	annotation(
		Icon(graphics={
			Rectangle(
				lineColor={255,0,0},
				fillColor={0,0,255},
				fillPattern=FillPattern.Solid,
				extent={{-90,20},{90,-20}}),
			Text(
				textString="%name",
				extent={{-150,100},{150,40}}),
			Polygon(
				points={{-10,-90},{-10,-40},{0,-20},{10,-40},{10,-90},{-10,
				-90}},
				lineColor={255,0,0})}),
		Documentation(info="<html>
Pipe with heat exchange.<br>
Thermodynamic equations are defined by Partials.TwoPort.<br>
Q_flow is defined by heatPort.Q_flow.<br>
<b>Note:</b> Setting parameter m (mass of medium within pipe) to zero
leads to neglection of temperature transient cv*m*der(T).<br>
<b>Note:</b> Injecting heat into a pipe with zero mass flow causes
temperature rise defined by storing heat in medium's mass.
</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001,
			Solver(
				bOptimization=true,
				bBigObj=true,
				typename="MultiStepMethod2")));
end SimpleHeatedPipe;
