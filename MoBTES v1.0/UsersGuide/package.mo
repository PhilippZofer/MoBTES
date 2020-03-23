within MoBTES;
package UsersGuide "User's Guide"
	extends Modelica.Icons.Information;
	class Acknowledgements "Acknowledgements"
		extends Modelica.Icons.Information;
		annotation(
			Documentation(info="<html>
<head>
<style type=\"text/css\">
a {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt;}
body, blockquote, table, p, li, dl, ul, ol {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; color: black;}
h3 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11pt; font-weight: bold;}
h4 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10pt; font-weight: bold;}
h5 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold;}
h6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 9pt; font-weight: bold; font-style:italic}
pre {font-family: Courier, monospace; font-size: 9pt;}
td {vertical-align:top;}
th {vertical-align:top;}
</style>
</head>

<h4><font color=\"#008000\" size=\"5\">Acknowledgements</font></h4>
<p>
<strong>This work was financially supported by:
</p>
<table border=1 cellpadding=10>
<tr><td><img src=\"c:\\users\\julian\\documents\\modelica\\mobtes\\UsersGuide\\ESE.png\" width=\"200\" ></td><td><p> German Research Foundation (DFG) Excellence Initiative</p> <p> <a href=\"https://www.ese.tu-darmstadt.de/graduate_school_ese/gsc_welcome/willkommen_1.en.jsp\"><strong>Darmstadt Graduate School of Excellence Energy Science and Engineering</strong></a> (GSC 1070)</p></td></tr>
<tr><td><img src=\"c:\\users\\julian\\documents\\modelica\\mobtes\\UsersGuide\\DGE-Rollout.png\" width=\"200\"></td><td><p>European Research Development Fund (ERDF)</p><p> Interreg North-West Europe <a href=\"https://www.nweurope.eu/projects/project-search/dge-rollout-roll-out-of-deep-geothermal-energy-in-nwe/\"><strong>DGE-Rollout</strong></a></p></td></tr>
</table>
</html>"),
			experiment(
				StopTime=1,
				StartTime=0,
				Interval=0.001),
			preferredView="info");
	end Acknowledgements;
	annotation(
		dateModified="2020-02-18 16:13:10Z",
		Documentation(info="<html>
<p>
The <strong>MoBTES</strong> (Modelica Thermal Energy Storage) library contains components for the simulation of underground thermal energy storage systems.
</p>
<p>
The library is structured as follows:
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr>
  <td><a href=\"modelica://MoBTES.Components\">Components</a></td>
  <td>Collection of components for the simulation of underground thermal energy storage systems. (e.g. borehole heat exchanger model, underground model,...)</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Parameters\">Parameters</a></td>
  <td>Collections of parameter records</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Utilities\">Utilities</a></td>
  <td>Collection of functions and enumerations which are used to create/assemble the model components.</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.Examples\">Examples</a></td>
  <td>Collection of examples to demonstrate the usage of the models.</td>
</tr>
<tr>
  <td><a href=\"modelica://MoBTES.UsersGuide\">UsersGuide</a></td>
  <td>Documentation of the library and its components.</td>
</tr>

</table>

</html>"),
		DocumentationClass=true);
end UsersGuide;
