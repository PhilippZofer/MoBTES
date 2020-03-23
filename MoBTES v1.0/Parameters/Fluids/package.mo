within MoBTES.Parameters;
package Fluids "heat carrier fluid data"
	extends Modelica.Icons.Package;
	record fluidData "heat carrier fluid"
		extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
			rho=995.6,
			cp=4000,
			cv=4000,
			lamda=0.615,
			nue=0.3E-6);
		annotation(Documentation(info="<html>
Medium: properties of water
</html>"));
	end fluidData;
	record fluidData_vW "heat carrier fluid van waasen"
		extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
			rho=996.5,
			cp=4194,
			cv=4194,
			lamda=0.58,
			nue=0.3E-6);
		annotation(Documentation(info="<html>
Medium: properties of water
</html>"));
	end fluidData_vW;
	record SKEWSfluid "SKEWS heat carrier fluid"
		extends Modelica.Thermal.FluidHeatFlow.Media.Medium(
			rho=977,
			cp=4145,
			cv=4145,
			lamda=0.65,
			nue=0.5E-6);
		annotation(Documentation(info="<html>
Medium: properties of water
</html>"));
	end SKEWSfluid;
	annotation(
		dateModified="2020-02-14 10:35:35Z",
		Documentation(info="<html>
<p>
Datasets containg information about the thermophysical parameters of different heat carrier fluids
</p>

</html>"));
end Fluids;
