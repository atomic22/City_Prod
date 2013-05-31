<link rel="stylesheet" href="catalog/view/theme/9responsive2_blue/stylesheet/flexslider.css" type="text/css" media="screen" />
<script src="catalog/view/theme/9responsive2_blue/stylesheet/jquery.flexslider-min.js"></script>
<script type="text/javascript">
	$(window).load(function() {
		$('.flexslider').flexslider();
	});
</script>
    

<div class="flexslider">
    <ul class="slides">
    <?php
        $count = 0;
        $html = "";
        foreach($banners as $banner)
        {
            if($banner['link'])
                $html .= "<li><a href='".$banner['link']."'><img src='".$banner['image']."' alt='".$banner['title']."' /></a></li>";
            else
                $html .= "<li><img src='".$banner['image']."' alt='".$banner['title']."' /></li>";
            $count += 1;
        }    
        echo $html;
        if($count == 1)
            echo $html;
    ?>
    </ul>
</div> 
<br /><br />