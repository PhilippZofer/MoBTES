within MoBTES.Components.UtilityComponents.FluidHeatFlow.UtilityFunctions;
function Nusselt_pipe "Nusselt number of inner pipe"
	extends Modelica.Icons.Function;
	input Real D(quantity="Length") "inner diameter of pipe";
	input Real gamma "auxillary variable gamma";
	input Real L(quantity="Length") "characteristic length";
	input Real Pr "Prandtl number";
	input Real Re "Reynolds number";
	input Real Xi "auxillary variable Xi";
	output Real Nu "nusselt number";
	algorithm
		// enter your algorithm here
		Nu:=if 
				(Re<2300) 
			then 
				4.364 
			else if 
				(Re >= 2300) 
			then 
				( (Xi/8*Re*Pr)/(1+12.7*sqrt(Xi/8)*(Pr^(2/3)-1))*(1+(D/L)^(2/3))  )
			else
				( (1-gamma)*4.364+gamma*( (0.0308/8*10^4*Pr)/(1+12.7*sqrt(0.0308/8)*(Pr^(2/3)-1))*(1+(D/L)^(2/3)) ) );
end Nusselt_pipe;
