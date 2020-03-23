within MoBTES.Examples.ExampleData;
record BenchmarkSoil "3D FEM benchmark study soil"
	extends Parameters.Soils.SoilPartial(
		rho=2500,
		cp=1000,
		lamda=2);
end BenchmarkSoil;
