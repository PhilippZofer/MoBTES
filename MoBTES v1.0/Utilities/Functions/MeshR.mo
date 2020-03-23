within MoBTES.Utilities.Functions;
function MeshR "vector with all inner radii"
	extends Modelica.Icons.Function;
	input Integer nBHEsPerRing[:] "number of rings containing BHEs";
	input Real referenceRadius "minimum radial difference";
	input Integer nElementsR "refinement parameter - 3:min refined/6:max refined";
	output Real radiiVector[nElementsR+1] "vector containing mesh radii for the global solution";
	algorithm
		for doAllThis in 1:1 loop
			radiiVector[1]:=0.0;
			for r in 1:nElementsR loop
				if r<=size(nBHEsPerRing,1) then
					radiiVector[r+1]:=referenceRadius*sqrt(sum(nBHEsPerRing[i] for i in 1:r));
				elseif r<=size(nBHEsPerRing,1)+3 then
					radiiVector[r+1]:=radiiVector[r]+(radiiVector[r]-radiiVector[r-1]);
				else
					radiiVector[r+1]:=radiiVector[r]+(radiiVector[r]-radiiVector[r-1])*sqrt(2);
				end if;
			end for;
		end for;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
radiiVector:=MeshR(nBHEsPerRing,referenceRadius,nElementsR) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns an array with the radial mesh of the model.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer[:]</strong> nBHEsPerRing	<i style=\"color:brown\">Array with the number of BHEs inside the model rings which do contain BHEs</i></li>
<li><strong style=\"color:red\">Real</strong> referenceRadius	<i style=\"color:brown\">Radius of the local model (resulting in an equal area/BHE as the actual rectangular/cylindircal/hexagonal layout</i></li>
<li><strong style=\"color:red\">Integer</strong> nElementsR <i style=\"color:brown\">Total number of radial elements</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong> radiiVector	<i style=\"color:brown\">Radial mesh</i></li>
</ul>
</html>"));
end MeshR;
