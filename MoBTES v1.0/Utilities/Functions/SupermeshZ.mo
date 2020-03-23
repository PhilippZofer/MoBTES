within MoBTES.Utilities.Functions;
function SupermeshZ "determines points of interest in depth (supermesh)"
	extends Modelica.Icons.Function;
	input Real BHEstart "depth of BHE head";
	input Real lengthUpperGroutSection;
	input Real BHELength "length of the bhe";
	input Real relativeModelDepth "model depth in relation to bhe bottom";
	input Real stratVector[:];
	output Real supermesh[:];
	protected
		Real pointsOfInterest[:] "vector containing the heights of the layer";
		Real BHEbottom=BHEstart+BHELength "depth of BHE bottom";
		Real groutChange=BHEstart+lengthUpperGroutSection;
		Integer indexMax "indexMax for determination vector length";
	algorithm
		//load depth of layer starts
				
				if size(stratVector,1)>1 then
					pointsOfInterest:=cat(1,{0},{sum(stratVector[j] for j in 1:i) for i in 1:(size(stratVector,1)-1)}); //prepend ground surface and delete end of stratigraphy 
				else
					pointsOfInterest:={0};
				end if;
			
				//insert BHEstart into vector
				for i in 1:size(stratVector,1) loop	//search through vector
					if pointsOfInterest[i]==BHEstart then	//if BHEstart falls on a layerchange no additional entry is necessary
					break;
					elseif pointsOfInterest[i]>BHEstart then	//if the vector entry is lager, BHEstart is inserted before the entry
					pointsOfInterest:=cat(1,{pointsOfInterest[j] for j in 1:i-1},{BHEstart},{pointsOfInterest[k] for k in i:size(stratVector,1)});
					break;
					elseif i==size(stratVector,1) then		//if no layerchange is bigger than BHEstart, BHEstart is appended
					pointsOfInterest:=cat(1,{pointsOfInterest[i] for i in 1:size(stratVector,1)},{BHEstart});
					end if;
				end for;
				
				//insert groutChange into vector
				indexMax:=size(pointsOfInterest,1);
				for i in 1:indexMax loop	//search through vector
					if pointsOfInterest[i]==groutChange then	//if groutChange falls on a layerchange no additional entry is necessary
					break;
					elseif pointsOfInterest[i]>groutChange then	//if vector entry i is larger, groutChange is inserted before the entry
					pointsOfInterest:=cat(1,{pointsOfInterest[j] for j in 1:i-1},{groutChange},{pointsOfInterest[k] for k in i:indexMax});
					break;
					elseif i==indexMax then		//if no layerchange is bigger than groutChange, groutChange is appended
					pointsOfInterest:=cat(1,pointsOfInterest,{groutChange});
					end if;
				end for;		
				
				//insert BHEbottom into vector
				indexMax:=size(pointsOfInterest,1);
				for i in 1:indexMax loop	//search through vector
					if pointsOfInterest[i]==BHEbottom then	//if BHEbottom falls on a layerchange no additional entry is necessary
					break;
					elseif pointsOfInterest[i]>BHEbottom then	//if vector entry i is larger, BHEbottom is inserted before the entry
					pointsOfInterest:=cat(1,{pointsOfInterest[j] for j in 1:i-1},{BHEbottom},{pointsOfInterest[k] for k in i:indexMax});
					break;
					elseif i==indexMax then		//if no layerchange is bigger than BHEbottom, BHEbottom is appended
					pointsOfInterest:=cat(1,pointsOfInterest,{BHEbottom});
					end if;
				end for;		
				
				//insert model bottom and determine size of chopped of part
				
					indexMax:=size(pointsOfInterest,1);
					for i in 1:indexMax loop	//search through vector
						if pointsOfInterest[i]==(BHEbottom*relativeModelDepth) then	//if model bottom falls on a layerchange no additional entry is necessary
							indexMax:=i;
							break;
						elseif pointsOfInterest[i]>(BHEbottom*relativeModelDepth) then	//if the vector entry is larger, model bottom is inserted before the entry
							pointsOfInterest:=cat(1,{pointsOfInterest[j] for j in 1:i-1},{(BHEbottom*relativeModelDepth)},{pointsOfInterest[k] for k in i:indexMax});
							indexMax:=i;
							break;
						elseif i==indexMax then		//if no layerchange is bigger than model bottom, model bottom is appended
							pointsOfInterest:=cat(1,{pointsOfInterest[i] for i in 1:indexMax},{(BHEbottom*relativeModelDepth)});
							indexMax:=indexMax+1;
						end if;
					end for;
			
				supermesh:={pointsOfInterest[i] for i in 1:indexMax};
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
supermesh:=SupermeshZ(BHEstart,BHELength,relativeModelDepth,stratVector) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns the supermesh for the vertical model discretization. The supermesh (boundary mesh) comprises all \"depths of interest\", i.e. changes in the model's parameters or geometry.
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real</strong> BHEstart	<i style=\"color:brown\">Depth of BHE heads [m]</i></li>
<li><strong style=\"color:red\">Real</strong> BHELength	<i style=\"color:brown\">Length of BHEs [m]</i></li>
<li><strong style=\"color:red\">Real</strong> relativeModelDepth	<i style=\"color:brown\">Desired depth of the model in relation to the borehole bottom.</i></li>
<li><strong style=\"color:red\">Real[:]</strong> stratVector	<i style=\"color:brown\">Array with thicknesses of all geological layers [m]</i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong> supermesh	<i style=\"color:brown\">Array with vertical model sections with constant parameters.</i></li>
</ul>
</html>"));
end SupermeshZ;
