within MoBTES.Utilities.Functions;
function BHE_BottomElementIndex "vector containing indices of outlet BHEs"
	extends Modelica.Icons.Function;
	input Real meshZ[:];
	input Real bheStart;
	input Real bheLength;
	output Integer bheBottomElementIndex;
	algorithm
		for z in 1:size(meshZ,1) loop
			if meshZ[z]>bheStart+bheLength then
				bheBottomElementIndex:=z-2;
				break;				
			end if;
		end for;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
BHE_BottomElementIndex(meshZ,BHEstart,BHElength) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns the vertical index of the global model elements that contain BHE bottom
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong>	vertical model discretization [m]</li>
<li><strong style=\"color:red\">Real</strong>	depth of BHE heads [m]</li>
<li><strong style=\"color:red\">Real</strong>	length of BHEs [m]</li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer</strong>	vertical index of BHE bottom elements</li>
</ul>
</html>"));
end BHE_BottomElementIndex;
