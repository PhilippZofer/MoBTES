within MoBTES.Utilities.Functions;
function NumberOfBHEsPerRing "determines number of BHEs in ring"
	extends Modelica.Icons.Function;
	input Integer nBHEs "number of BHEs";
	input Integer nRings "number of rings to assign the BHEs to";
	output Integer BHEsPerRingVector[nRings] "vector containing the number of BHEs for each ring";
	protected
		Real hypotheticalRadii[nRings];
		Integer positionOfSmallestElement;
	algorithm
		for DoAllThis in 1:1 loop	
			BHEsPerRingVector:=fill(1,nRings); //start with one BHE in each ring
			/*distribute BHEs to the rings until all BHEs are added*/
			while sum(BHEsPerRingVector[i] for i in 1:nRings)<nBHEs loop
				/*hypothetically add one BHE to each ring and see how the radius would change*/
				hypotheticalRadii[1]:=sqrt(BHEsPerRingVector[1]+1);
				for iRad in 2:nRings loop
					hypotheticalRadii[iRad]:= sqrt(sum(BHEsPerRingVector[i] for i in 1:iRad)+1)-sqrt(sum(BHEsPerRingVector[i] for i in 1:(iRad-1)));
				end for;
				/*find the position of the smallest element*/
				for el in 1:nRings loop 
					if hypotheticalRadii[el]<=min(hypotheticalRadii) then
						positionOfSmallestElement:=el;
						break;
					end if;
				end for;
				/*add one BHE to the identified ring*/
				BHEsPerRingVector[positionOfSmallestElement]:=BHEsPerRingVector[positionOfSmallestElement]+1;
			end while;	
		end for;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
BHEsPerRingVector:=NumberOfBHEsPerRing(nBHEs,nRings) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Distributes a given number of BHEs to a given number of model rings/regions. The algorith tries to generate a distribution with rings of equal thickness.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer</strong> nBHEs	<i style=\"color:brown\">Total number of BHEs</i></li>
<li><strong style=\"color:red\">Integer</strong> nRings	<i style=\"color:brown\">Number of rings to distribute the BHEs to.</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer[:]</strong> BHEsPerRingVector	<i style=\"color:brown\">Array with the number of BHEs for each ring.</i></li>
</ul>
</html>"));
end NumberOfBHEsPerRing;
