﻿within MoBTES.Examples.ExampleData;
record BenchmarkLocation "3D FEM benchmark study location"
	extends Parameters.Locations.LocationPartial(
		Taverage=283.15,
		geoGradient=0.03,
		layers=1,
		redeclare replaceable parameter BenchmarkSoil strat1,
		layerThicknessVector={1000,1,1,1,1});
end BenchmarkLocation;
