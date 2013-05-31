<?include("docs/dbsession.php"); //includes content of session.php
$my_session = new dbsession();
$word = "default";
header("Location: /index.php");?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>City of Sun Prairie - Contact Us</title>
<meta name="generator" content="BBEdit 7.0.1">
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1">
<meta http-equiv="content-language" content="en">
<link rel="stylesheet" href="docs/css/main.css" type="text/css">
<script src="docs/includes/rollover.js" type="text/javascript" language="Javascript"></script>
<script language="javascript1.2" type="text/javascript" src="docs/js/init.js"></script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0" bgcolor="#333399">
<table border="0" cellpadding="0" cellspacing="0" align="center" width="754">
<tr><td valign="top" bgcolor="#ffffff" class="mainTable">
<? include "includes/header2.php"; ?>
<!-- Main Area Table =STARTS= Here -->
<table border="0" cellpadding="0" cellspacing="0" align="center" width="750">
<tr><td width="10"><img src="images/spacer1x1.gif" border="0" width="10" height="1"></td><td class="contentText">
<!-- Calendar Body =STARTS= Here -->
&nbsp;<br><span class="headlineText">Page Not Found</span><br>&nbsp;<br>
<a href="index.php">Return Home<a><p><br>&nbsp;</p><p><br>&nbsp;</p><p><br>&nbsp;</p><p><br>&nbsp;</p>
<!-- Calendar Body =ENDS= Here --></td></tr>
<tr><td colspan="2" bgcolor="#5061cc" align="center" class="footerCell"><p align="center" class="footerText">
<? include "docs/includes/footer.php"; ?></td></tr>
</table><!-- Main Area Table =ENDS= Here -->
</td></tr>
</table>
<!-- this goes at the bottom of each page just before the </body> tag 
-->
<p align="center"><img src="images/spacer_main-top754.gif" alt="" 
id="mainImage" name="mainImage" width="754" height="2" 
border="0"></p><br>
<script language="javascript1.2" type="text/javascript">
new getCoor('mainImage');
new ypSlideOutMenu("menu1", "down", 370, 66, 195, <?display_menu_length();?>);
</script>
<!-- this goes at the bottom of each page just before the </body> tag 
-->
</body>
</html>
<?

function display_menu_length(){
$DBResultx = mysql_query("select * from main inner join departments on main.department_id = departments.department_id where main.state = 1 and departments.department_id = 1 order by department") or die (mysql_error());
$numrowsx = mysql_num_rows($DBResultx);
$length = ($numrowsx * 15) + 2;
echo($length);
}
?>