within MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions;
function Zeta_annularGap "pressure loss coefficient (VDI Wärmeatlas)"
	extends Modelica.Icons.Function;
	input Real Re "Reynolds number";
	output Real Zeta "Pressure loss coefficient";
	algorithm
		if Re<2300 then
			Zeta:=1.5*64/Re;
		else
			Zeta:=0.3164/(Re^(1/4));
		end if;
end Zeta_annularGap;
