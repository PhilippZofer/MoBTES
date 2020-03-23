within MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions;
function Reynolds "Reynolds number"
	extends Modelica.Icons.Function;
	input Real velocity(quantity="Velocity") "volume flow velocity";
	input Real diameter(quantity="Length") "diameter of pipe or annular gap";
	input Real nue(quantity="KinematicViscosity") "dynamic viscosity of refrigerant";
	output Real Re "Reynolds number";
	algorithm
		// enter your algorithm here
		Re:= velocity*diameter/nue;
end Reynolds;
