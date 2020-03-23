within MoBTES.Examples.ExampleData;
record BenchmarkGrout "3D FEM benchmark study grout"
	extends Parameters.Grouts.GroutPartial(
		lamda=1.44,
		cp=1300,
		rho=1900);
end BenchmarkGrout;
