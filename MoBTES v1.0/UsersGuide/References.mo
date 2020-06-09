// CP: 65001
// SimulationX Version: 4.1.2.63886 x64
within MoBTES.UsersGuide;
class References "References"
	extends Modelica.Icons.References;
	annotation(
		Documentation(info="<html>
<h4>References</h4>
<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">
    
    <tr>
      <td><a href=\"http://elib.uni-stuttgart.de/opus/volltexte/2012/6967/ \">[Bauer2012]</a></td>
      <td>D. Bauer
        &quot;Zur thermischen Modellierung von Erdwärmesonden und Erdsonden-Wärmespeichern,&quot;
        <em>Dissertation</em>,
        Stuttgart, Germany, 2012.</td>
    </tr>
    <tr>
      <td>[Franke1998]</td>
      <td>R.Franke
        &quot;Integrierte dynamische Modellierung und Optimierung von Systemen mit saisonaler Wärmespeicherung,&quot;
        <em>Book series</em>,
        in Fortschrittberichte VDI : Reihe 6, Energietechnik Nr. 394, VDI-Verlag,Düsseldorf, Germany, 1998</td>
    </tr>
    <tr>
      <td><a href=\"https://doi.org/10.1016/j.renene.2016.12.011\">[Tordrup2017]</a></td>
      <td>K.W. Tordrup, S.E. Poulsen, and H.Bjørn
        &quot;An improved method for upscaling borehole thermal energy storage using inverse finite element modelling,&quot;
        <em>Renewable Energy</em>,
        vol. 105, pp. 13-21, 2017.</td>
    </tr>
   
    <tr>
      <td><a href=\"http://planenergi.dk/wp-content/uploads/2018/05/15-10496-Slutrapport-Boreholes-in-Br%C3%A6dstrup.pdf\">[Sørensen2013]</a></td>
      <td>P.A. Sørensen, J. Larsen, L. Thøgersen, J. Dannemand Andersen, C. Østergaard, T. Schmidt,
        &quot;Boreholes in Brædstrup&quot;,
      PlanEnergi,Brædstrup Totalenergianlæg, Via University College, GEO, Per Aarsleff and Solites prepared for ForskEL (2010-1-10498) and EUDP (64012-0007-1) Final Report, June 2013</td>
    </tr>
</table>

</html>"),
		experiment(
			StopTime=1,
			StartTime=0,
			Interval=0.001));
end References;
