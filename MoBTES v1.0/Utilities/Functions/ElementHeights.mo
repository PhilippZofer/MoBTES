within MoBTES.Utilities.Functions;
function ElementHeights "function for the vertical model discretization"
	extends Modelica.Icons.Function;
	input Real supermesh[:];
	input Integer nx "axial refinement parameter - choose between 3-6";
	input Real dZmin "desired smallest vertical discretization";
	input Real growthFactor;
	input Integer outputSize;
	output Real heightVector[outputSize] "number of elements for axial refinement";
	protected
		Real deltaSupermesh[size(supermesh,1)-1] "vector conatining max depth of each layer";
		Integer cutNelements "counter for how many elements should be cut at the end";
		Real deltaZmin "minimum axial element size";
		Real nxActual[:] "number of elements for each half deltaSupermesh";
		Real usedSpace "dummyvariable for the spce already filled in a segment";
		Integer numberOfElements "counts the number of elements";
	algorithm
			for iDummy in 1:1 loop //necessary to force GSA to execute whole function
					
		/* delta supermesh of interest----------------------------------------------------------------------------*/
				
				deltaSupermesh:={supermesh[2]-supermesh[1]};
				for i in 2:(size(supermesh,1)-1) loop
					deltaSupermesh:=cat(1,deltaSupermesh,{supermesh[i+1]-supermesh[i]});
				end for;
					deltaSupermesh[size(supermesh,1)-1]:=2*deltaSupermesh[size(supermesh,1)-1];
				/* calculation of the element heights----------------------------------------------------------------------------*/
				//initialize
						heightVector:={0.0};
						numberOfElements:=1; //iterator for the element number offset of each segment
						/*determine deltaZmin by considering regular discretiation of the biggest segment or take the smallest segment as deltaZmin if this is smaller*/
						deltaZmin:=min(min(min(deltaSupermesh),max(deltaSupermesh)/2*(growthFactor-1)/(growthFactor^nx-1)),dZmin);	
						nxActual:=fill(0,size(deltaSupermesh,1));
						
						/* seperate discretization for each segment*/
						for i_segment in 1:size(deltaSupermesh,1) loop
						cutNelements:=0;
						
						/*determine for every segment how much elements fit into it without rounding*/
								nxActual[i_segment]:=log((2*deltaZmin-deltaSupermesh[i_segment]+growthFactor*deltaSupermesh[i_segment])/(2*deltaZmin))/log(growthFactor); 
							/*segment size below 2 times deltazMin */
							if deltaSupermesh[i_segment]<=growthFactor*deltaZmin then
								heightVector:=cat(1,heightVector,{deltaSupermesh[i_segment]});
								numberOfElements:=numberOfElements+1;
					
							/* segment can be discretized by regular scheme without rest*/
							elseif 	integer(nxActual[i_segment])==nxActual[i_segment] then //check weither segment can be discretized by "regular" scheme 
								
								for i_element in 0:(integer(nxActual[i_segment])-1) loop
									heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^i_element});
									numberOfElements:=numberOfElements+1;
								end for;
								for i_element in 0:(integer(nxActual[i_segment])-1) loop
									heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^(integer(nxActual[i_segment])-1-i_element)});
									numberOfElements:=numberOfElements+1;
									cutNelements:=cutNelements+1;
								end for;
		
							else
								
								usedSpace:=0;		//space already used in the current segment
							/*regular scheme first half with elements from deltaZmin to deltaZmax*/
								for i_element in 0:(integer(nxActual[i_segment])-1) loop
									heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^i_element});
									usedSpace:=usedSpace+deltaZmin*growthFactor^i_element;
									numberOfElements:=numberOfElements+1;
								
									
								end for;
							/*middle elements*/
							/*remaining rest of the regular scheme will be a) added to the biggest elements b) covered by one extra element or c) two elements*/
								/*a) rest is smaller than deltaZmax/growthFactor*/
								if deltaSupermesh[i_segment]-2*usedSpace < deltaZmin*growthFactor^(integer(nxActual[i_segment])-2) then
									
									heightVector[numberOfElements]:=heightVector[numberOfElements]+deltaSupermesh[i_segment]/2-usedSpace;
									heightVector:=cat(1,heightVector,{heightVector[numberOfElements]});
									numberOfElements:=numberOfElements+1;
									cutNelements:=cutNelements+1;
								/*b) rest is smaller than deltaZmax*growthFactor and put into one extra element*/
								elseif deltaSupermesh[i_segment]-2*usedSpace < deltaZmin*growthFactor^(integer(nxActual[i_segment])) and i_segment<size(deltaSupermesh,1) then
									
									heightVector:=cat(1,heightVector,{deltaSupermesh[i_segment]-2*usedSpace});
									numberOfElements:=numberOfElements+1;
									heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^(integer(nxActual[i_segment])-1)});
									numberOfElements:=numberOfElements+1;
								/*c) rest is put into two segments*/
								else
									
									heightVector:=cat(1,heightVector,{deltaSupermesh[i_segment]/2-usedSpace});
									numberOfElements:=numberOfElements+1;
									heightVector:=cat(1,heightVector,{deltaSupermesh[i_segment]/2-usedSpace});
									numberOfElements:=numberOfElements+1;
									cutNelements:=cutNelements+1;
									heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^(integer(nxActual[i_segment])-1)});
									numberOfElements:=numberOfElements+1;
									cutNelements:=cutNelements+1;
									
								end if;
								/*second part of the reggular scheme, starting with second biggest element, since biggest has been added in the part above*/
								if integer(nxActual[i_segment])>=2 then
									for i_element in 1:(integer(nxActual[i_segment])-1) loop
										heightVector:=cat(1,heightVector,{deltaZmin*growthFactor^(integer(nxActual[i_segment])-1-i_element)});
										numberOfElements:=numberOfElements+1;
										cutNelements:=cutNelements+1;
										
									end for;	
								end if;
							end if;	
						
						if i_segment == size(deltaSupermesh,1) then
							heightVector:={heightVector[k] for k in 2:(size(heightVector,1)-cutNelements)};
							
						end if;
						end for;
						
						end for;
	annotation(Documentation(info="<html>
<h4>
<strong>Syntax</strong>
</h4>
<p>
ElementHeights(supermesh,nx,dZmin,growthFactor,outputSize) 
</p>
<h4>
<strong>Description</strong>
</h4>
<p>
Returns an array with the heights of the global model elements from top to bottom
</p>
<h4>
<strong>Input arguments</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong> supermesh	<i style=\"color:brown\">vertical supermesh (boundary mesh) [m]</i></li>
<li><strong style=\"color:red\">Integer</strong> nx	<i style=\"color:brown\">discretiaztion factor</i></li>
<li><strong style=\"color:red\">Real</strong> dZmin	<i style=\"color:brown\">desired size of smallest element [m]</i></li>
<li><strong style=\"color:red\">Real</strong> growthFactor	<i style=\"color:brown\">relative size difference between adjoining elements</i></li>
<li><strong style=\"color:red\">Integer</strong> outputSize	<i style=\"color:brown\">dimension of the output array/ number of vertical elements </i></li>
</ul>
<h4>
<strong>Outputs</strong>
</h4>
<ul>
<li><strong style=\"color:red\">Real[:]</strong> heightVector	<i style=\"color:brown\">vertical model discretization [m]</i></li>
</ul>
</html>"));
end ElementHeights;
