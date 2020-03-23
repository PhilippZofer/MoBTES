within MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions;
function Prandtl "Prandtl number"
	extends Modelica.Icons.Function;
	input Real dynamicViscosity(quantity="DynamicViscosity") "dynamic viscosity of fluid";
	input Real cRefrigerant(quantity="SpecificHeatCapacity") "heat capacity of refrigerant";
	input Real lambdaRefrigerant(quantity="ThermalConductivity") "thermal conductivity of refrigerant";
	output Real Pr "Prandtl Number";
	algorithm
		// enter your algorithm here
		Pr:= dynamicViscosity*cRefrigerant/lambdaRefrigerant;
end Prandtl;
