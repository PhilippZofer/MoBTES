﻿within MoBTES.Examples.ExampleData;
record BraedstrupLocation "Brædstrup BTES location with 1 layers (Tordrup et al. 2017)"
	extends Parameters.Locations.LocationPartial(
		Taverage=281.14999999999998,
		geoGradient=0.0,
		layers=2,
		redeclare replaceable parameter Parameters.Soils.Soil strat1(
			rho=1960,
			cp=1000,
			lamda=1.72*0.5+0.12*0.5),
		redeclare replaceable parameter Parameters.Soils.Soil strat2(
			rho=1960,
			cp=1000,
			lamda=1.72),
		layerThicknessVector={1,1000,1,1,1});
end BraedstrupLocation;
