within MoBTES.Parameters;
package Grouts "grout thermal properties"
	extends Modelica.Icons.Package;
	partial record GroutPartial "grout"
		extends Modelica.Icons.Record;
		parameter Real lamda(quantity="ThermalConductivity") "thermal conductivity of grout" annotation(Dialog(
			group="grout",
			tab="BTES"));
		parameter Real cp(
			quantity="SpecificHeatCapacity",
			displayUnit="kJ/(kg·K)") "thermal capacity of grout" annotation(Dialog(
			group="grout",
			tab="BTES"));
		parameter Real rho(quantity="Density") "density of grout" annotation(Dialog(
			group="grout",
			tab="BTES"));
	end GroutPartial;
	record Grout10 "Grout with low thermal conductivity (λ=1,0 W/m/K)"
		extends GroutPartial(
			lamda=1.0,
			cp=1300,
			rho=1900);
	end Grout10;
	record Grout15 "Grout with average thermal conductivity (λ=1,5 W/m/K)"
		extends GroutPartial(
			lamda=1.5,
			cp=1300,
			rho=1900);
	end Grout15;
	record Grout20 "Grout with high thermal conductivity (λ=2,0 W/m/K)"
		extends GroutPartial(
			lamda=2,
			cp=1300,
			rho=1900);
	end Grout20;
	record Grout05 "Grout with very low thermal conductivity (λ=0.5 W/m/K)"
		extends GroutPartial(
			lamda=1.0,
			cp=1300,
			rho=1900);
	end Grout05;
	record Grout_vW "van Waasen grout"
		extends GroutPartial(
			lamda=1.73,
			cp=842.3,
			rho=2600);
	end Grout_vW;
	record SKEWSgrout "SKEWS grout"
		extends GroutPartial(
			lamda=2,
			cp=2000,
			rho=1000);
	end SKEWSgrout;
	record SKEWSinsulatingGrout "SKEWS insulating grout"
		extends GroutPartial(
			lamda=0.25,
			cp=2000,
			rho=1000);
	end SKEWSinsulatingGrout;
	annotation(
		dateModified="2020-02-14 10:34:54Z",
		Documentation(info="<html>
<p>
Datasets containg information about the thermophysical parameters of different grouts
</p>

</html>"));
end Grouts;
