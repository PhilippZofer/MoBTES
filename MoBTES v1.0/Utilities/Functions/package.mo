within MoBTES.Utilities;
package Functions "builder functions"
	extends Modelica.Icons.FunctionsPackage;
	annotation(Documentation(info="<html>
<p>
Collection of functions:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.BHE_HeadElementIndex\">BHE_HeadElementIndex</a></td>
  <td>Returns the depth-index of the volume element containing the BHE head</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.BHE_BottomElementIndex\">BHE_BottomElementIndex</a></td>
  <td>Returns the depth-index of the volume element containing the BHE bottom</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.ElementHeights\">ElementHeights</a></td>
  <td>Returns an array with the vertical discretization of the model</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.ElementGroundData\">ElementGroundData</a></td>
  <td>Returns a matrix that contains the thermal properties of each global model element</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.MeshR\">MeshR</a></td>
  <td>Returns an array with the radial mesh</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.nElementsZ\">nElementsZ</a></td>
  <td>Returns the vertical number of elements in the model (necessary input for the meshing function)</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.NumberOfBHERings\">NumberOfBHERings</a></td>
  <td>Returns the number of model rings that contain BHEs</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.NumberOfBHEsPerRing\">NumberOfBHEsPerRing</a></td>
  <td>Returns an array with the number of BHEs inside each model ring that contains BHEs</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.SupermeshZ\">SupermeshZ</a></td>
  <td>Returns an array with the vertical supermesh (boundary mesh), i.e. all depth levels with significant changes of the model (geology, BHEs)</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.xGroutCenter_2U\">xGroutCenter_2U</a></td>
  <td>Returns the relative positioning of the grout's center of mass inside the borehole for double-U BHEs</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities.Functions.xGroutCenter_1U\">xGroutCenter_1U</a></td>
  <td>Returns the relative positioning of the grout's center of mass inside the borehole for single-U BHEs</td>
</tr>
</table>

</html>"));
end Functions;
