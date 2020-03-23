within MoBTES.Parameters.Locations;
record TUDa "TU Darmstadt - Campus Lichtwiese"
	extends LocationPartial(
		Taverage=283.15,
		geoGradient=0.03,
		layers=2,
		redeclare replaceable parameter Soils.LiwiSoil strat1,
		redeclare replaceable parameter Soils.LiwiCrystalline strat2,
		layerThicknessVector={50,1000,1,1,1});
end TUDa;
