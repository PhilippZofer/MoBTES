within MoBTES.Components.UtilityComponents.FluidHeatFlow;
model BHEhydraulics "Pressure drop  and advective thermal resistances of BHEs"
	replaceable parameter Parameters.BoreholeHeatExchangers.DoubleU_DN32 BHEdata constrainedby MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters;
	replaceable parameter Modelica.Thermal.FluidHeatFlow.Media.Water BHEmedium constrainedby Modelica.Thermal.FluidHeatFlow.Media.Medium;
	Modelica.Blocks.Interfaces.RealInput volFlow(quantity="VolumeFlowRate") "volume flow of fluid" annotation(Placement(
		transformation(extent={{-20,-20},{20,20}}),
		iconTransformation(extent={{-120,-20},{-80,20}})));
	Modelica.Blocks.Interfaces.RealOutput R[3](each quantity="ThermalResistance") "thermal resistance" annotation(Placement(
		transformation(extent={{-10,-10},{10,10}}),
		iconTransformation(extent={{86.7,-10},{106.7,10}})));
	Modelica.Blocks.Interfaces.RealOutput dp "pressureDrop";
	outer parameter Real BHElength "characteristic Length";
	outer parameter Integer nBHEs;
	outer parameter Integer nSeries;
	protected
		parameter Real my=BHEmedium.rho*BHEmedium.nue;
		parameter Real Pr=MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Prandtl(my,BHEmedium.cp,BHEmedium.lamda) "Prandtl number";
		parameter Real dPipe1inner(
			quantity="Length",
			displayUnit="m")=BHEdata.dPipe1-2*BHEdata.tPipe1 "characteristic Length";
		parameter Real dPipe2inner(
			quantity="Length",
			displayUnit="m")=BHEdata.dPipe2-2*BHEdata.tPipe2 "characteristic Length";
		parameter Real dRef(
			quantity="Length",
			displayUnit="m")=dPipe2inner-BHEdata.dPipe1 "characteristic Length";
		Real Re[2] "Reynolds number";
		Real vFluid[2] "fluid velocity in pipe";
		Real Xi[2] "auxillary variable";
		Real gamma[2] "auxillary varibale";
		Real Nu[2] "Nusselt number";
	equation
		vFluid[1]=	MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.vFluid(max(abs(volFlow),Modelica.Constants.small),0,dPipe1inner);
		vFluid[2]=	if BHEdata.nShanks==0 then MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.vFluid(max(abs(volFlow),Modelica.Constants.small),BHEdata.dPipe1,dPipe2inner) else 0;
		Re[1]=		MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Reynolds(vFluid[1],dPipe1inner,BHEmedium.nue);
		Re[2]=		if BHEdata.nShanks==0 then MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Reynolds(vFluid[2],dRef,BHEmedium.nue) else 1;
		Xi[1]=		MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Xi(Re[1]);
		Xi[2]=		if BHEdata.nShanks==0 then MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Xi(Re[2]) else 1;
		gamma[1]=	MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Gamma(Re[1]);
		gamma[2]=	if BHEdata.nShanks==0 then MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Gamma(Re[2]) else 1;
		Nu[1]=MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Nusselt_pipe(dPipe1inner,gamma[1],BHElength,Pr,Re[1],Xi[1]);
		Nu[2]=if BHEdata.nShanks==0 then MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions.Nusselt_annularGap(BHEdata.dPipe1,dPipe2inner,gamma[2],BHElength,Pr,Re[2],Xi[2]) else 1;
		
		R[1]=1/(Nu[1]*BHEmedium.lamda*Modelica.Constants.pi);
		R[2]=if BHEdata.nShanks==0 then 1/(Nu[2]*BHEmedium.lamda*Modelica.Constants.pi)*dRef/BHEdata.dPipe1 else 1;
		R[3]=if BHEdata.nShanks==0 then 1/(Nu[2]*BHEmedium.lamda*Modelica.Constants.pi)*dRef/dPipe2inner else 1;
		dp=if BHEdata.nShanks==0 then nSeries*(UtilityFunctions.Zeta_pipe(Re[1])*BHElength/dPipe1inner*(BHEmedium.rho*vFluid[1]^2)/2+UtilityFunctions.Zeta_annularGap(Re[2])*BHElength/dRef*(BHEmedium.rho*vFluid[2]^2)/2) else nSeries*UtilityFunctions.Zeta_pipe(Re[1])*BHElength/dPipe1inner*(BHEmedium.rho*vFluid[1]^2)/2;
	annotation(
		Icon(graphics={
			Rectangle(
				pattern=LinePattern.None,
				fillColor={192,192,192},
				fillPattern=FillPattern.Backward,
				extent={{-90,70},{90,-70}}),
			Line(
				points={{-90,70},{-90,-70}},
				thickness=0.5),
			Line(
				points={{90,70},{90,-70}},
				thickness=0.5),
			Text(
				textString="%name",
				lineColor={0,0,255},
				extent={{-150,115},{150,75}}),
			Text(
				textString="G=%G",
				extent={{-150,-75},{150,-105}}),
			Line(
				points={{-76.7,16.7},{-33.3,46.7},{30,-10},{73.3,30},{73.3,30}},
				color={87,128,255},
				smooth=Smooth.Bezier,
				thickness=6),
			Line(
				points={{-76.5,-3.3},{-33.1,26.7},{30.2,-30},{73.5,10},{73.5,10}},
				color={87,128,255},
				smooth=Smooth.Bezier,
				thickness=6),
			Line(
				points={{-73.09999999999999,-26.6},{-29.7,3.4},{33.6,-53.3},{76.90000000000001,-13.3},{76.90000000000001,-13.3}},
				color={87,128,255},
				smooth=Smooth.Bezier,
				thickness=6)}),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.002,
			Solver(
				bOptimization=true,
				bBigObj=true,
				typename="MultiStepMethod2"),
			MaxInterval="0.001"));
end BHEhydraulics;
