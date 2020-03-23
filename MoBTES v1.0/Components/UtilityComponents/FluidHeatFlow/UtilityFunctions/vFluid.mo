within MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions;
function vFluid "fluid velocity"
	extends Modelica.Icons.Function;
	input Real volFlow(quantity="VolumeFlowRate") "volume flow";
	input Real dInner(quantity="Length") "inner diameter";
	input Real dOuter(quantity="Length") "outer diameter";
	output Real velocity(quantity="Velocity") "volume flow velocity";
	algorithm
		// enter your algorithm here
		velocity:=volFlow/(Modelica.Constants.pi*(dOuter^2-dInner^2)/4);
end vFluid;
