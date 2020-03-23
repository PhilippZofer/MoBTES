within MoBTES.Utilities.Functions;
function xGroutCenter_1U "determine grout center for single-U BHE"
	extends Modelica.Icons.Function;
	input Parameters.BoreholeHeatExchangers.SingleU_DN32 bheData=MoBTES.Parameters.BoreholeHeatExchangers.SingleU_DN32() "number of rings containing BHEs";
	input Parameters.Grouts.Grout10 groutData=MoBTES.Parameters.Grouts.Grout10();
	output Real xGroutCenter "Relative position of grout mass center.";
	protected
		Real xGuess=log(sqrt(bheData.dBorehole^2+2*bheData.dPipe1^2)/(2*bheData.dPipe1))/log(bheData.dBorehole/(sqrt(2)*bheData.dPipe1)) "auxillary variable for grout centre of mass";
		Real R_grout_spec=Modelica.Math.acosh((bheData.dBorehole^2+bheData.dPipe1^2-bheData.spacing^2)/(2*bheData.dBorehole*bheData.dPipe1))/(2*Modelica.Constants.pi*groutData.lamda)*(1.601-0.888*bheData.spacing/bheData.dBorehole);
		Real R_pipeToPipe_spec=Modelica.Math.acosh((2*bheData.spacing^2-bheData.dPipe1^2)/(bheData.dPipe1^2))/(2*Modelica.Constants.pi*groutData.lamda);
		Real R_groutToWall=(1-xGuess)*R_grout_spec;
		Real R_groutToGrout=((2*(1-xGuess)*R_grout_spec*(R_pipeToPipe_spec-2*xGuess*R_grout_spec))/(2*(1-xGuess)*R_grout_spec-R_pipeToPipe_spec+2*xGuess*R_grout_spec));
		Boolean changeFlag=false "=true, if xGrout is adapted";
	algorithm
		xGuess:=log(sqrt(bheData.dBorehole^2+4*bheData.dPipe1^2)/(2*sqrt(2)*bheData.dPipe1))/log(bheData.dBorehole/(2*bheData.dPipe1));
		R_grout_spec:=Modelica.Math.acosh((bheData.dBorehole^2+bheData.dPipe1^2-bheData.spacing^2)/(2*bheData.dBorehole*bheData.dPipe1))/(2*Modelica.Constants.pi*groutData.lamda)*(1.601-0.888*bheData.spacing/bheData.dBorehole);
		R_pipeToPipe_spec:=Modelica.Math.acosh((2*bheData.spacing^2-bheData.dPipe1^2)/(bheData.dPipe1^2))/(2*Modelica.Constants.pi*groutData.lamda);
		R_groutToWall:=(1-xGuess)*R_grout_spec;
		R_groutToGrout:=((2*(1-xGuess)*R_grout_spec*(R_pipeToPipe_spec-2*xGuess*R_grout_spec))/(2*(1-xGuess)*R_grout_spec-R_pipeToPipe_spec+2*xGuess*R_grout_spec));
		if ((1/R_groutToGrout+0.5/R_groutToWall)^(-1) < 0) then
			Modelica.Utilities.Streams.print("BHE pipes too close to borehole wall for model --> autoadjustement:\n original xGroutCenter: "+String(xGuess),"");
			changeFlag:=true;
		end if;	
		while ((1/R_groutToGrout+0.5/R_groutToWall)^(-1) < 0)and xGuess <0.99 loop
			xGuess:=if 1/R_groutToGrout > 0.5/R_groutToWall then min(0.99,xGuess+0.05) else max(0.01,xGuess-0.05);
			R_groutToWall:=(1-xGuess)*R_grout_spec;
			R_groutToGrout:=((2*(1-xGuess)*R_grout_spec*(R_pipeToPipe_spec-2*xGuess*R_grout_spec))/(2*(1-xGuess)*R_grout_spec-R_pipeToPipe_spec+2*xGuess*R_grout_spec));
		end while;	
		if changeFlag then
			Modelica.Utilities.Streams.print("Final xGrout: "+String(xGuess),"");
		end if;
		xGroutCenter:=xGuess;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
xGroutCenter:=xGroutCenter_1U(bheData,groutData) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns the relative position of the center of mass for the grout sections for single-U BHEs. The algorithm ensures that the thermal resistance between the grout sections is positive (see Bauer 2011: Zur thermischen Modellierung von Erdwärmesonden und Erdsonden-Wärmespeichern). If the position of the grout is adjusted, a warning is given.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">MoBTES.Parameters.BoreholeHeatExchangers.BHEparameters</strong> bheData	<i style=\"color:brown\">BHE dataset</i></li>
<li><strong style=\"color:red\">MoBTES.Parameters.Grouts.GroutPartial</strong> groutData	<i style=\"color:brown\">Grout dataset</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real</strong> xGroutCenter	<i style=\"color:brown\">Relative position of the grout's center of mass (0 < x < 1). </i></li>
</ul>
</html>"));
end xGroutCenter_1U;
