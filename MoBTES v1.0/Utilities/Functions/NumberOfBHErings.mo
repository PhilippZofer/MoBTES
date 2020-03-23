within MoBTES.Utilities.Functions;
function NumberOfBHErings "determines how many rings with BHEs are used"
	extends Modelica.Icons.Function;
	input Integer nBHEs "ring number";
	output Integer nRings "number of BHEs in ring";
	protected
		Integer iRing;
		Integer nBHEsUsed;
	algorithm
		if nBHEs <=3 then
			nRings:=1;
		else
			iRing:=1;
			nBHEsUsed:=1;
			while nBHEsUsed<nBHEs loop
				iRing:=iRing+1;
				nBHEsUsed:=nBHEsUsed+integer(2*Modelica.Constants.pi*(iRing-1));
			end while;
			nRings:=iRing;
		end if;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
nRings:=NumberOfBHErings(nBHEs) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns the number of BHE rings the model uses. For each ring only one characteristic BHE is simulated. This function is only used for parallel BHE connection.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer</strong> nBHEs	<i style=\"color:brown\">Total number of BHEs</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer</strong> nRings	<i style=\"color:brown\">Number of rings that contain BHEs</i></li>
</ul>
</html>"));
end NumberOfBHErings;
