within MoBTES.Utilities.Functions;
function ElementGroundData "determine type of ground for each element"
	extends Modelica.Icons.Function;
	input Real heightVector[:] "vector containing element heights";
	input Integer rings "how many rings";
	replaceable input MoBTES.Parameters.Locations.TUDa location constrainedby Parameters.Locations.LocationPartial "stratigraphy at location";
	output Real elementGroundDataMatrix[3,size(heightVector,1),rings] "=fill(Parameters.Ground.Soil(),size(heightVector,1),rings) vector containing Cp vor each element";
	protected
		Real cumStratDepth[location.layers] "vector containing absolute depths of ground layers";
		Real elementTotalDepth "utility parameter to store end depth of element";
		Real rhoMatrix[size(heightVector,1),rings];
		Real cpMatrix[size(heightVector,1),rings];
		Real lamdaMatrix[size(heightVector,1),rings];
	algorithm
		//create vector with layer depths
		for z in 1:location.layers-1 loop
		  cumStratDepth[z] := sum(location.layerThicknessVector[i] for i in 1:z);
		end for;
		cumStratDepth[location.layers]:= sum(heightVector[i] for i in 1:size(heightVector,1));
		//assign ground properties to element
		for z in 1:size(heightVector, 1) loop
		  elementTotalDepth := sum(heightVector[i] for i in 1:z);
		  for layerIndex in 1:location.layers loop
		    if elementTotalDepth <= cumStratDepth[location.layers - layerIndex + 1] then
		      for r in 1:rings loop
		        rhoMatrix[z, r] := location.rhoVector[location.layers - layerIndex + 1];
		        cpMatrix[z, r] := location.cpVector[location.layers - layerIndex + 1];
		        lamdaMatrix[z, r] := location.lamdaVector[location.layers - layerIndex + 1];
		      end for;
		    else
		      break;
		    end if;
		  end for;
		end for;
		elementGroundDataMatrix := {rhoMatrix, cpMatrix, lamdaMatrix};
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
elementGroundDataMatrix:=ElementGroundData(heightVector,rings,dZmin,growthFactor,outputSize) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns a matrix {rho[nZ,nR],cP[nZ,nR],lamda[nZ,nR]} which contains the thermphyiscal parameters of the model elements, where nZ is the vertical number of model elements and nR is the radial number.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong> heightVector	<i style=\"color:brown\">vertical discretization [m]</i></li>
<li><strong style=\"color:red\">Integer</strong> rings	<i style=\"color:brown\">number of radial elements</i></li>
<li><strong style=\"color:red\">MoBTES.Parameters.Locations.locationPartial</strong> location <i style=\"color:brown\">record with depths and themrophysical properties at the storage site</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[3,:,:]</strong> elementGroundDataMatrix	<i style=\"color:brown\">matrix with thermophysical model element properties</i></li>
</ul>
</html>"));
end ElementGroundData;
