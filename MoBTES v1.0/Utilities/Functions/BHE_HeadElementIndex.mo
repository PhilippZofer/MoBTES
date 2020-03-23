within MoBTES.Utilities.Functions;
function BHE_HeadElementIndex "vector containing indices of outlet BHEs"
	extends Modelica.Icons.Function;
	input Real meshZ[:];
	input Real bheStart;
	output Integer bheHeadElementIndex;
	algorithm
		for z in 1:size(meshZ,1) loop
			if meshZ[z]>bheStart then
				bheHeadElementIndex:=z-1;
				break;				
			end if;
		end for;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
BHE_HeadElementIndex(meshZ,BHEstart) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns the vertical index of the global model elements that contain BHE heads.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong>	vertical model discretization</li>
<li><strong style=\"color:red\">Real</strong>	depth of BHE heads</li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Integer</strong>	vertical index of BHE head elements</li>
</ul>
</html>"));
end BHE_HeadElementIndex;
